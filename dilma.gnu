reset
set size 2,2
set term postscript eps enhanced color
set out "dilma.eps"

plot 'dilma.dat' u ($1):($2) w lines t 'Aecio', \
     'dilma.dat' u ($1):($3) w lines t 'Dilma'
