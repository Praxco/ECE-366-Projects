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


`timescale 1ns / 1ps

module TestBench_4Bit_FA;
  reg [3:0] A, B;
  reg Cin;
  reg mode;
  wire [3:0] S;
  wire Cout;
  
  // Instantiate 4Bit FA module
  four_bit_RCA_RCS uut ( .A(A), .B(B), .Cin(Cin), .mode(mode), .S(S), .Cout(Cout));
  initial begin
       // Display header
    	$display("A B Cin | Mode | Sum S | Cout");

        // Unsigned Addition
        mode = 0; Cin = 0;
        A = 4'b0001; B = 4'b0010; #10; // Unsigned 1 + 2 = 3
    	$display("%0b %0b %0b | %0b | %0b | %0b | Unsigned 1 + 2 = 3", A, B, Cin, mode, S, Cout);

        A = 4'b0111; B = 4'b0100; #10; // Unsigned 7 + 4 = 11
    	$display("%0b %0b %0b | %0b | %0b | %0b | Unsigned 7 + 4 = 11", A, B, Cin, mode, S, Cout);

        // Unsigned Subtraction
        mode = 1; Cin = 0;
        A = 4'b1010; B = 4'b0011; #10; // Unsigned 10 - 3 = 7
    	$display("%0b %0b %0b | %0b | %0b | %0b | Unsigned 10 - 3 = 7", A, B, Cin, mode, S, Cout);

        A = 4'b1100; B = 4'b0111; #10; // Unsigned 12 - 7 = 5
    	$display("%0b %0b %0b | %0b | %0b | %0b | Unsigned 12 - 7 = 5", A, B, Cin, mode, S, Cout);

        // Signed Addition (2's complement)
        mode = 0; Cin = 0;
    	A = 4'b0100; B = 4'b1101; #10; // Signed 4 + (-3) = 1
    	$display("%0b %0b %0b | %0b | %0b | %0b | Signed 4 + (-3) = 1", A, B, Cin, mode, S, Cout);

    	A = 4'b1100; B = 4'b1110; #10; // Signed -4 + (-2) = -6
    	$display("%0b %0b %0b | %0b | %0b | %0b | Signed -4 + (-2) = -6", A, B, Cin, mode, S, Cout);

        // Signed Subtraction (2's complement)
        mode = 1; Cin = 0;
    	A = 4'b0011; B = 4'b1100; #10; // Signed 3 - (-4) = 7
    	$display("%0b %0b %0b | %0b | %0b | %0b | Signed 3 - (-4) = 7", A, B, Cin, mode, S, Cout);

        A = 4'b1101; B = 4'b0011; #10; // Signed -3 - 3 = -6
    	$display("%0b %0b %0b | %0b | %0b | %0b | Signed -3 - 3 = -6", A, B, Cin, mode, S, Cout);

        // Unsigned with Carry-in
        mode = 0; Cin = 1;
        A = 4'b0101; B = 4'b0111; #10; // Unsigned 5 + 7 with Cin = 1 = 13
    	$display("%0b %0b %0b | %0b | %0b | %0b | Unsigned 5 + 7 with Cin = 1 = 13", A, B, Cin, mode, S, Cout);

        $finish;
    end

  initial 
  begin 
  $dumpfile("dump.vcd"); 
  $dumpvars(1); 
  end;
  
endmodule
