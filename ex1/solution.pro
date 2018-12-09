; IDL Exercise

pro solution

; Q1
print, "Reading sun.sav for question 1"
restore, 'sun.sav'
print, "---"

; Q2
print, "Visualizing with contour for question 2"
; TODO on axes range
window,0,title="Question 2"
s = size(data)
start_x = 100.0
end_x = s[2] * 0.04 + start_x
start_y = -600.0
end_y = s[1] * 0.04 + start_y
xvalues = [start_x, end_x]
yvalues = [start_y, end_y]
contour, data, xtitle='x (arcsec)', ytitle='y (arcsec)', xtickv=xvalues, ytickv=yvalues
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
; TODO check this again, because I get only 4 values in the end
print, "Calculating fourier transform and vizualizing for question 6"
lower_limit = 0
upper_limit = 0.02
dt = 1
f = fft_powerSpectrum(q5, dt, freq=freq)
print,f
print, "asdasdasd"
print, freq
window,2,title="Question 6"
indexes = where(freq[where((freq le upper_limit))] ge lower_limit)
print, indexes
print, freq[indexes]
plot, freq[indexes], f[indexes], xrange=[lower_limit, upper_limit]
print, "---"

end