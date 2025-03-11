module Sum(S, A, B, Cin);								// Sum module 
  input A, B, Cin;
  output S;
  
  assign S = (A ^ B) ^ Cin;
endmodule


module Intermediate_P_G(PN, GN, PR, PL, GR, GL);
  input PR, PL, GR, GL;
  output PN,  GN;
  
  assign GN = (PL & GR) | GL;				// "Next" generated carry
  assign PN = PR & PL;						// "Next" propagated carry
endmodule


module P_G_i(G, P, A, B);					// ith bit P and G
  input A, B;
  output G, P;
  
  assign P = A | B;
  assign G = A & B;
endmodule


module Main(Sum, A, B, Cin, p_0);
  output [15:0] Sum;
  input Cin, p_0;
  input [15:0] A, B;
   
  wire [15:0] s, PN, GN, G, P; 
  wire [16:0] tempPN, tempGN;
   
  P_G_i P_G_i_15(.G(G[15]), .P(P[15]), .A(A[15]), .B(B[15]));
  P_G_i P_G_i_14(.G(G[14]), .P(P[14]), .A(A[14]), .B(B[14]));    
  P_G_i P_G_i_13(.G(G[13]), .P(P[13]), .A(A[13]), .B(B[13]));  
  P_G_i P_G_i_12(.G(G[12]), .P(P[12]), .A(A[12]), .B(B[12]));    
  P_G_i P_G_i_11(.G(G[11]), .P(P[11]), .A(A[11]), .B(B[11]));  
  P_G_i P_G_i_10(.G(G[10]), .P(P[10]), .A(A[10]), .B(B[10]));  
  P_G_i P_G_i_9(.G(G[9]), .P(P[9]), .A(A[9]), .B(B[9]));  
  P_G_i P_G_i_8(.G(G[8]), .P(P[8]), .A(A[8]), .B(B[8]));  
  P_G_i P_G_i_7(.G(G[7]), .P(P[7]), .A(A[7]), .B(B[7]));
  P_G_i P_G_i_6(.G(G[6]), .P(P[6]), .A(A[6]), .B(B[6]));    
  P_G_i P_G_i_5(.G(G[5]), .P(P[5]), .A(A[5]), .B(B[5]));  
  P_G_i P_G_i_4(.G(G[4]), .P(P[4]), .A(A[4]), .B(B[4]));
  P_G_i P_G_i_3(.G(G[3]), .P(P[3]), .A(A[3]), .B(B[3]));
  P_G_i P_G_i_2(.G(G[2]), .P(P[2]), .A(A[2]), .B(B[2]));  
  P_G_i P_G_i_1(.G(G[1]), .P(P[1]), .A(A[1]), .B(B[1]));
  P_G_i P_G_i_0(.G(G[0]), .P(P[0]), .A(A[0]), .B(B[0])); 
  
  Intermediate_P_G c0 (.PN(PN[0]) , .GN(GN[0]) , .PR(p_0), .PL(P[0]), .GR(Cin), .GL(G[0]));
  Intermediate_P_G c1 (.PN(PN[1]) , .GN(GN[1]) , .PR(PN[0]) , .PL(P[1]), .GR(GN[0]) , .GL(G[1]));
  Intermediate_P_G c2 (.PN(PN[2]) , .GN(GN[2]) , .PR(PN[0]) , .PL(tempPN[0]) , .GR(GN[0]) , .GL(tempGN[0]) );
  Intermediate_P_G c3 (.PN(PN[3]) , .GN(GN[3]) , .PR(PN[2]) , .PL(P[3]), .GR(GN[2]) , .GL(G[3]));
  Intermediate_P_G c4 (.PN(PN[4]) , .GN(GN[4]) , .PR(PN[2]) , .PL(tempPN[1]) , .GR(GN[2]) , .GL(tempGN[1]) );
  Intermediate_P_G c5 (.PN(PN[5]) , .GN(GN[5]) , .PR(PN[2]) , .PL(tempPN[2]) , .GR(GN[2]) , .GL(tempGN[2]) );
  Intermediate_P_G c6 (.PN(PN[6]) , .GN(GN[6]) , .PR(PN[2]) , .PL(tempPN[3]) , .GR(GN[2]) , .GL(tempGN[3]));
  Intermediate_P_G c7 (.PN(PN[7]) , .GN(GN[7]) , .PR(PN[6]) , .PL(P[7]), .GR(GN[6]) , .GL(G[7]));
  Intermediate_P_G c8 (.PN(PN[8]) , .GN(GN[8]) , .PR(PN[6]) , .PL(tempPN[5]) , .GR(GN[6]) , .GL(tempGN[5]) );
  Intermediate_P_G c9 (.PN(PN[9]) , .GN(GN[9]) , .PR(PN[6]) , .PL(tempPN[6]) , .GR(GN[6]) , .GL(tempGN[6]) );
  Intermediate_P_G c10 (.PN(PN[10]) , .GN(GN[10]) , .PR(PN[6]) , .PL(tempPN[7]) , .GR(GN[6]) , .GL(tempGN[7]) );
  Intermediate_P_G c11 (.PN(PN[11]) , .GN(GN[11]) , .PR(PN[6]) , .PL(tempPN[9]) , .GR(GN[6]) , .GL(tempGN[9]) );
  Intermediate_P_G c12 (.PN(PN[12]) , .GN(GN[12]) , .PR(PN[6]) , .PL(tempPN[10]) , .GR(GN[6]) , .GL(tempGN[10]) );
  Intermediate_P_G c13 (.PN(PN[13]) , .GN(GN[13]) , .PR(PN[6]) , .PL(tempPN[12]) , .GR(GN[6]) , .GL(tempGN[12]) );
  Intermediate_P_G c14 (.PN(PN[14]) , .GN(GN[14]) , .PR(PN[6]) , .PL(tempPN[14]) , .GR(GN[6]) , .GL(tempGN[14]) );
  
  Intermediate_P_G temp14to13 (.PN(tempPN[16]) , .GN(tempGN[16]) , .PR(P[13]), .PL(P[14]), .GR(G[13]), .GL(G[14]));
  Intermediate_P_G temp14to11 (.PN(tempPN[15]) , .GN(tempGN[15]) , .PR(tempGN[11]) , .PL(tempPN[16]) , .GR(tempPN[11]) , .GL(tempGN[16]) );
  Intermediate_P_G temp14to7 (.PN(tempPN[14]) , .GN(tempGN[14]) , .PR(tempPN[7]) , .PL(tempPN[15]) , .GR(tempGN[7]) , .GL(tempGN[15]) );
  Intermediate_P_G temp13to11 (.PN(tempPN[13]) , .GN(tempGN[13]) , .PR(tempPN[11]) , .PL(P[13]), .GR(tempGN[11]) , .GL(G[13]));
  Intermediate_P_G temp13to7 (.PN(tempPN[12]) , .GN(tempGN[12]) , .PR(tempPN[7]) , .PL(tempPN[13]) , .GR(tempGN[7]) , .GL(tempGN[13]) );
  Intermediate_P_G temp12to11 (.PN(tempPN[11]) , .GN(tempGN[11]) , .PR(P[11]), .PL(P[12]), .GR(G[11]), .GL(G[12]));
  Intermediate_P_G temp12to7 (.PN(tempPN[10]) , .GN(tempGN[10]) , .PR(tempPN[7]) , .PL(tempPN[11]) , .GR(tempGN[7]) , .GL(tempGN[11]) );
  Intermediate_P_G temp11to7 (.PN(tempPN[9]) , .GN(tempGN[9]) , .PR(tempPN[7]) , .PL(P[11]), .GR(tempGN[7]) , .GL(G[11]));
  Intermediate_P_G temp10to9 (.PN(tempPN[8]) , .GN(tempGN[8]) , .PR(P[9]), .PL(P[10]), .GR(G[9]), .GL(G[10]));
  Intermediate_P_G temp10to7 (.PN(tempPN[7]) , .GN(tempGN[7]) , .PR(tempPN[5]) , .PL(tempPN[8]) , .GR(tempGN[5]) , .GL(tempGN[8]) );
  Intermediate_P_G temp9to7 (.PN(tempPN[6]) , .GN(tempGN[6]) , .PR(tempPN[5]) , .PL(P[9]), .GR(tempGN[5]) , .GL(G[9]));
  Intermediate_P_G temp8to7 (.PN(tempPN[5]) , .GN(tempGN[5]) , .PR(P[7]), .PL(P[8]), .GR(G[7]), .GL(G[8]));
  Intermediate_P_G temp6to5 (.PN(tempPN[4]) , .GN(tempGN[4]) , .PR(P[5]), .PL(P[6]), .GR(G[5]), .GL(G[6]));
  Intermediate_P_G temp6to3 (.PN(tempPN[3]) , .GN(tempGN[3]) , .PR(tempPN[1]) , .PL(tempPN[4]) , .GR(tempGN[1]) , .GL(tempGN[4]) );
  Intermediate_P_G temp5to3 (.PN(tempPN[2]) , .GN(tempGN[2]) , .PR(tempPN[1]) , .PL(P[5]), .GR(tempGN[1]) , .GL(G[5]));
  Intermediate_P_G temp4to3 (.PN(tempPN[1]) , .GN(tempGN[1]) , .PR(P[3]), .PL(P[4]), .GR(G[3]), .GL(G[4]));
  Intermediate_P_G temp2to1 (.PN(tempPN[0]) , .GN(tempGN[0]) , .PR(P[1]), .PL(P[2]), .GR(G[1]), .GL(G[2]));
  
  Sum Sum0(.S(s[0]), .A(A[0]), .B(B[0]), .Cin(Cin));
  Sum Sum1(.S(s[1]), .A(A[1]), .B(B[1]), .Cin(GN[0]));
  Sum Sum2(.S(s[2]), .A(A[2]), .B(B[2]), .Cin(GN[1]));
  Sum Sum3(.S(s[3]), .A(A[3]), .B(B[3]), .Cin(GN[2])); 
  Sum Sum4(.S(s[4]), .A(A[4]), .B(B[4]), .Cin(GN[3]));
  Sum Sum5(.S(s[5]), .A(A[5]), .B(B[5]), .Cin(GN[4]));
  Sum Sum6(.S(s[6]), .A(A[6]), .B(B[6]), .Cin(GN[5])); 
  Sum Sum7(.S(s[7]), .A(A[7]), .B(B[7]), .Cin(GN[6]));  
  Sum Sum8(.S(s[8]), .A(A[8]), .B(B[8]), .Cin(GN[7]));
  Sum Sum9(.S(s[9]), .A(A[9]), .B(B[9]), .Cin(GN[8]));
  Sum Sum10(.S(s[10]), .A(A[10]), .B(B[10]), .Cin(GN[9]));
  Sum Sum11(.S(s[11]), .A(A[11]), .B(B[11]), .Cin(GN[10]));
  Sum Sum12(.S(s[12]), .A(A[12]), .B(B[12]), .Cin(GN[11]));
  Sum Sum13(.S(s[13]), .A(A[13]), .B(B[13]), .Cin(GN[12]));
  Sum Sum14(.S(s[14]), .A(A[14]), .B(B[14]), .Cin(GN[13]));
  Sum Sum15(.S(s[15]), .A(A[15]), .B(B[15]), .Cin(GN[14])); 
  
  assign Sum = s[15:0];
 
endmodule
