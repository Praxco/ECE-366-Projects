// Code your design here
// Problem 2 32 Bit CLA; This is mostly made using behavioral models on the smaller modules, and then putting the CLA together structurally
module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (A ^ B & Cin);
endmodule


module G_and_P (A, B, G, P);
  input [3:0] A, B;
  output [3:0] G, P;
  
  assign G = A & B;
  assign P = A | B;
  
endmodule

module carry_logic (P, G, Cin, Carries);
  input [3:0] P, G;
  input Cin;
  output [3:0] Carries;
  
  // Carries:
  assign Carries[0] = G[0] | (P[0] & Cin);
  assign Carries[1] = G[1] | (P[1] & Carries[0]);  
  assign Carries[2] = G[2] | (P[2] & Carries[1]);
  assign Carries[3] = G[3] | (P[3] & Carries[2]);
  
endmodule

module CLA_4Bit(A, B, G, P, Cin, S, Cout);
  input [3:0] A, B, G, P;
  input Cin;
  output [3:0] S;
  output Cout;
  
  wire [3:0] G, P, Carry; // For bridging the internal modules instantiated below and p&g computation

  G_and_P GP(.A(A), .B(B), .P(P), .G(G));
  carry_logic CL(.P(P), .G(G), .Cin(Cin), .Carries(Carry));
  
  
  // Instantiate four 1-bit full adders from above module
  one_bit_full_adder F0( .A(A[0]), .B(B[0]), .Cin(Carry[0]), .S(S[0]), .Cout(Carry[1]));
  one_bit_full_adder F1( .A(A[1]), .B(B[1]), .Cin(Carry[1]), .S(S[1]), .Cout(Carry[2]));
  one_bit_full_adder F2( .A(A[2]), .B(B[2]), .Cin(Carry[2]), .S(S[2]), .Cout(Carry[3]));
  one_bit_full_adder F3( .A(A[3]), .B(B[3]), .Cin(Carry[3]), .S(S[3]), .Cout(Cout));
  
  
  
endmodule


module CLA_32Bit(A, B, Cin, S, Cout);

  input [31:0] A, B;
  input Cin;
  output [31:0] S;
  output Cout;
  wire c0, c1, c2, c3, c4, c5, c6;
  
  CLA_4Bit CLA0(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(c0));
  CLA_4Bit CLA1(.A(A[7:4]), .B(B[7:4]), .Cin(c0), .S(S[7:4]), .Cout(c1));
  CLA_4Bit CLA2(.A(A[11:8]), .B(B[11:8]), .Cin(c1), .S(S[11:8]), .Cout(c2));
  CLA_4Bit CLA3(.A(A[15:12]), .B(B[15:12]), .Cin(c2), .S(S[15:12]), .Cout(c3));
  CLA_4Bit CLA4(.A(A[19:16]), .B(B[19:16]), .Cin(c3), .S(S[19:16]), .Cout(c4));
  CLA_4Bit CLA5(.A(A[23:20]), .B(B[23:20]), .Cin(c4), .S(S[23:20]), .Cout(c5));
  CLA_4Bit CLA6(.A(A[27:24]), .B(B[27:24]), .Cin(c5), .S(S[27:24]), .Cout(c6));
  CLA_4Bit CLA7(.A(A[31:28]), .B(B[31:28]), .Cin(c6), .S(S[31:28]), .Cout(Cout));
  

endmodule


