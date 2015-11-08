proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7z010clg400-1
  set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/CA_Labs/Lab2/spi_memory/spi_memory.cache/wt [current_project]
  set_property parent.project_path C:/CA_Labs/Lab2/spi_memory/spi_memory.xpr [current_project]
  set_property ip_repo_paths {
  c:/CA_Labs/Lab2/spi_memory/spi_memory.cache/ip
  C:/CA_Labs/Lab2/spi_memory/spi_memory.srcs/sources_1/imports/Lab2
} [current_project]
  set_property ip_output_repo c:/CA_Labs/Lab2/spi_memory/spi_memory.cache/ip [current_project]
  add_files -quiet C:/CA_Labs/Lab2/spi_memory/spi_memory.runs/synth_1/spiMemory.dcp
  link_design -top spiMemory -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force spiMemory_opt.dcp
  catch {report_drc -file spiMemory_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file spiMemory.hwdef}
  place_design 
  write_checkpoint -force spiMemory_placed.dcp
  catch { report_io -file spiMemory_io_placed.rpt }
  catch { report_utilization -file spiMemory_utilization_placed.rpt -pb spiMemory_utilization_placed.pb }
  catch { report_control_sets -verbose -file spiMemory_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force spiMemory_routed.dcp
  catch { report_drc -file spiMemory_drc_routed.rpt -pb spiMemory_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file spiMemory_timing_summary_routed.rpt -rpx spiMemory_timing_summary_routed.rpx }
  catch { report_power -file spiMemory_power_routed.rpt -pb spiMemory_power_summary_routed.pb }
  catch { report_route_status -file spiMemory_route_status.rpt -pb spiMemory_route_status.pb }
  catch { report_clock_utilization -file spiMemory_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

