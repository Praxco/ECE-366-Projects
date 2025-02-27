// Structural 1-Bit Full Adder;
// Written by Cole Garrett S.
module full_adder(input A, B, Cin, output S, Cout);
  wire t1, t2, t3; // intermediate wires

  // Sum
  xor U1 (t1, A, B); // t1 = A ^ B
  xor U2 (S, t1, Cin); // S = A ^ B ^ Cin

  // AND gates for carry 
  and U3 (t2, A, B); // t2 = A & B
  and U4 (t3, t2, Cin); // t3 = A & B & Cin

  // OR gates for Cout
  or U5 (Cout, t1, t3); // Cout = (A & B) | (A & Cin) | (B & Cin)
endmodule
