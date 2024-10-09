@set modelsim=S:\DevTools\modelsim\win64\vsim.exe
@if exist vsim.wlf del vsim.wlf
%modelsim% -do tcl.do
