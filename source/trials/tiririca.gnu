reset
set size 2,2
set term postscript eps enhanced color
set out "tiririca.eps"

plot 'tiririca.dat' u ($1):($2) w boxes t 'Tiririca', \
     'tiririca.dat' u ($1):($3) w boxes t 'Malafaia', \
     'tiririca.dat' u ($1):($4) w boxes t 'Dilma'
