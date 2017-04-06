transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program {C:/Users/Felipe/Desktop/Tec/ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/Modules_Implementation_For_Software_Program/top_module.v}

