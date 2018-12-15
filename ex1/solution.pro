; IDL Exercise

pro solution

; Q1
print, "Reading sun.sav for question 1"
restore, 'sun.sav'
print, "---"

; Q2
print, "Visualizing with contour for question 2"
window,0,title="Question 2"
s = size(data)
sunR = 695508 ; km
step = 40.0 ; km
arc_step = step / sunR * 3600 ; arcsec
start_x = 100.0 ; arcsec
end_x = (s[2]-1) * arc_step + start_x ; arcsec
start_y = -600.0 ; arcsec
end_y = (s[1]-1) * arc_step + start_y ; arcsec
ticks = 7
axis_step_x = abs(abs(end_x)-abs(start_x)) / ticks
axis_step_y = abs(abs(end_y)-abs(start_y)) / ticks
xvalues = findgen(ticks) * axis_step_x + start_x
yvalues = findgen(ticks) * axis_step_y + start_y
contour, data, xtitle='x (arcsec)', ytitle='y (arcsec)', xtickname=xvalues, ytickname=yvalues, xticks=ticks-1, yticks=ticks-1
print, "---"

; Q3
print, "Saving contour as q3.jpg for question 3"
;write_jpeg, "q3.jpg", tvrd()
print, "---"

; Q4
print, "Creating a sub-array and printing various info for question 4"
selected_elements = 181
center_x = 250
center_y = 240
start_x = center_x - (selected_elements - 1) / 2
end_x = center_x + (selected_elements - 1) / 2
start_y = center_y - (selected_elements - 1) / 2
end_y = center_y + (selected_elements - 1) / 2
counts_limit = 700000
q4 = data[start_x:end_x, start_y:end_y]
print, "Minimum value = ", min(q4)
print, "Maximum value = ", max(q4)
print, "Mean value    = ", mean(q4)
indexes = where(q4 gt counts_limit, cnt)
print, "Number of values >  700000: ", cnt
print, "---"

; Q5
print, "Creating a sub-array, calculating linear fit and vizualizing for question 5"
ycut = 120
q5 = q4[*,ycut-1]
xx = findgen(size(q5,/n_elements))
r = linfit(xx, q5)
window,1,title="Question 5"
plot,xx,q5
oplot,xx,r(0)+r(1)*xx
print, "---"

; Q6
print, "Calculating fourier transform and vizualizing for question 6"
lower_limit = 0
upper_limit = 0.02
dt = 1
f = fft_powerSpectrum(q5, dt, freq=freq)
window,2,title="Question 6"
indexes = where(freq[where((freq le upper_limit))] ge lower_limit)
plot, freq[indexes], f[indexes], xrange=[lower_limit, upper_limit]
print, "---"

end