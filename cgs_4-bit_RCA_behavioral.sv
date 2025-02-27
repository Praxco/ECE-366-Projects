// 4-Bit Ripple Carry Adder
// Written by Cole Garrett S.

// 1-bit FA from previous file
module one_bit_full_adder(A, B, Cin, S, Cout);
  input A, B, Cin;
  output S, Cout;

  assign S = A ^ B ^ Cin;
  assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule


module four_bit_RCA (A, B, Cin, S, Cout);
  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;

endmodule


  

  
  
