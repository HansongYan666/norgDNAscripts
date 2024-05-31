
mkdir blast_result
cd blast_result

## run blast,mitogenome sequences as the query and nuclear genome sequences as the subject.

makeblastdb -in Dan.chr.fasta -out Dan.chr.fasta -dbtype nucl

blastn -query Dan.mit.fasta -db Dan.chr.fasta -out Dan.mit.blast -evalue 1e-5 -outfmt 6
blastn -query  Dan.chloroplast.fasta -db Dan.chr.fasta -out Dan.chlo.blast -evalue 1e-5 -outfmt 6
