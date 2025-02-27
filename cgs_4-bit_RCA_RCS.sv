// 4-Bit Ripple Carry Adder
// Written by Cole Garrett S.

// 1-bit FA from previous file
module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (A ^ B & Cin);
endmodule


module four_bit_RCA_RCS (A, B, Cin, S, Cout);
  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;
  
  // Internal carry signals for individual adders
  wire c1, c2, c3;
  
  // Instantiate four 1-bit full adders from above module
  one_bit_full_adder F0( .A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(c1));
  one_bit_full_adder F1( .A(A[1]), .B(B[1]), .Cin(c1), .S(S[1]), .Cout(c2));
  one_bit_full_adder F2( .A(A[2]), .B(B[2]), .Cin(c2), .S(S[2]), .Cout(c3));
  one_bit_full_adder F3( .A(A[3]), .B(B[3]), .Cin(c3), .S(S[3]), .Cout(Cout));
  
endmodule


  

  
  
