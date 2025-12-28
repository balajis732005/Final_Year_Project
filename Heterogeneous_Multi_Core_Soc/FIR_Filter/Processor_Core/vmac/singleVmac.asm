LUI x10, int(10) 
LUI x11, int(0.25 in Q-15) 0.25 in Q15 = 8192 = 0x2000
SW x10, 8(x0) 
SW x11, 9(x0)
SW x0, 10(x0) 
LW rd=x2, 8(x0) 
LW rd=x3, 9(x0) 
LW rd=x4, 10(x0) 
VMAC rs1=x2, rs2=x3, rd=x4 
SW x4, 10(x0)
