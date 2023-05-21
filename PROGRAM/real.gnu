set term png
set title '<Energies> vs time'
set xlabel 'time (ps)'
set ylabel '<Energies> (kJ/mol)'
set key outside
set autoscale

set title 'r_vs_t'
set xlabel 't'
set ylabel 'r'
set output 'r_vs_t.png'
plot 'r_vs_t.dat' u 1:2 w p 

# PHASE----------------------------------------------------
set title 'Omega_vs_DTheta'
set xlabel 'Omega'
set ylabel 'Dtheta'
set output 'Omega_vs_DTheta.png'
plot 'Omega_vs_DTheta.dat' u 1:2 w p 
# PHASE----------------------------------------------------

set title "Figure 1" font ",14" # TITOL
set xlabel "x" font ",14"	# TITOL X AXIS
set ylabel "y" font ",14"	# TITOL Y AXIS
set xrange [-5:5]		# RANG X AXIS
set yrange [-5:5]		# RANG Y AXIS
set xtics 0.5 font ",14"	# TICS STEP IN X AXIS
set ytics 1 font ",14"		# TICS STEP IN Y AXIS
set xtics 3 nomirror font ",16"  # Si s'agegeix no mirror no els posa al costat oposat
set ytics 25 nomirror font ",16" # si s'afegeix no mirror no els posa al costat oposat
set border 3			 # Tipus de Borders (mirar combinacions)
set size square			#GEOMETRIA EIXOS
set linetype 1 lc rgb "red" pt 5      #DEFINIM ALGUNS TIPUS de LINIES
set linetype 2 lc rgb "green" pt 7
set linetype 3 lc rgb "blue" pt 9
set linetype 4 lc rgb "blue" lw 5
set title 'Omega_vs_Theta'
set xlabel 'Omega'
set ylabel 'Theta'
set output 'Omega_vs_Theta.png'
plot 'Omega_vs_Theta.dat' u 1:2 lt 1
