# 25% 50% 75% 95% mean
set terminal png size 1000, 650 \
    xffffff x000000 \
    xff0000 xff0000 xff0000 xffcccc xff3333 \
    x0000ff x0000ff x0000ff xccccff x3333ff

set output "median_middelvaerdi_forskel.png"

set title 'Forskel på median og middelværdi (gennemsnit) for indkomst fordelt på køn og alder'

set xlabel 'Alder'
set ylabel 'Median og middelværdi forskel i procent for personlig indkomst'

set datafile separator " "

#set xrange [ 0 : 250 ]
#set yrange [ 0 : ]
set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"
set format y '%2.0f%%

plot 'Kvinde.dat' using 1:(($6-$3)/$3*100) with lines lw 2 lc 6 title 'Kvinde (middelværdi og median forskel)', \
     'Mand.dat' using 1:(($6-$3)/$3*100) with lines lw 2 lc 1 title 'Mand (middelværdi og median forskel)';
