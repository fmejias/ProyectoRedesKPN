transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/multiplier_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/clock_divider_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/fifo_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/lcd_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/lcd_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/top_module_lcd.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/bcd_converter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/write_to_display.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_Fixed_Point/queue_module.v}

