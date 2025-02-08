module SIPO_tb;
    reg clk_fast;
    reg clk_slow;
    reg rst;
    reg serial_in;
    wire [3:0] parallel_out_fast;
    wire [3:0] parallel_out_slow;
  
    SIPO dut_fast (
        .clk(clk_fast),
        .rst(rst),
        .serial_in(serial_in),
        .parallel_out(parallel_out_fast)
    );

    SIPO dut_slow (
        .clk(clk_slow),
        .rst(rst),
        .serial_in(serial_in),
        .parallel_out(parallel_out_slow)
    );

    always #5 clk_fast = ~clk_fast;

    always #10 clk_slow = ~clk_slow;

    initial begin
         $monitor("At time %0t, parallel_out_fast = %b, parallel_out_slow = %b", $time, parallel_out_fast, parallel_out_slow);
      
        clk_fast = 0;
        clk_slow = 0;
        rst = 1;
        serial_in = 0;
      
        #10 rst = 0;
        #10 serial_in = 1;  
        #10 serial_in = 0;  
        #10 serial_in = 1; 
        #10 serial_in = 1; 
        #10 $finish;
    end
endmodule
