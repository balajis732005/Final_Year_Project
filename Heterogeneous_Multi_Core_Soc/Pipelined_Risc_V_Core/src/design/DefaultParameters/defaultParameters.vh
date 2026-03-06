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
// ALU Operations (4-bit)
// -------------------------------
localparam [3:0] ADD   = 4'b0000;
localparam [3:0] SUB   = 4'b0001;
localparam [3:0] AND   = 4'b0010;
localparam [3:0] OR    = 4'b0011;
localparam [3:0] XOR   = 4'b0100;
localparam [3:0] SLL   = 4'b0101;
localparam [3:0] SRL   = 4'b0110;
localparam [3:0] SRA   = 4'b0111;
localparam [3:0] SLT   = 4'b1000;
localparam [3:0] SLTU  = 4'b1001;
localparam [3:0] BEQ   = 4'b1010;
localparam [3:0] BNE   = 4'b1011;
localparam [3:0] BLT   = 4'b1100;
localparam [3:0] BGE   = 4'b1101;
localparam [3:0] BLTU  = 4'b1110;
localparam [3:0] BGEU  = 4'b1111;
