# File name

set file_name elevator

# Compiling the project files

vcom -work work -2002 -explicit -stats=none "./Behavioral/clk_divider.vhd"

vcom -work work -2002 -explicit -stats=none "./Behavioral/unit_control.vhd"

vcom -work work -2002 -explicit -stats=none "./Behavioral/request_resolver.vhd"

vcom -work work -2002 -explicit -stats=none "./Behavioral/elevator_controller.vhd"

vcom -work work -2002 -explicit -stats=none "./TB/elevator_tb.vhd"

#----------------------------------------------------------------------------------------------------------------

# Start simulation

vsim -gui work.elevator_tb 

#----------------------------------------------------------------------------------------------------------------

# Add all the signal to simulation wave

add wave *

#----------------------------------------------------------------------------------------------------------------



# Set the radix of the signal to the desired radix 

set signals {clk rst clk_out requests move_up move_down door_open seg_out}
foreach sig $signals {
    radix signal sim:/${file_name}_tb/$sig -binary
}

set signals {current_floor next_floor state}
foreach sig $signals {
    radix signal sim:/${file_name}_tb/$sig -unsigned
}


#----------------------------------------------------------------------------------------------------------------

# Run simulation for 40 sec

run 40sec

#----------------------------------------------------------------------------------------------------------------

# Auto zoom the simulation wave for better readability and clearness

wave zoom full

#----------------------------------------------------------------------------------------------------------------