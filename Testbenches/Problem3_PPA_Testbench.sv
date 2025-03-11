module TestBench();
  
  reg Cin, p_0;
  reg [15:0] A, B;
  wire [15:0] Sum;

  Main DUT0(Sum, A, B, Cin, p_0);

    initial begin
      $display("  Sum\tA\tB\tCin\tp_0");
      $display("------------------------------------");
      $monitor("%h,\t %h,\t %h,\t %b,\t %b", Sum, A, B, Cin, p_0);
      {A, B} = 16'h0000; {Cin, p_0} = 0;
    #5 A = 16'h0010; B = 16'h0020;
    #5 A = 16'h0110; B = 16'h0110; Cin = 1;
    #5 A = 16'h1010; B = 16'h4000;
    #5 A = 16'h0043; B = 16'h5021; Cin = 0;
    #5 A = 16'h0723; B = 16'h0429;
    #5 A = 16'h0553; B = 16'h6420;
  
   #50 $finish;

  end
endmodule
