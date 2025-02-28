// Problem 2 32 Bit CLA; This is mostly made using behavioral models on the smaller modules, and then putting the CLA together structurally
module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (A ^ B & Cin);
endmodule


module four_bit_RCA (A, B, Cin, mode, S, Cout);
  input [3:0] A, B;
  input Cin, mode;
  output [3:0] S;
  output Cout;
  
  // Internal carry signals for individual adders
  wire c1, c2, c3;
  
  // Instantiate four 1-bit full adders from above module
  one_bit_full_adder F0( .A(A[0]), .B(sub_B[0]), .Cin(Cin), .S(S[0]), .Cout(c1));
  one_bit_full_adder F1( .A(A[1]), .B(sub_B[1]), .Cin(c1), .S(S[1]), .Cout(c2));
  one_bit_full_adder F2( .A(A[2]), .B(sub_B[2]), .Cin(c2), .S(S[2]), .Cout(c3));
  one_bit_full_adder F3( .A(A[3]), .B(sub_B[3]), .Cin(c3), .S(S[3]), .Cout(Cout));
  
endmodule

module G_and_P (A, B, G, P);
  input [3:0] A, B;
  output [3:0] G, P;
  
  assign G = A & B;
  assign P = A | B;
  
endmodule

module carry_logic (P, G, Cin, Cout);
  input [3:0] P, G;
  input Cin;
  output [3:0] Cout;
  
  wire [3:0] Ctemp;
  
  // Carries:
  assign Ctemp[0] = G[0] | (P[0] & Cin);
  assign Ctemp[1] = G[1] | (P[1] & Ctemp[0]);  
  assign Ctemp[2] = G[2] | (P[2] & Ctemp[1]);
  assign Ctemp[3] = G[3] | (P[3] & Ctemp[2]);
  
  assign C = Ctemp;
  
endmodule

module CLA_module_4Bit(A, B, G, P, Cin, S, Cout);
  input [3:0] A, B, G, P;
  input Cin;
  output [3:0] S;
  output Cout;

  four_bit_RCA (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

  g_and_p(.A(A), .B(B), .P(P), .G(G));
  carry_logic(.P(P), .G(G), .Cin(Cin), .Cout(Cout));
  
endmodule


module CLA(A, B, Cin, S, Cout);

 input [31:0] A, B;
 input Cin;
 output [31:0] S;
 output Cout;

endmodule

