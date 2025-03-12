module precomputation(A, B, P, G);
  input A, B;
  output P, G;
  assign P = A ^ B;
  assign G = A & B;
endmodule

module blackCell( Gik, Gkj, Pik, Pkj, Pout, Gout);
  input Gik, Gkj, Pik, Pkj;
  output Pout, Gout;
  
  assign Pout = Pik ^ Pkj;
  assign Gout = Gik | (Pik & Gkj);
endmodule

module grayCell(Gik, Gkj, Pik, Gout);
  input Gik, Pik, Gkj;
  output Gout;
  
  assign Gout = Gik | (Pik & Gkj);
endmodule

module postcomputation(Gi0, P, S);
  input Gi0, P;
  output S;
  
  assign S = Gi0 ^ P;
endmodule

module KoggeStone16bit(A, B, Cin, S, Cout);
  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;
  
  wire [15:0] G, Gik, Gkj, Gij1, Gij2, Gij3, Gij4, P, Pik, Pkj, Pij1, Pij2, Pij3;
  // G and P are precompute values
  // Gik and Pik are the current block P and Gs
  // Gkj and Pkj are the previous/connected/carried P and G from last block
  // Gij(x) and Pij(x) are the outputs of level x, to be sent to next level
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : precomp
      precomputation pc(.A(A[i]), .B(B[i]), .P(P[i]), .G(G[i]));
    end
  endgenerate
  
  // Level 1
  grayCell G1_0(.Gik(G[0]), .Gkj(Cin), .Pik(P[0]), .Gout(Gij1[0]));
  blackCell PG2_1(.Gik(G[2]), .Gkj(G[1]), .Pik(P[2]), .Pkj(P[1]), .Pout(Pij1[1]), .Gout(Gij1[1]));
  blackCell PG3_2(.Gik(G[3]), .Gkj(G[2]), .Pik(P[3]), .Pkj(P[2]), .Pout(Pij1[2]), .Gout(Gij1[2]));
  blackCell PG4_3(.Gik(G[4]), .Gkj(G[3]), .Pik(P[4]), .Pkj(P[3]), .Pout(Pij1[3]), .Gout(Gij1[3]));
  blackCell PG5_4(.Gik(G[5]), .Gkj(G[4]), .Pik(P[5]), .Pkj(P[4]), .Pout(Pij1[4]), .Gout(Gij1[4]));
  blackCell PG6_5(.Gik(G[6]), .Gkj(G[5]), .Pik(P[6]), .Pkj(P[5]), .Pout(Pij1[5]), .Gout(Gij1[5]));
  blackCell PG7_6(.Gik(G[7]), .Gkj(G[6]), .Pik(P[7]), .Pkj(P[6]), .Pout(Pij1[6]), .Gout(Gij1[6]));
  blackCell PG8_7(.Gik(G[8]), .Gkj(G[7]), .Pik(P[8]), .Pkj(P[7]), .Pout(Pij1[7]), .Gout(Gij1[7]));
  blackCell PG9_8(.Gik(G[9]), .Gkj(G[8]), .Pik(P[9]), .Pkj(P[8]), .Pout(Pij1[8]), .Gout(Gij1[8]));
  blackCell PG10_9(.Gik(G[10]), .Gkj(G[9]), .Pik(P[10]), .Pkj(P[9]), .Pout(Pij1[9]), .Gout(Gij1[9]));
  blackCell PG11_10(.Gik(G[11]), .Gkj(G[10]), .Pik(P[11]), .Pkj(P[10]), .Pout(Pij1[10]), .Gout(Gij1[10]));
  blackCell PG12_11(.Gik(G[12]), .Gkj(G[11]), .Pik(P[12]), .Pkj(P[11]), .Pout(Pij1[11]), .Gout(Gij1[11]));
  blackCell PG13_12(.Gik(G[13]), .Gkj(G[12]), .Pik(P[13]), .Pkj(P[12]), .Pout(Pij1[12]), .Gout(Gij1[12]));
  blackCell PG14_13(.Gik(G[14]), .Gkj(G[13]), .Pik(P[14]), .Pkj(P[13]), .Pout(Pij1[13]), .Gout(Gij1[13]));
  blackCell PG15_14(.Gik(G[15]), .Gkj(G[14]), .Pik(P[15]), .Pkj(P[14]), .Pout(Pij1[14]), .Gout(Gij1[14]));
  
  
  // Level 2
  grayCell G2_0(.Gik(Gij1[1]), .Gkj(Cin), .Pik(Pij1[1]), .Gout(Gij2[1]));
  grayCell G3_0(.Gik(Gij1[2]), .Gkj(Gij1[0]), .Pik(Pij1[2]), .Gout(Gij2[2]));
  blackCell PG4_1(.Gik(Gij1[3]), .Gkj(Gij1[1]), .Pik(Pij1[3]), .Pkj(Pij1[1]), .Pout(Pij2[3]), .Gout(Gij2[3]));
  blackCell PG5_2(.Gik(Gij1[4]), .Gkj(Gij1[2]), .Pik(Pij1[4]), .Pkj(Pij1[2]), .Pout(Pij2[4]), .Gout(Gij2[4]));
  blackCell PG6_3(.Gik(Gij1[5]), .Gkj(Gij1[3]), .Pik(Pij1[5]), .Pkj(Pij1[3]), .Pout(Pij2[5]), .Gout(Gij2[5]));
  blackCell PG7_4(.Gik(Gij1[6]), .Gkj(Gij1[4]), .Pik(Pij1[6]), .Pkj(Pij1[4]), .Pout(Pij2[6]), .Gout(Gij2[6])); 
  blackCell PG8_5(.Gik(Gij1[7]), .Gkj(Gij1[5]), .Pik(Pij1[7]), .Pkj(Pij1[5]), .Pout(Pij2[7]), .Gout(Gij2[7]));
  blackCell PG9_6(.Gik(Gij1[8]), .Gkj(Gij1[6]), .Pik(Pij1[8]), .Pkj(Pij1[6]), .Pout(Pij2[8]), .Gout(Gij2[8]));
  blackCell PG10_7(.Gik(Gij1[9]), .Gkj(Gij1[7]), .Pik(Pij1[9]), .Pkj(Pij1[7]), .Pout(Pij2[9]), .Gout(Gij2[9]));
  blackCell PG11_8(.Gik(Gij1[10]), .Gkj(Gij1[8]), .Pik(Pij1[10]), .Pkj(Pij1[8]), .Pout(Pij2[10]), .Gout(Gij2[10]));
  blackCell PG12_9(.Gik(Gij1[11]), .Gkj(Gij1[9]), .Pik(Pij1[11]), .Pkj(Pij1[9]), .Pout(Pij2[11]), .Gout(Gij2[11]));
  blackCell PG13_10(.Gik(Gij1[12]), .Gkj(Gij1[10]), .Pik(Pij1[12]), .Pkj(Pij1[10]), .Pout(Pij2[12]), .Gout(Gij2[12]));
  blackCell PG14_11(.Gik(Gij1[13]), .Gkj(Gij1[11]), .Pik(Pij1[13]), .Pkj(Pij1[11]), .Pout(Pij2[13]), .Gout(Gij2[13]));
  blackCell PG15_12(.Gik(Gij1[14]), .Gkj(Gij1[12]), .Pik(Pij1[14]), .Pkj(Pij1[12]), .Pout(Pij2[14]), .Gout(Gij2[14]));

  
  // Level 3
  
  grayCell G4_0(.Gik(Gij2[3]), .Gkj(Cin), .Pik(Pij2[3]), .Gout(Gij3[3]));
  grayCell G5_0(.Gik(Gij2[4]), .Gkj(Gij1[0]), .Pik(Pij2[4]), .Gout(Gij3[4]));
  grayCell G6_0(.Gik(Gij2[5]), .Gkj(Gij2[1]), .Pik(Pij2[5]), .Gout(Gij3[5]));
  grayCell G7_0(.Gik(Gij2[6]), .Gkj(Gij2[2]), .Pik(Pij2[6]), .Gout(Gij3[6]));
  blackCell PG8_1(.Gik(Gij2[7]), .Gkj(Gij2[3]), .Pik(Pij2[7]), .Pkj(Pij2[3]), .Pout(Pij3[7]), .Gout(Gij3[7]));
  blackCell PG9_2(.Gik(Gij2[8]), .Gkj(Gij2[4]), .Pik(Pij2[8]), .Pkj(Pij2[4]), .Pout(Pij3[8]), .Gout(Gij3[8]));
  blackCell PG10_3(.Gik(Gij2[9]), .Gkj(Gij2[5]), .Pik(Pij2[9]), .Pkj(Pij2[5]), .Pout(Pij3[9]), .Gout(Gij3[9]));
  blackCell PG11_4(.Gik(Gij2[10]), .Gkj(Gij2[6]), .Pik(Pij2[10]), .Pkj(Pij2[6]), .Pout(Pij3[10]), .Gout(Gij3[10]));
  blackCell PG12_5(.Gik(Gij2[11]), .Gkj(Gij2[7]), .Pik(Pij2[11]), .Pkj(Pij2[7]), .Pout(Pij3[11]), .Gout(Gij3[11]));
  blackCell PG13_6(.Gik(Gij2[12]), .Gkj(Gij2[8]), .Pik(Pij2[12]), .Pkj(Pij2[8]), .Pout(Pij3[12]), .Gout(Gij3[12]));
  blackCell PG14_7(.Gik(Gij2[13]), .Gkj(Gij2[9]), .Pik(Pij2[13]), .Pkj(Pij2[9]), .Pout(Pij3[13]), .Gout(Gij3[13]));
  blackCell PG15_8(.Gik(Gij2[14]), .Gkj(Gij2[10]), .Pik(Pij2[14]), .Pkj(Pij2[10]), .Pout(Pij3[14]), .Gout(Gij3[14]));
  
  // Level 4
  
  grayCell G8_0(.Gik(Gij3[7]), .Gkj(Cin), .Pik(Pij3[7]), .Gout(Gij4[7]));
  grayCell G9_0(.Gik(Gij3[8]), .Gkj(Gij1[0]), .Pik(Pij3[8]), .Gout(Gij4[8]));
  grayCell G10_0(.Gik(Gij3[9]), .Gkj(Gij2[1]), .Pik(Pij3[9]), .Gout(Gij4[9]));
  grayCell G11_0(.Gik(Gij3[10]), .Gkj(Gij2[2]), .Pik(Pij3[10]), .Gout(Gij4[10]));
  grayCell G12_0(.Gik(Gij3[11]), .Gkj(Gij3[3]), .Pik(Pij3[11]), .Gout(Gij4[11]));
  grayCell G13_0(.Gik(Gij3[12]), .Gkj(Gij3[4]), .Pik(Pij3[12]), .Gout(Gij4[12]));
  grayCell G14_0(.Gik(Gij3[13]), .Gkj(Gij3[5]), .Pik(Pij3[13]), .Gout(Gij4[13]));
  grayCell G15_0(.Gik(Gij3[14]), .Gkj(Gij3[6]), .Pik(Pij3[14]), .Gout(Gij4[14]));
  
  // Sum/Post Processing Stage
  
  grayCell cout(.Gik(Gij3[14]), .Gkj(Cin), .Pik(Pij3[14]), .Gout(Cout));
  
  postcomputation S0(.Gi0(Cin), .P(P[0]), .S(S[0]));
  postcomputation S1(.Gi0(Gij1[0]), .P(P[1]), .S(S[1]));
  postcomputation S2(.Gi0(Gij2[1]), .P(P[2]), .S(S[2]));
  postcomputation S3(.Gi0(Gij2[2]), .P(P[3]), .S(S[3]));
  postcomputation S4(.Gi0(Gij3[3]), .P(P[4]), .S(S[4]));
  postcomputation S5(.Gi0(Gij3[4]), .P(P[5]), .S(S[5]));
  postcomputation S6(.Gi0(Gij3[5]), .P(P[6]), .S(S[6]));
  postcomputation S7(.Gi0(Gij3[6]), .P(P[7]), .S(S[7]));
  postcomputation S8(.Gi0(Gij4[7]), .P(P[8]), .S(S[8]));
  postcomputation S9(.Gi0(Gij4[8]), .P(P[9]), .S(S[9]));
  postcomputation S10(.Gi0(Gij4[9]), .P(P[10]), .S(S[10]));
  postcomputation S11(.Gi0(Gij4[10]), .P(P[11]), .S(S[11]));
  postcomputation S12(.Gi0(Gij4[11]), .P(P[12]), .S(S[12]));
  postcomputation S13(.Gi0(Gij4[12]), .P(P[13]), .S(S[13]));
  postcomputation S14(.Gi0(Gij4[13]), .P(P[14]), .S(S[14]));
  postcomputation S15(.Gi0(Gij4[14]), .P(P[15]), .S(S[15]));
  
  
endmodule
  
  

`timescale 1ns / 1ps
module KoggeStone16bitTB();
  reg [15:0] A, B; 
  reg Cin;
  
  wire [15:0] S;
  wire Cout;
  
  KoggeStone_16bitAdder DUT0(A, B, Cin, S, Cout);
  
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
    #5 A = 16'd938; B = 16'd84; // 1+938+84=1023
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
