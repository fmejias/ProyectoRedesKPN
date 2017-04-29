transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/adder_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/fifo_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/clock_divider_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/lcd_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/top_module_lcd.v}
vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/queue_module.v}

