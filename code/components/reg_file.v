
// reg_file.v - register file for single-cycle RISC-V CPU
//              (with 32 registers, each of 32 bits)
//              having two read ports, one write port
//              write port is synchronous, read ports are combinational
//              register 0 is hardwired to 0

module reg_file #(parameter DATA_WIDTH = 32) (
    input       clk,
    input       wr_en,
    input       [4:0] rd_addr1, rd_addr2, wr_addr, // read and write adddress of 32 bits each
    input       [DATA_WIDTH-1:0] wr_data, // data to be written
    output      [DATA_WIDTH-1:0] rd_data1, rd_data2 // data to send to alu 
);



reg [DATA_WIDTH-1:0] reg_file_arr [0:31]; // internal 2D storage array

// to initialize the hardware instead of it holding garbage value x
initial begin 
    for (int i=0;i<32;i=i+1) begin
        reg_file_arr [i] = 0; // every value set to 0
    end
end

// Read logic with x0 protection (x0 must be set to 0)
assign rd_data1 = (rd_addr1 != 5'd0) ? reg_file_arr [rd_addr1] : 32'd0; 
assign rd_data2 = (rd_addr2 != 5'd0) ? reg_file_arr [rd_addr2] : 32'd0;

// Write logic 
always @(posedge clk) begin
    if (wr_en && (wr_addr != 5'd0))begin 
        reg_file_arr [wr_addr] <= wr_data ;
    end
end

endmodule