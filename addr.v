module add_1p (x, y, sum, clk);
 parameter WIDTH = 15, WIDTH1 = 7, WIDTH2 = 8;

 input [WIDTH-1:0] x,y;
 output [WIDTH-1:0] sum;
 input clk;

 reg [WIDTH1-1:0] l1, l2;
 wire [WIDTH1-1:0] q1, r1;
 reg [WIDTH2-1:0] l3, l4;
 wire [WIDTH2-1:0] r2, q2, u2;
 reg [WIDTH-1:0] s;
 wire cr1, cq1;
 wire [WIDTH2-1:0] h2;
 
 wire clkena, ADD, ena, aset, sclr;
 wire sset, aload, sload, aclr, ovf1, cin1;

 assign cin1=0; assign aclr=0; assign ADD=1;
 assign ena=1; assign aclr=0;
 assign sclr=0; assign sset=0; assign aload=0;
 assign sload=0; assign clkena=0; assign aset=0;

 
 assign  l1[WIDTH1-1:0] = x[WIDTH1-1:0];
 assign l2[WIDTH1-1:0] = y[WIDTH1-1:0];
 assign  l3[WIDTH2-1:0] = x[WIDTH2-1 + WIDTH1 : WIDTH1];
 assign l4[WIDTH2-1:0] = y[WIDTH2-1 + WIDTH1 : WIDTH1];
 

 lpm_add_sub add_1
  (.result(r1), .dataa(l1), .datab(l2), .cout(cr1));

 lpm_ff reg_1
	(.data(r1), .q(q1), .clock(clk));

 lpm_ff reg_2
	(.data(cr1), .q(cq1), .clock(clk));

 lpm_add_sub add_2
	(.dataa(l3), .datab(l4), .result(r2));

 lpm_ff reg_3
	(.data(r2), .q(q2), .clock(clk));

 assign h2 = {WIDTH2{1'b0}};

 lpm_add_sub add_3
  (.cout(cq1), .dataa(q2), .datab(h2), .result(u2));

 assign  s = {u2[WIDTH2-1:0], q1[WIDTH1-1:0]};
 
 assign sum = s;

endmodule


module lpm_ff(data, q, clock);
  
  input data;
  input clock;
  output  q;
  reg [7:0]q;
  wire [7:0]data;
  
  assign  q = data;
  
endmodule


module lpm_add_sub(result, dataa, datab, cout);
  
  input[6:0] dataa, datab;
  output[6:0] result;
  output cout;
  wire [6:0] dataa, datab;
  reg [6:0] result;
  reg cout;
  
  initial begin
  	{cout, result} = dataa + datab;
  end
  
endmodule