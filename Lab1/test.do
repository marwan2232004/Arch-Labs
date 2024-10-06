# Compiling the project files

vcom -work work -2002 -explicit -stats=none {./RTL/mux2.vhd}

vcom -work work -2002 -explicit -stats=none {./Entities/part_entity.vhd}

vcom -work work -2002 -explicit -stats=none {./Behavioral/part_b.vhd}

vcom -work work -2002 -explicit -stats=none {./Behavioral/part_c.vhd}

vcom -work work -2002 -explicit -stats=none {./Behavioral/part_d.vhd}

vcom -work work -2002 -explicit -stats=none {./Behavioral/ALU.vhd}

vcom -work work -2002 -explicit -stats=none {./TB/part_b_tb.vhd}

vcom -work work -2002 -explicit -stats=none {./TB/part_c_tb.vhd}

vcom -work work -2002 -explicit -stats=none {./TB/part_d_tb.vhd}

vcom -work work -2002 -explicit -stats=none {./TB/ALU_tb.vhd}

#----------------------------------------------------------------------------------------------------------------

# Start simulation

vsim -gui work.alu_tb 

#----------------------------------------------------------------------------------------------------------------

# Add all the signal to simulation wave

add wave *

#----------------------------------------------------------------------------------------------------------------


# Set the radix of the signal to the desired radix 

set signals {A B cin output cout}
foreach sig $signals {
    radix signal sim:/alu_tb/$sig -hexadecimal
}

radix signal sim:/alu_tb/sel -binary

#----------------------------------------------------------------------------------------------------------------

# Run simulation for 300ns

run 300ns

#----------------------------------------------------------------------------------------------------------------

# Auto zoom the simulation wave for better readability and clearness

wave zoom full

#----------------------------------------------------------------------------------------------------------------
