

module spi_module #(
    parameter NO_OF_SLAVES = 2,
    parameter REGISTER_WIDTH = 8
)(
    input clk,
    input rst_n,
//interfata APB
    input paddr,
    input psel,
    input penable,
    input pwrite,
    input [REGISTER_WIDTH-1:0] pwdata,
    output reg [REGISTER_WIDTH-1:0] prdata,
    output pready,
// interfata SPI
    output reg [NO_OF_SLAVES-1:0]spi_ss_n,
    output reg spi_clk,
    output reg spi_mosi,
    input spi_miso,
);

reg [REGISTER_WIDTH-1:0] spcr; // Control Register  address 0
reg [REGISTER_WIDTH-1:0] spsr; // Status Register   address 1
reg [REGISTER_WIDTH-1:0] spdr; // SPI Data Register address 2

always @(posedge clk or negedge rst_n) 
    if (!rst_n) begin
        spcr <= 0;
        spsr <= 0;
        spdr <= 0;
    end else begin
        if (psel && penable && pready && pwrite) begin //asteptam tactul in care slave-ul confirma acceptarea tranzactiei de scriere
                case (paddr)
                    0: spcr <= pwdata; // Write to Control Register
                    1: spsr[0] <= pwdata[0]; // Write to Status Register
                    2: spdr <= pwdata; // Write to Data Register
                endcase
          
        end

    end

    always @(posedge clk or negedge rst_n) 
if (!rst_n) begin
       prdata <= {REGISTER_WIDTH{1'b0}};
    end 
        if (psel && !penable && !pwrite) begin //asteptam primul tact al tranzactiei de citire
            case (paddr)
                    0: prdata <= spcr; // Write to Control Register
                    1: prdata <=spsr; // Write to Status Register
                    2: prdata <= spdr; // Write to Data Register
                endcase
    
    end

    //pready
    always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        pready <= 1'b0;
    else if (psel && !penable)   // pready = 1 doar daca psel = 1 si penable = 0
        pready <= 1'b1;
    else
        pready <= 1'b0;
end


endmodule
