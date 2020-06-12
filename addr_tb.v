module add_1p_tb();
  
  reg [14:0] x, y;
  wire [14:0] sum;
  reg clk;
  
  add_1p add1(.x(x), .y(y), .sum(sum), .clk(clk));
  
  always #1 clk = ~clk;
  
  initial begin
    
    clk = 1;
    x = 32457;
    y = 12469;
    #5; $finish;
  end
  
  initial begin
    $monitor("x = %d, y = %d, sum = %d", x, y, sum);
    $dumpfile("wave.vcd");
    $dumpvars;
  end
  
  
endmodule