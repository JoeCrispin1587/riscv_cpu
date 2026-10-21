
// alu.v - ALU module

module alu #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a, b,       // operands
    input       [2:0] alu_ctrl,         // ALU control
    output reg  [WIDTH-1:0] alu_out,    // ALU output
    output      zero                    // zero flag
);

always @ (*) begin 
    case(alu_ctrl) 
        3'b000: alu_out = a+b;   //ADD
        3'b001: alu_out = a-b;   //SUB
        3'b010: alu_out = a & b; //AND
        3'b011: alu_out = a|b;   //OR
        3'b101:begin 
            if (a[WIDTH-1]!=b[WIDTH-1]) alu_out = a[WIDTH-1] ? 32'd1 : 32'd0; //SLT SIGNED
            else alu_out = a < b ? 32'd1 : 32'd0;
        end
        default : alu_out = {WIDTH{1'b0}}; //DEFAULT = 0
    endcase
end

assign zero = (alu_out == {WIDTH{1'b0}});  //ZERO FLAG 

endmodule

