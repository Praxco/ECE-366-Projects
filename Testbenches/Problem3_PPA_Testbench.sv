module TestBench();

  reg cin, p_0;
  reg [15:0] A_Value, B_Value;

  wire [15:0] Sum;

  Main DUT0(Sum, A_Value, B_Value, cin, p_0);

  initial begin
    A_Value = 16'b0000000000000000; 
    B_Value = 16'b0000000000000000; 
    cin = 0; p_0 = 0;
    #10
    $display("Sum = %b", Sum);
    
	A_Value = 16'b0000000000001111; 
    B_Value = 16'b0000000000000001; 
    cin = 0; p_0 = 0;
    #10
    $display("Sum = %b", Sum);

    A_Value = 16'b0000000001110000; 
    B_Value = 16'b0000000000001111; 
    cin = 0; p_0 = 0;
    #10
    $display("Sum = %b", Sum);
    
    A_Value = 16'b1001110000000000; 
    B_Value = 16'b0001110010000000; 
    cin = 1; p_0 = 0;
    #10
    $display("Sum = %b", Sum);
    
    A_Value = 16'b0001000001110000; 
    B_Value = 16'b1100110000000110; 
    cin = 1; p_0 = 0;
    #10
    $display("Sum = %b", Sum);
    
    A_Value = 16'b0000100000011100; 
    B_Value = 16'b1101111000011100; 
    cin = 0; p_0 = 0;
    #10
    $display("Sum = %b", Sum);
    
    $finish;

  end
endmodule
