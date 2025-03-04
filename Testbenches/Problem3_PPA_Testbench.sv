module TestBench();
  
  reg cin, p_0;
  reg [15:0] A_Value, B_Value;
  wire [15:0] Sum;

  Main DUT0(Sum, A_Value, B_Value, cin, p_0);

    initial begin
      $display("  Sum\tA\tB\tCin\tp_0");
      $display("------------------------------------");
      $monitor("%h,\t %h,\t %h,\t %b,\t %b", Sum, A_Value, B_Value, cin, p_0);
    {A_Value, B_Value} = 16'h0000; {cin, p_0} = 0;
    #5 A_Value = 16'h0010; B_Value = 16'h0020;
    #5 A_Value = 16'h0110; B_Value = 16'h0110; cin = 1;
    #5 A_Value = 16'h1010; B_Value = 16'h4000;
    #5 A_Value = 16'h0043; B_Value = 16'h5021; cin = 0;
    #5 A_Value = 16'h0723; B_Value = 16'h0429;
    #5 A_Value = 16'h0553; B_Value = 16'h6420;
  
   #50 $finish;

  end
endmodule
