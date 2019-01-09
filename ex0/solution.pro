; IDL Exercise

pro solution
files = ["_20151217_000000.dat", "_20151218_000000.dat", "_20151219_000000.dat", "_20151220_000000.dat", "_20151221_000000.dat"]

dio_sampling_rate = 1
thl_sampling_rate = 0.2

for i=0,size(files,/n_elements)-1 do begin
    ; Q1
    print, "Reading data files of day " + string(i+1) + " for question 1"
    dio_data = read_ascii("DIO/2015/12/DIO"+files[i], delimiter=',', data_start=9)
    thl_data = read_ascii("THL/2015/12/THL"+files[i], delimiter=',', data_start=9)
    xdio = dio_data.FIELD1[2,*]
    xthl = thl_data.FIELD1[2,*]
    print,"---"

    ; Q2
    print, "Visualizing x axis of the magnetic field of day " + string(i+1) + " relative to time for question 2"
    dio_time = findgen(n_elements(xdio)) * dio_sampling_rate / 3600
    thl_time = findgen(n_elements(xthl)) * thl_sampling_rate / 3600

    window, 0, title="Day " + string(i+1) + " DIO (red) & THL (white) Magnetic Field relative to time"
    plot, thl_time, xthl
    oplot, dio_time, xdio, color=119
    print,"---"

    ; Q3
    print, "Visualizing x axis of the magnetic field of day " + string(i+1) + " for question 3"
    window, 1, title="Day " + string(i+1) + " DIO (red) & THL (white) Magnetic Field"
    plot, xthl
    oplot, xdio, color=119
    print,"---"

    ; Q4
    print, "Visualizing the residual values of the magnetic field on the x axis of day " + string(i+1) + " for question 4"
    window, 2, title="Day " + string(i+1) + " DIO (red) & THL (white) Smoothed Residual Values of the Magnetic Field"
    xthl_smoothed = smooth(xthl, 30)
    xthl_residual = xthl - xthl_smoothed
    plot, xthl - smooth(xthl, 30)
    oplot, xdio - smooth(xdio, 30), color=119
    print,"---"

    if i lt size(files,/n_elements)-1 then begin
        print, "Press any key to continue to the next day..."
    endif else begin
        print, "Press any key to quit..."
    endelse
    _ = GET_KBRD()
endfor

end