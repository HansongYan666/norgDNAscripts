import sys,os
import pysam
import argparse
from collections import defaultdict


def detect_juction_site(bamfile, blastfile, outprefix, juction_length, readnum_cutoff):
    blast = open(blastfile)
    juction_length = int(juction_length)
    readnum_cutoff = int(readnum_cutoff)
    bam = pysam.AlignmentFile(bamfile, "rb")
    outcommon = open(outprefix+ ".common.bed", "w")
    outuniq = open(outprefix+".uniq.bed", "w")
    commonlist = []
    dic_common = defaultdict(dict)
    dic_uniq = defaultdict(dict)
    uniqlist = []
    for line in blast:
        if line.startswith("#"):
            continue
        tmp = line.rstrip().split("\t")
        chrom = tmp[1]
        start = int(tmp[8])
        end = int(tmp[9])
        counts_juctions_reads_left = 0
        counts_juctions_reads_right = 0
        for read in bam.fetch(chrom, start - 1, start):
            refstart = read.reference_start
            #print(refstart)
            refend = read.reference_end
            if start - 1 - refstart > juction_length and refend - (start - 1) > juction_length:
                counts_juctions_reads_left += 1
            else:
                continue
        for read in bam.fetch(chrom, end - 1, end):
            refstart = read.reference_start
            refend = read.reference_end
            if end - 1 - refstart > juction_length and refend - (end - 1) > juction_length:
                counts_juctions_reads_right += 1
            else:
                continue
        beg = min([start, end])
        stop = max([start, end])
        if counts_juctions_reads_left> readnum_cutoff and counts_juctions_reads_right > readnum_cutoff:
            if chrom not in dic_common:
                dic_common[chrom] = [[beg, stop]]
            else:
                if [beg, stop] in dic_common[chrom]:
                    continue
                dic_common[chrom].append([beg, stop])
        else:
            if chrom not in dic_uniq:
                dic_uniq[chrom] = [[beg, stop]]
            else:
                if [beg, stop] in dic_uniq[chrom]:
                    continue
                dic_uniq[chrom].append([beg, stop])
    for chrom in sorted(dic_common.keys()):
        for info in sorted(dic_common[chrom]):
            start, end = info
            outline = "%s\t%s\t%s\n"%(chrom, start, end)
            outcommon.write(outline)
    
    for chrom in sorted(dic_uniq.keys()):
        for info in sorted(dic_uniq[chrom]):
            start, end = info
            outline = "%s\t%s\t%s\n"%(chrom, start, end)
            outuniq.write(outline)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="script for detect juction site")
    parser.add_argument("-bam", help = "the input bamfile", required = True,dest = "bam")
    parser.add_argument("-blast", help = "the blast result for detect juction site....", required = True, dest="blast")
    parser.add_argument("-jl", help="the juction site left and right length of juction read....default=500", default=500, dest="jl")
    parser.add_argument("-num", help="the cutoff of the number of juction reads....default=3", default=3, dest="num")
    parser.add_argument("-prefix", help="the output file prefix....", required=True, dest = "prefix")
    args = parser.parse_args()
    bamfile = args.bam
    blastfile = args.blast
    juction_length = args.jl
    readnum_cutoff = args.num
    outprefix = args.prefix
    detect_juction_site(bamfile, blastfile, outprefix, juction_length, readnum_cutoff)
    
    
    