// -------------------------------
// Instruction Types (7-bit opcodes)
// -------------------------------
localparam [6:0] RType       = 7'b0110011;
localparam [6:0] IType       = 7'b0010011;
localparam [6:0] ITypeLoad   = 7'b0000011;
localparam [6:0] ITypeJALR   = 7'b1100111;
localparam [6:0] SType       = 7'b0100011;
localparam [6:0] BType       = 7'b1100011;
localparam [6:0] UType       = 7'b0110111;
localparam [6:0] UTypeAUIPC  = 7'b0010111;
localparam [6:0] JType       = 7'b1101111;
localparam [6:0] VmacType    = 7'b0001011;

// -------------------------------
// ALU Control Type (3-bit)
// -------------------------------
localparam [2:0] LoadStoreType   = 3'b000;
localparam [2:0] BTypeALU        = 3'b001;
localparam [2:0] RTypeALU        = 3'b010;
localparam [2:0] ITypeALU        = 3'b011;
localparam [2:0] JTypeALU        = 3'b100;
localparam [2:0] ITypeJALR_ALU   = 3'b101;
localparam [2:0] UTypeALU        = 3'b110;
localparam [2:0] UTypeAUIPC_ALU  = 3'b111;

// -------------------------------
// ALU Operations (5-bit)
// -------------------------------
localparam [4:0] ADD   = 5'b00000;
localparam [4:0] SUB   = 5'b00001;
localparam [4:0] AND   = 5'b00010;
localparam [4:0] OR    = 5'b00011;
localparam [4:0] XOR   = 5'b00100;
localparam [4:0] SLL   = 5'b00101;
localparam [4:0] SRL   = 5'b00110;
localparam [4:0] SRA   = 5'b00111;
localparam [4:0] SLT   = 5'b01000;
localparam [4:0] SLTU  = 5'b01001;
localparam [4:0] BEQ   = 5'b01010;
localparam [4:0] BNE   = 5'b01011;
localparam [4:0] BLT   = 5'b01100;
localparam [4:0] BGE   = 5'b01101;
localparam [4:0] BLTU  = 5'b01110;
localparam [4:0] BGEU  = 5'b01111;
localparam [4:0] VMAC  = 5'b10000;
