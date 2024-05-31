mkdir plot_junc
cd plot_junc

### generate data
for i in {Dan,Shuang}; do for j in {chlo,mit}; do gen_data.py ../result_junc/$i.$j.cov.common.bed,../result_junc/$i.$j.cov.uniq.bed ../blast/$i.$j.blast 90 $i.$j.data; done; done;
### uniq data
for i in {Dan,Shuang}; do for j in {chlo,mit}; do uniq $i.$j.data > $i.$j.uniq.data; done; done;
### get plot chr length
get_chr_len.py ../bam/Dan.chr.fasta Dan.len T
get_chr_len.py ../bam/Shuang.chr.fasta Shuang.len T


### plot
for i in {Dan,Shuang}; do for j in {chlo,mit}; do plot_data_V9.py $i.$j.uniq.data $i.len $i.$j.pdf; done; done;
cd ..
