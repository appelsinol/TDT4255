##############################################################################
## Filename:          Y:\TDT4255\TestExercise1\MipsCpu/drivers/mipscpu_v1_00_a/data/mipscpu_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sat Sep 29 20:52:12 2012 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "mipscpu" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
