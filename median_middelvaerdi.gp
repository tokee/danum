# 25% 50% 75% 95% mean
set terminal png size 1000, 650 \
    xffffff x000000 \
    xff0000 xff0000 xff0000 xffcccc xff3333 \
    x0000ff x0000ff x0000ff xccccff x3333ff

set output "median_middelvaerdi.png"

set title 'Median og middelværdi (gennemsnit) for indkomst fordelt på køn og alder'

set xlabel 'Alder'
set ylabel 'Personlig indkomst'

set datafile separator " "

#set xrange [ 0 : 250 ]
set yrange [ 0 : ]
set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"

plot 'Kvinde.dat' using 1:3 with lines lw 2 lc 6 title 'Kvinde (median)', \
     'Kvinde.dat' using 1:6 with lines lw 1 lc 7 title 'Kvinde (middelværdi)', \
     'Mand.dat' using 1:3 with lines lw 2 lc 1 title 'Mand (median)', \
     'Mand.dat' using 1:6 with lines lw 1 lc 2 title 'Mand (middelværdi)';
