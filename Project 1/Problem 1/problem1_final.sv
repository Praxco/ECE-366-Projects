// Problem 1 Parts a through d. Part e (the testbench) can be found in the Testbenches folder on the main branch
// 4-Bit Ripple Carry Adder and Subtractor

module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (A ^ B & Cin);
endmodule


module four_bit_RCA_RCS (A, B, Cin, mode, S, Cout);
  input [3:0] A, B;
  input Cin, mode;
  output [3:0] S;
  output Cout;
  
  // Internal carry signals for individual adders
  wire c1, c2, c3;
  wire [3:0] sub_B;
  assign sub_B = mode ? ~B : B; // If Mode == 1, B is inverted
  
  // Instantiate four 1-bit full adders from above module
  one_bit_full_adder F0( .A(A[0]), .B(sub_B[0]), .Cin(mode ? 1 : Cin), .S(S[0]), .Cout(c1)); // This line has a condition specifically for the first carry in (Cin) which will be 1 if Mode is 1
  one_bit_full_adder F1( .A(A[1]), .B(sub_B[1]), .Cin(c1), .S(S[1]), .Cout(c2));
  one_bit_full_adder F2( .A(A[2]), .B(sub_B[2]), .Cin(c2), .S(S[2]), .Cout(c3));
  one_bit_full_adder F3( .A(A[3]), .B(sub_B[3]), .Cin(c3), .S(S[3]), .Cout(Cout));
  
endmodule

