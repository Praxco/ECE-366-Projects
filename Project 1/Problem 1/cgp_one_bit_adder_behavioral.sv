//One-bit full adder behavior model
module one_bit_adder_behavior(Sum, Cout, A, B, Cin);
  output Sum,  Cout;
  input A, B, Cin;
  
  wire t1, t2, t3;
  
  assign Sum = A ^ B ^ Cin;

  assign t1 = A & Cin;
  assign t2 = A & B;
  assign t3 = B & Cin;
  assign Cout = t1 | t2 | t3;
  
endmodule


module one_bit_tb();
  reg A, B, Cin;
  wire Sum, Cout;
  
  one_bit_adder_behavior DUT(.Sum(Sum), .Cout(Cout), .A(A), .B(B), .Cin(Cin));
  
      initial begin
        $display("  Sum\tCout\tA\tB\tCin");
      $display("------------------------------------");
        $monitor("%b,\t %b,\t %b,\t %b,\t %b", Sum, Cout, A, B, Cin);
        {A, B, Cin} = 0; 
        #5 A = 0; B = 0; Cin = 1;
        #5 A = 0; B = 1; Cin = 0;
        #5 A = 0; B = 1; Cin = 1;
        #5 A = 1; B = 0; Cin = 0;
        #5 A = 1; B = 0; Cin = 1;
        #5 A = 1; B = 1; Cin = 0;
        #5 A = 1; B = 1; Cin = 1;
        
  
   #50 $finish;
  end

  initial 
  begin 
  $dumpfile("dump.vcd"); 
  $dumpvars(1); 
  end;
  
endmodule
