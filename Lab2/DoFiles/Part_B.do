# File name

set file_name part_b

# Compiling the project files

vcom -work work -2002 -explicit -stats=none {./RTL/mux.vhd}

vcom -work work -2002 -explicit -stats=none {./Entities/part.vhd}

vcom -work work -2002 -explicit -stats=none "./Behavioral/${file_name}.vhd"

vcom -work work -2002 -explicit -stats=none "./TB/${file_name}_tb.vhd"

#----------------------------------------------------------------------------------------------------------------

# Start simulation

vsim -gui work.${file_name}_tb 

#----------------------------------------------------------------------------------------------------------------

# Add all the signal to simulation wave

add wave *

#----------------------------------------------------------------------------------------------------------------


# Set the radix of the signal to the desired radix 

set signals {A B cin output cout}
foreach sig $signals {
    radix signal sim:/${file_name}_tb/$sig -hexadecimal
}

radix signal sim:/${file_name}_tb/sel -binary

#----------------------------------------------------------------------------------------------------------------

# Run simulation for 300ns

run 100ns

#----------------------------------------------------------------------------------------------------------------

# Auto zoom the simulation wave for better readability and clearness

wave zoom full

#----------------------------------------------------------------------------------------------------------------
