//One-bit full adder behavior model
module one_bit_adder_behavior(Sum, Cout, A, B, Cin);
  output Sum,  Cout;
  input A, B, Cin;
  
  wire t1, t2, t3;
  
  assign Sum = A ^ B ^ Cin;

  assign t1 = A & Cin;
  assign t2 = A & B;
  assign t3 = A & Cin;
  assign Cout = t1 | t2 | t3;
  
endmodule
