// Structural 1-Bit Full Adder;
// Written by Cole Garrett S.
module full_adder(input A, B, Cin, output S, Cout);
  wire t1, t2, t3, t4, t5; // intermediate wires

  // Sum
  xor U1 (t1 A, B); // t1 = A ^ B
  xor U2 (S, t1, Cin); // S = A ^ B ^ Cin

  // AND gates for carry 
  and U3 (t2, A, B); // t2 = A & B
  and U4 (t3, A, Cin); // t3 = A & Cin
  and U5 (t4, B, Cin); // t4 = B & Cin

  // OR gates for Cout
  or U6 (t5, t2, t3); // t5 = (A & B) | (A & Cin)
  or U7 (Cout, t4, t5); // Cout = (A & B) | (A & Cin) | (B & Cin)
endmodule
