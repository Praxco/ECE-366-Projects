// Final submission for problem 2, 32 bit CLA

module gp_4bit(A, B, G, P);
  input [3:0] A, B;
  output [3:0] G, P;
  
  assign G = A & B;
  assign P = A | B;
endmodule

module carry_logic_4bit(G, P, Cin, C, Cout);
  input [3:0] G, P;
  input Cin;
  output [3:0] C;
  output Cout;
  
  assign C[0] = Cin;  
  assign C[1] = G[0] | (P[0] & C[0]);
  assign C[2] = G[1] | (P[1] & C[1]);  
  assign C[3] = G[2] | (P[2] & C[2]);
  assign Cout = G[3] | (P[3] & C[3]);
  
  
endmodule

module cla_4bit(A, B, Cin, S, Cout);
  input [3:0] A, B;
  input Cin;
  output [3:0] S;
  output Cout;
  
  wire [3:0] G, P, Cint;
  
  gp_4bit gp(.A(A), .B(B), .G(G), .P(P));
  carry_logic_4bit cl(.G(G), .P(P), .Cin(Cin), .C(Cint), .Cout(Cout));
  
  assign S = A ^ B ^ Cint;
  
endmodule

module cla_32bit(A, B, Cin, S, Cout);
  input [31:0] A, B;
  input Cin;
  output [31:0] S;
  output Cout;
  
  wire C1, C2, C3, C4, C5, C6, C7, C8;
  wire [3:0] S0, S1, S2, S3, S4, S5, S6, S7;
  
  cla_4bit cla0(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C1));
  cla_4bit cla1(.A(A[7:4]), .B(B[7:4]), .Cin(C1), .S(S[7:4]), .Cout(C2));  
  cla_4bit cla2(.A(A[11:8]), .B(B[11:8]), .Cin(C2), .S(S[11:8]), .Cout(C3));
  cla_4bit cla3(.A(A[15:12]), .B(B[15:12]), .Cin(C3), .S(S[15:12]), .Cout(C4));
  cla_4bit cla4(.A(A[19:16]), .B(B[19:16]), .Cin(C4), .S(S[19:16]), .Cout(C5));
  cla_4bit cla5(.A(A[23:20]), .B(B[23:20]), .Cin(C5), .S(S[23:20]), .Cout(C6));
  cla_4bit cla6(.A(A[27:24]), .B(B[27:24]), .Cin(C6), .S(S[27:24]), .Cout(C7));
  cla_4bit cla7(.A(A[31:28]), .B(B[31:28]), .Cin(C7), .S(S[31:28]), .Cout(C8));
  
  assign Cout = C8;
  
endmodule

`timescale 1ns / 1ps
module CLA_32Bit_tb();
  reg [31:0] A, B; 
  reg Cin;
  
  wire [31:0] S;
  wire Cout;
  
  cla_32bit DUT0(A, B, Cin, S, Cout);
  
  initial begin
    $display("         A           B  Cin       S Cout");
    $display("----------------------------------------");
    #5;
    $monitor("%d, %d, %b, %d, %b", A, B, Cin, S, Cout);
    A = 32'd0; B = 32'd0; Cin = 0;
    #5 A = 32'd45; B = 32'd45; // 45+45=90
    #5 A = 32'd10; B = 32'd50; // 10+50=60
    #5 A = 32'd68; B = 32'd87; // 68+87=155
    #5 A = 32'd879; B = 32'd5864; // 879+5864=6743
  	#5 A = 32'd385; B = 32'd5425; // 385+5425=5810
  	#5 A = 32'd516; B = 32'd654; // 516+654=1170
    #5 A = 32'd32; B = 32'd456; Cin = 1; //1+32+456=489
    #5 A = 32'd123; B = 32'd568; // 1+123+568=692
    #5 A = 32'd938; B = 32'd84; // 1+938+84=1023
    #5 A = 32'd354; B = 32'd6853; // 1+354+6853=7208
    #5 A = 32'd8546; B = 32'd789; // 1+8546+789=9336
    #5 A = 32'd353; B = 32'd647; // 1+353+647=1001
    
    #5 $finish;
  end
endmodule
