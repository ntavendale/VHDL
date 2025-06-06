# VHDL
VHDL Modules And Projects. I have started learning VHDL and designing FPGAs. To do this I have been using the Nandland book  - *Getting Started with FPGAs* by Russell Merrick. You can find more details on the book here here: https://nandland.com/

There is also a github site, https://github.com/nandland, where you can get the code from the book.

The book gears it's examples to the Go Board available on the site. That board uses a Lattice chip which means using the Lattice ICE Cube software which I found pretty clunky. It's also been deprecated by Lattice and there have been licensing issues in the past where, for a while, Lattice was trying to charge learners & hobbyists for it. In all fairness though, Russell Merrick was very helpful with licenses when contacted during this time.

Where I work we use AMD Vivado which, while far from perfect and with a slightly steeper learning curve, has built in simulation and the Standard Edition works free with a large range of lower end AMD/Xilinx FPGAs. 

To that end I bought a entry level Digilent [Basys 3 Trainer Board](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/) which has an Artix-7 FPGA. You can create circuits, and simulations, for this chip with the free Standard version of [Vivado](https://www.amd.com/en/products/software/adaptive-socs-and-fpgas/vivado/vivado-buy.html). It seems that AMD *really, really* want people using their stuff and seem to be going out of their way to make the barriers to doing so as low as possible. 

Most of the files in this repository represent modules I have created to use the Basys 3/Artix-7 in place of the Go Board, and Vivado in place of ICE Cube. The Basys 3 has different pin outs (obviously), is clocked faster (100 MHz compared to the Go Board's 25 MHz), and since  constraints files are not standardized the Vivado file will have a different format.

In addition the 7 Segment display on the Basys 3 works very differently from the Go Board and there are 4 digits to the Go Board's 2. The segment pin and decimal point signals are common to all 4 digits. Only the anode pin is different for each. This means that, to display a multiple digit number the display must be clocked.

You can find details [here](https://digilent.com/reference/programmable-logic/basys-3/reference-manual?redirect=1#seven_segment_display)