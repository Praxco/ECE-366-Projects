// Testbench for 4-Bit RCA/RCS module from part c of problem 1
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

endmodule
