// 1-bit adder using behavior modeling
module adder(A,B,Cin,Cout,S);
  input A,B,Cin;
  output Cout, S;
  
  wire x1,t1,t2,t3,t4;
  
  assign x1 = A^B;
  assign S = x1^Cin;
  
  assign t1 = A&B;
  assign t2 = A&Cin;
  assign t3 = B&Cin;
  assign t4 = t1|t2;
  assign Cout = t4|t3;
  
endmodule
