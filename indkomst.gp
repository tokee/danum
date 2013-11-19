title=system("echo ${TITLE}")
ylabel=system("echo ${YLABEL}")

# 25% 50% 75% 95% mean
set terminal png size 1000, 650 \
    xffffff x000000 \
    xff0000 xff0000 xff0000 xffcccc xff3333 \
    x0000ff x0000ff x0000ff xccccff x3333ff

set output "indkomst.png"

set title title

set xlabel 'Alder'
set ylabel ylabel

set datafile separator " "

#set xrange [ 0 : 250 ]
#set yrange [ 1 : 10000 ]
set grid ytics lt 0 lw 1 lc rgb "#bbbbbb"

plot 'Kvinde.dat' using 1:2 with lines lw 1 lc 5 lt 7 title 'Kvinde (25%)', \
     'Kvinde.dat' using 1:3 with lines lw 2 lc 6 title 'Kvinde (50%)', \
     'Kvinde.dat' using 1:4 with lines lw 1 lc 7 title 'Kvinde (75%)', \
     'Kvinde.dat' using 1:5 with lines lw 2 lc 8 title 'Kvinde (95%)', \
 \
     'Mand.dat' using 1:2 with lines lw 1 lc 0 title 'Mand (25%)', \
     'Mand.dat' using 1:3 with lines lw 2 lc 1 title 'Mand (50%)', \
     'Mand.dat' using 1:4 with lines lw 1 lc 2 title 'Mand (75%)', \
     'Mand.dat' using 1:5 with lines lw 2 lc 3 title 'Mand (95%)'


#     'Mand.dat' using 1:6 with lines lw 2 lc 4 title 'Mand (mean)', \
