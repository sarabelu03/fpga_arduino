
module reg_interface #(
    parameter DATA_WIDTH = 8
)(
    input clk,
    input rst_n,
    //interfata intrare
    input cpol,
    input cpha,
    input [DATA_WIDTH-1:0] data,
    input inainte,
    input inapoi,
    input valid,
    //interfata APB
    input   [REGISTER_WIDTH-1:0] prdata,
    input   pready,
    output  paddr,
    output  psel,
    output  penable,
    output  pwrite,
    output  [REGISTER_WIDTH-1:0] pwdata
);


endmodule

    