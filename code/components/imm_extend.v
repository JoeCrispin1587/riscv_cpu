
// imm_extend.v - logic for sign extension
module imm_extend (
    input  [31:7]     instr,  // upper bits of the instruction bus
    input   [2:0]     immsrc, // 3-bit control signal
    output reg [31:0] immext  // declared as reg so it can be driven inside a procedural block 
);
always @(*) begin 
    case (immsrc) 
        // I-Type 
        3'b000 : immext = {{20{instr[31]}},instr[31:20]} ; // sign extend 31st bit 20 times and concatenate it with 12-bit instr  
        // S-Type
        3'b001 : immext = {{20{instr[31]}},instr[31:25],instr[11:7]} ; // split into [31:25] , [11:7]
        // B-Type
        3'b010 : immext = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0} ; // 0 hardcoded at the end
        // J-Type
        3'b011 : immext = {{11{instr[31]}},instr[31], instr[19:12], instr[20], instr[30:21], 1'b0} ; 
        //U-Type
        3'b100 : immext = {instr[31:12] , 12'b0} ; // bottom 12  bits is completely filled with zeros
        default: immext = 32'bx ; // undetermined
    endcase

end

endmodule
