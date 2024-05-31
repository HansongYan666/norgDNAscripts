mkdir ident_count
cd ident_count
ln -s ../plot_junc/*.data .
#for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'common' | awk '{ sum += $6 } END { print sum / NR }' > $i.$j.common.ident.txt; done; done;
#for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'uniq' | awk '{ sum += $6 } END { print sum / NR }' > $i.$j.uniq.ident.txt; done; done;
#for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data | awk '{ sum += $6 } END { print sum / NR }' > $i.$j.ident.txt; done; done;


for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'common' | awk '{ sum += $6 } END { print sum / NR }' |  awk -v i="$i" -v j="$j" '{ print i"."j".common",$0 }' > $i.$j.common.iden.txt; done; done;
for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | grep 'uniq' | awk '{ sum += $6 } END { print sum / NR }' |  awk -v i="$i" -v j="$j" '{ print i"."j".uniq",$0 }' > $i.$j.uniq.iden.txt; done; done;
for i in {Dan,Shuang}; do for j in {chlo,mit}; do less  $i.$j.data  | awk '{ sum += $6 } END { print sum / NR }' |  awk -v i="$i" -v j="$j" '{ print i"."j".all",$0}' > $i.$j.all.iden.txt; done; done;

cat *.txt > count.txt
