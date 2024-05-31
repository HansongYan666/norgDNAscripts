

mkdir result_junc
cd result_junc

## link blast results
ln -s /PATH/NUMT_NUPT/blast_result/*.blast .
ln -s /PATH/NUMT_NUPT/blast_result/*.blast .
ln -s /PATH/NUMT_NUPT/blast_result/*.blast .

## generate common and uniq bed files
for i in {Shuang,Dan}; do for j in {chlo,mit}; do echo "python detect_juct_py2_V2.py -bam ../bam/$i.bam -blast $i.$j.blast -jl 50 -num 3 -prefix $i.$j.cov" > run"_"$i"_"$j.sh; done; done;

