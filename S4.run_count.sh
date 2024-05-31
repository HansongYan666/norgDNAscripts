mkdir num_count
cd num_count
ln -s ../plot_junc/*.data .
#for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'common' | awk '{ sum += $6 } END { print sum / NR }' > $i.$j.common.ident.txt; done; done;
#for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'uniq' | awk '{ sum += $6 } END { print sum / NR }' > $i.$j.uniq.ident.txt; done; done;
#for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data | awk '{ sum += $6 } END { print sum / NR }' > $i.$j.ident.txt; done; done;


for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'common' | wc -l |  awk -v i="$i" -v j="$j" '{ print i"."j".common",$0 }' > $i.$j.common.num.txt; done; done;
for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'uniq' |wc -l |  awk -v i="$i" -v j="$j" '{ print i"."j".uniq",$0 }' > $i.$j.uniq.num.txt; done; done;
for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | wc -l |  awk -v i="$i" -v j="$j" '{ print i"."j".all",$0}' > $i.$j.all.num.txt; done; done;

cat *.txt > num.txt
