##############################################################################
## Filename:          Y:\TDT4255\TestExercise1\processor/drivers/processor_v1_00_a/data/processor_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Sun Sep 30 15:26:01 2012 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "processor" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}
