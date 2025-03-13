module precomputation(A, B, P, G);
  input A, B;
  output P, G;
  assign P = A ^ B;
  assign G = A & B;
endmodule

module blackCell(Gprev, Gcurr, Pprev, Pcurr, Pout, Gout);
  input Gcurr, Gprev, Pcurr, Pprev;
  output Pout, Gout;
  
  assign Pout = Pcurr & Pprev;
  assign Gout = Gcurr | (Pcurr & Gprev);
endmodule

module grayCell(Gprev, Gcurr, Pcurr, Gout);
  input Gcurr, Pcurr, Gprev;
  output Gout;
  
  assign Gout = Gcurr | (Pcurr & Gprev);
endmodule

module postcomputation(GC, P, S);
  input GC, P;
  output S;
  
  assign S = GC ^ P;
endmodule

module KoggeStone16bit (A, B, Cin, S, Cout);
  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;
  wire [15:0] P, G, GA, GB, GC, PA, PB, PC, GZ;
  // GA and PA are carries of level 1
  // GB and PB are carries of level 2
  // GC and PC are carries of level 3
  // GZ is generated carry out / carry for postcomputation (final G from i to j for bit i:j in postcomp)
  // precomputation
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : precomp
      precomputation pc(.A(A[i]), .B(B[i]), .P(P[i]), .G(G[i]));
    end
  endgenerate
  // Level 1
  
  grayCell G1_0(Cin, G[1], P[1], GZ[1]);
  blackCell PG2_1(G[1], G[2], P[1], P[2], PA[0], GA[0]);
  blackCell PG3_2(G[2], G[3], P[2], P[3], PA[1], GA[1]);
  blackCell PG4_3(G[3], G[4], P[3], P[4], PA[2], GA[2]);
  blackCell PG5_4(G[4], G[5], P[4], P[5], PA[3], GA[3]);
  blackCell PG6_5(G[5], G[6], P[5], P[6], PA[4], GA[4]);
  blackCell PG7_6(G[6], G[7], P[6], P[7], PA[5], GA[5]);
  blackCell PG8_7(G[7], G[8], P[7], P[8], PA[6], GA[6]);
  blackCell PG9_8(G[8], G[9], P[8], P[9], PA[7], GA[7]);
  blackCell PG10_9(G[9], G[10], P[9], P[10], PA[8], GA[8]);
  blackCell PG11_10(G[10], G[11], P[10], P[11], PA[9], GA[9]);
  blackCell PG12_11(G[11], G[12], P[11], P[12], PA[10], GA[10]);
  blackCell PG13_12(G[12], G[13], P[12], P[13], PA[11], GA[11]);
  blackCell PG14_13(G[13], G[14], P[13], P[14], PA[12], GA[12]);
  blackCell PG15_14(G[14], G[15], P[14], P[15], PA[13], GA[13]);
  
  // Level 2
  
  grayCell G2_0(Cin, GA[0], PA[0], GZ[2]);
  grayCell G3_0(GZ[1], GA[1], PA[1], GZ[3]);
  blackCell PG4_1(GA[0], GA[2], PA[0], PA[2], PB[0], GB[0]);
  blackCell PG5_2(GA[1], GA[3], PA[1], PA[3], PB[1], GB[1]);
  blackCell PG6_3(GA[2], GA[4], PA[2], PA[4], PB[2], GB[2]);
  blackCell PG7_4(GA[3], GA[5], PA[3], PA[5], PB[3], GB[3]);
  blackCell PG8_5(GA[4], GA[6], PA[4], PA[6], PB[4], GB[4]);
  blackCell PG9_6(GA[5], GA[7], PA[5], PA[7], PB[5], GB[5]);
  blackCell PG10_7(GA[6], GA[8], PA[6], PA[8], PB[6], GB[6]);
  blackCell PG11_8(GA[7], GA[9], PA[7], PA[9], PB[7], GB[7]);
  blackCell PG12_9(GA[8], GA[10], PA[8], PA[10], PB[8], GB[8]);
  blackCell PG13_10(GA[9], GA[11], PA[9], PA[11], PB[9], GB[9]);
  blackCell PG14_11(GA[10], GA[12], PA[10], PA[12], PB[10], GB[10]);
  blackCell PG15_12(GA[11], GA[13], PA[11], PA[13], PB[11], GB[11]);
  
  // Level 3
  
  grayCell G4_0(Cin, GB[0], PB[1], GZ[4]);
  grayCell G5_0(GZ[1], GB[1], PB[1], GZ[5]);
  grayCell G6_0(GZ[2], GB[2], PB[2], GZ[6]);
  grayCell G7_0(GZ[3], GB[3], PB[3], GZ[7]);
  blackCell PG8_1(GB[0], GB[4], PB[0], PB[4], PC[0], GC[0]);
  blackCell PG9_2(GB[1], GB[5], PB[1], PB[5], PC[1], GC[1]);
  blackCell PG10_3(GB[2], GB[6], PB[2], PB[6], PC[2], GC[2]);
  blackCell PG11_4(GB[3], GB[7], PB[3], PB[7], PC[3], GC[3]);
  blackCell PG12_5(GB[4], GB[8], PB[4], PB[8], PC[4], GC[4]);
  blackCell PG13_6(GB[5], GB[9], PB[5], PB[9], PC[5], GC[5]);
  blackCell PG14_7(GB[6], GB[10], PB[6], PB[10], PC[6], GC[6]);
  blackCell PG15_8(GB[7], GB[11], PB[7], PB[11], PC[7], GC[7]);
  
  // Level 4
  grayCell G8_0(Cin, GC[0], PC[0], GZ[8]);
  grayCell G9_0(GZ[1], GC[1], PC[1], GZ[9]);
  grayCell G10_0(GZ[2], GC[2], PC[2], GZ[10]);
  grayCell G11_0(GZ[3], GC[3], PC[3], GZ[11]);
  grayCell G12_0(GZ[4], GC[4], PC[4], GZ[12]);
  grayCell G13_0(GZ[5], GC[5], PC[5], GZ[13]);
  grayCell G14_0(GZ[6], GC[6], PC[6], GZ[14]);
  grayCell G15_0(GZ[7], GC[7], PC[7], GZ[15]);
  

  // Postcomputation
  
  assign Cout = GZ[15];
  postcomputation S0(Cin, P[0], S[0]);
  postcomputation S1(GZ[1], P[1], S[1]);
  postcomputation S2(GZ[1], P[2], S[2]);
  postcomputation S3(GZ[2], P[3], S[3]);
  postcomputation S4(GZ[3], P[4], S[4]);
  postcomputation S5(GZ[4], P[5], S[5]);
  postcomputation S6(GZ[5], P[6], S[6]);
  postcomputation S7(GZ[6], P[7], S[7]);
  postcomputation S8(GZ[7], P[8], S[8]);
  postcomputation S9(GZ[8], P[9], S[9]);
  postcomputation S10(GZ[9], P[10], S[10]);
  postcomputation S11(GZ[10], P[11], S[11]);
  postcomputation S12(GZ[11], P[12], S[12]);
  postcomputation S13(GZ[12], P[13], S[13]);
  postcomputation S14(GZ[13], P[14], S[14]);
  postcomputation S15(GZ[14], P[15], S[15]);
  
endmodule

  
  

`timescale 1ns / 1ps
`timescale 1ns / 1ps
module KoggeStone16bitTB();
  reg [15:0] A, B; 
  reg Cin;
  
  wire [15:0] S;
  wire Cout;
  
  KoggeStone16bit DUT0(A, B, Cin, S, Cout);
  
  initial begin
    $display("         A           B  Cin       S Cout");
    $display("----------------------------------------");
    
    $monitor("%d, %d, %b, %d, %b", A, B, Cin, S, Cout);
    A = 16'd0; B = 16'd0; Cin = 0;
    #5 A = 16'd45; B = 16'd45; // 45+45=90
    #5 A = 16'd10; B = 16'd50; // 10+50=60
    #5 A = 16'd68; B = 16'd87; // 68+87=155
    #5 A = 16'd879; B = 16'd5864; // 879+5864=6743
  	#5 A = 16'd385; B = 16'd5425; // 385+5425=5810
  	#5 A = 16'd516; B = 16'd654; // 516+654=1170
    #5 A = 16'd32; B = 16'd456; Cin = 1; //1+32+456=489
    #5 A = 16'd123; B = 16'd568; // 1+123+568=692
    #5 A = 16'd938; B = 16'd87; // 1+938+87=1026
    #5 A = 16'd354; B = 16'd6853; // 1+354+6853=7208
    #5 A = 16'd8546; B = 16'd789; // 1+8546+789=9336
    #5 A = 16'd353; B = 16'd647; // 1+353+647=1001
    
    #5 $finish;
  end
  
  initial 
  begin 
  $dumpfile("dump.vcd"); 
  $dumpvars(1); 
  end;
  
endmodule
