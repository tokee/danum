# 25% 50% 75% 95% mean
set terminal png size 1000, 650 \
    xffffff x000000 \
    xff0000 xff0000 xff0000 xffcccc xff3333 \
    x0000ff x0000ff x0000ff xccccff x3333ff \
    x00ff00 xff00ff

set output "indkomst_forskel.png"

set title 'Forskel på mænd og kvinders indkomst i procent'

set xlabel 'Alder'
set ylabel 'Forskel i procent for personlig indkomst'

set datafile separator " "

#set xrange [ 0 : 250 ]
#set yrange [ 0 : ]
set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"
set format y '%2.0f%%

# 1: age
# 3: median
# 6: mean
# +6 to get Mand
plot 'KvindeMand.dat' using 1:(($9-$3)/$3*100) with lines lw 2 lc 10 title '(M-K)/K median', \
     'KvindeMand.dat' using 1:(($12-$6)/$6*100) with lines lw 2 lc 11 title '(M-K)/K mean';
