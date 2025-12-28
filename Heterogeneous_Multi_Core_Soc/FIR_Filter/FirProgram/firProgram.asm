# ---------------------------------
# FIR PROGRAM
# ---------------------------------

# Clear accumulator
addi x4, x0, 0

# -------- TAP 0 --------
lw   x2, 0(x10)        # load input
lw   x3, 0(x11)        # load coeff
vmac x4, x2, x3        # acc += x2 * x3

# -------- TAP 1 --------
lw   x2, 4(x10)
lw   x3, 4(x11)
vmac x4, x2, x3

# -------- TAP 2 --------
lw   x2, 8(x10)
lw   x3, 8(x11)
vmac x4, x2, x3

# Store output
sw   x4, 0(x12)

# End (infinite loop for fir_done detection)
jal  x0, 0
