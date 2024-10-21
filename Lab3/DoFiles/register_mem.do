# File name

set file_name register_mem

# Compiling the project files

vcom -work work -2002 -explicit -stats=none {./Behavioral/dff.vhd}

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

set signals {clk rst we}
foreach sig $signals {
    radix signal sim:/${file_name}_tb/$sig -binary
}

set signals {read_addr1 read_addr2 write_addr}
foreach sig $signals {
    radix signal sim:/${file_name}_tb/$sig -unsigned
}

set signals {read_data1 read_data2 write_data}
foreach sig $signals {
    radix signal sim:/${file_name}_tb/$sig -hexadecimal
}


#----------------------------------------------------------------------------------------------------------------

# Run simulation for 300ns

run 200ns

#----------------------------------------------------------------------------------------------------------------

# Auto zoom the simulation wave for better readability and clearness

wave zoom full

#----------------------------------------------------------------------------------------------------------------
