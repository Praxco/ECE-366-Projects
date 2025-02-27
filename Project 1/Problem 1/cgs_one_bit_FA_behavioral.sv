// 1-Bit Full Adder Behavioral
// Written by Cole Garrett S.
module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (A ^ B & Cin);
  // could also write: assign{S, Cout} = A + B + Cin;
endmodule
