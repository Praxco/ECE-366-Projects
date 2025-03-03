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


module Main(Sum, A_Value, B_Value, cin, p_0);
  output [15:0] Sum;
  input cin, p_0;
  input [15:0] A_Value, B_Value;
  
  wire c0_out_0 , c0_out_1 , c2_out_0 , c2_out_1 , c6_out_0 , c6_out_1 , c8_out_0 , c8_out_1 , c10_out_0 , c10_out_1 , c11_out_0 , c11_out_1 , c13_out_0,
  c13_out_1 , c14_out_0 , c14_out_1 ,  c9_out_0 , c9_out_1 , c7_out_0 , c7_out_1 , c5_out_0 , c5_out_1 , c4_out_0 , c4_out_1 , c3_out_0 , c3_out_1,
  c12_out_0, c12_out_1 , 
  
  Sum_62_out, Sum_61_out,  Sum_51_out, Sum_50_out, Sum_52_out, Sum_53_out, Sum_56_out, Sum_55_out,  Sum_49_out, Sum_57_out,
  Sum_59_out, Sum_63_out, Sum_58_out, Sum_60_out, Sum_0_out, Sum_54_out, 
  P_G_i_20_out_0, P_G_i_20_out_1, P_G_i_19_out_0, P_G_i_19_out_1, P_G_i_18_out_0, P_G_i_18_out_1, P_G_i_17_out_0, P_G_i_17_out_1, P_G_i_15_out_0,
  P_G_i_15_out_1, P_G_i_14_out_0, P_G_i_14_out_1, P_G_i_13_out_0, P_G_i_13_out_1, P_G_i_12_out_0, P_G_i_12_out_1, P_G_i_9_out_0, P_G_i_9_out_1,
  P_G_i_8_out_0, P_G_i_8_out_1, P_G_i_6_out_0, P_G_i_6_out_1, P_G_i_3_out_0, P_G_i_3_out_1, P_G_i_2_out_0, P_G_i_2_out_1, P_G_i_5_out_0, P_G_i_5_out_1,
  P_G_i_4_out_0, P_G_i_4_out_1,
  
  temp14to13_out_0, temp14to13_out_1, temp14to11_out_0, temp14to11_out_1, temp14to7_out_0, temp14to7_out_1,  temp13to11_out_0, temp13to11_out_1,
  temp13to7_out_0, temp13to7_out_1, temp12to11_out_0, temp12to11_out_1, temp12to7_out_0, temp11to7_out_1, temp10to9_out_0, temp10to9_out_1, temp10to7_out_0,
  temp10to7_out_1,temp9to7_out_0, temp9to7_out_1, temp8to7_out_0, temp8to7_out_1, temp6to5_out_0, temp6to5_out_1, temp6to3_out_0, temp6to3_out_1,
  temp4to3_out_0, temp4to3_out_1, temp2to1_out_0, temp2to1_out_1, temp5to3_out_0, temp5to3_out_1;
  
  assign Sum =
{Sum_0_out,Sum_49_out,Sum_50_out,Sum_51_out,Sum_52_out,Sum_53_out,Sum_54_out,Sum_55_out,Sum_56_out,Sum_57_out,Sum_58_out,Sum_59_out,Sum_60_out,Sum_61_out,Sum_62_out,Sum_63_out};
  
  Sum Sum_63(Sum_63_out, A_Value[0], B_Value[0], cin);
  Sum Sum_62(Sum_62_out, A_Value[1], B_Value[1], c0_out_1 );
  Sum Sum_61(Sum_61_out, A_Value[2], B_Value[2], c1_out_1 );
  Sum Sum_60(Sum_60_out, A_Value[3], B_Value[3], c2_out_1 ); 
  Sum Sum_59(Sum_59_out, A_Value[4], B_Value[4], c3_out_1 );
  Sum Sum_58(Sum_58_out, A_Value[5], B_Value[5], c4_out_1 );
  Sum Sum_57(Sum_57_out, A_Value[6], B_Value[6], c5_out_1 ); 
  Sum Sum_56(Sum_56_out, A_Value[7], B_Value[7], c6_out_1 );  
  Sum Sum_55(Sum_55_out, A_Value[8], B_Value[8], c7_out_1 );
  Sum Sum_54(Sum_54_out, A_Value[9], B_Value[9], c8_out_1 );
  Sum Sum_53(Sum_53_out, A_Value[10], B_Value[10], c9_out_1 );
  Sum Sum_52(Sum_52_out, A_Value[11], B_Value[11], c10_out_1 );
  Sum Sum_51(Sum_51_out, A_Value[12], B_Value[12], c11_out_1 );
  Sum Sum_50(Sum_50_out, A_Value[13], B_Value[13], c12_out_1 );
  Sum Sum_49(Sum_49_out, A_Value[14], B_Value[14], c13_out_1 );
  Sum Sum_0(Sum_0_out, A_Value[15], B_Value[15], c14_out_1 ); 
  
   
  P_G_i P_G_i_20(P_G_i_20_out_0, P_G_i_20_out_1, A_Value[15], B_Value[15]);
  P_G_i P_G_i_19(P_G_i_19_out_0, P_G_i_19_out_1, A_Value[14], B_Value[14]);    
  P_G_i P_G_i_18(P_G_i_18_out_0, P_G_i_18_out_1, A_Value[13], B_Value[13]);  
  P_G_i P_G_i_17(P_G_i_17_out_0, P_G_i_17_out_1, A_Value[12], B_Value[12]);    
  P_G_i P_G_i_16(P_G_i_16_out_0, P_G_i_16_out_1, A_Value[11], B_Value[11]);  
  P_G_i P_G_i_15(P_G_i_15_out_0, P_G_i_15_out_1, A_Value[10], B_Value[10]);  
  P_G_i P_G_i_14(P_G_i_14_out_0, P_G_i_14_out_1, A_Value[9], B_Value[9]);  
  P_G_i P_G_i_13(P_G_i_13_out_0, P_G_i_13_out_1, A_Value[8], B_Value[8]);  
  P_G_i P_G_i_12(P_G_i_12_out_0, P_G_i_12_out_1, A_Value[7], B_Value[7]);
  P_G_i P_G_i_9(P_G_i_9_out_0, P_G_i_9_out_1, A_Value[6], B_Value[6]);    
  P_G_i P_G_i_8(P_G_i_8_out_0, P_G_i_8_out_1, A_Value[5], B_Value[5]);  
  P_G_i P_G_i_6(P_G_i_6_out_0, P_G_i_6_out_1, A_Value[4], B_Value[4]);
  P_G_i P_G_i_5(P_G_i_5_out_0, P_G_i_5_out_1, A_Value[3], B_Value[3]);
  P_G_i P_G_i_4(P_G_i_4_out_0, P_G_i_4_out_1, A_Value[2], B_Value[2]);  
  P_G_i P_G_i_3(P_G_i_3_out_0, P_G_i_3_out_1, A_Value[1], B_Value[1]);
  P_G_i P_G_i_2(P_G_i_2_out_0, P_G_i_2_out_1, A_Value[0], B_Value[0]); 
  
  Intermediate_P_G c0 (c0_out_0 , c0_out_1 , p_0, P_G_i_2_out_1, cin, P_G_i_2_out_0);
  Intermediate_P_G c1 (c1_out_0 , c1_out_1 , c0_out_0 , P_G_i_3_out_1, c0_out_1 , P_G_i_3_out_0);
  Intermediate_P_G c2 (c2_out_0 , c2_out_1 , c0_out_0 , temp2to1_out_0 , c0_out_1 , temp2to1_out_1 );
  Intermediate_P_G c3 (c3_out_0 , c3_out_1 , c2_out_0 , P_G_i_5_out_1, c2_out_1 , P_G_i_5_out_0);
  Intermediate_P_G c4 (c4_out_0 , c4_out_1 , c2_out_0 , temp4to3_out_0 , c2_out_1 , temp4to3_out_1 );
  Intermediate_P_G c5 (c5_out_0 , c5_out_1 , c2_out_0 , temp5to3_out_0 , c2_out_1 , temp5to3_out_1 );
  Intermediate_P_G c6 (c6_out_0 , c6_out_1 , c2_out_0 , temp6to3_out_0 , c2_out_1 , temp6to3_out_1 );
  Intermediate_P_G c7 (c7_out_0 , c7_out_1 , c6_out_0 , P_G_i_12_out_1, c6_out_1 , P_G_i_12_out_0);
  Intermediate_P_G c8 (c8_out_0 , c8_out_1 , c6_out_0 , temp8to7_out_0 , c6_out_1 , temp8to7_out_1 );
  Intermediate_P_G c9 (c9_out_0 , c9_out_1 , c6_out_0 , temp9to7_out_0 , c6_out_1 , temp9to7_out_1 );
  Intermediate_P_G c10 (c10_out_0 , c10_out_1 , c6_out_0 , temp10to7_out_0 , c6_out_1 , temp10to7_out_1 );
  Intermediate_P_G c11 (c11_out_0 , c11_out_1 , c6_out_0 , temp11to7_out_0 , c6_out_1 , temp11to7_out_1 );
  Intermediate_P_G c12 (c12_out_0 , c12_out_1 , c6_out_0 , temp12to7_out_0 , c6_out_1 , temp12to7_out_1 );
  Intermediate_P_G c13 (c13_out_0 , c13_out_1 , c6_out_0 , temp13to7_out_0 , c6_out_1 , temp13to7_out_1 );
  Intermediate_P_G c14 (c14_out_0 , c14_out_1 , c6_out_0 , temp14to7_out_0 , c6_out_1 , temp14to7_out_1 );
  
  
  Intermediate_P_G temp14to13 (temp14to13_out_0 , temp14to13_out_1 , P_G_i_18_out_1, P_G_i_19_out_1, P_G_i_18_out_0, P_G_i_19_out_0);
  Intermediate_P_G temp14to11 (temp14to11_out_0 , temp14to11_out_1 , temp12to11_out_1 , temp14to13_out_0 , temp12to11_out_0 , temp14to13_out_1 );
  Intermediate_P_G temp14to7 (temp14to7_out_0 , temp14to7_out_1 , temp10to7_out_0 , temp14to11_out_0 , temp10to7_out_1 , temp14to11_out_1 );
  Intermediate_P_G temp13to11 (temp13to11_out_0 , temp13to11_out_1 , temp12to11_out_0 , P_G_i_18_out_1, temp12to11_out_1 , P_G_i_18_out_0);
  Intermediate_P_G temp13to7 (temp13to7_out_0 , temp13to7_out_1 , temp10to7_out_0 , temp13to11_out_0 , temp10to7_out_1 , temp13to11_out_1 );
  Intermediate_P_G temp12to11 (temp12to11_out_0 , temp12to11_out_1 , P_G_i_16_out_1, P_G_i_17_out_1, P_G_i_16_out_0, P_G_i_17_out_0);
  Intermediate_P_G temp12to7 (temp12to7_out_0 , temp12to7_out_1 , temp10to7_out_0 , temp12to11_out_0 , temp10to7_out_1 , temp12to11_out_1 );
  Intermediate_P_G temp11to7 (temp11to7_out_0 , temp11to7_out_1 , temp10to7_out_0 , P_G_i_16_out_1, temp10to7_out_1 , P_G_i_16_out_0);
  Intermediate_P_G temp10to9 (temp10to9_out_0 , temp10to9_out_1 , P_G_i_14_out_1, P_G_i_15_out_1, P_G_i_14_out_0, P_G_i_15_out_0);
  Intermediate_P_G temp10to7 (temp10to7_out_0 , temp10to7_out_1 , temp8to7_out_0 , temp10to9_out_0 , temp8to7_out_1 , temp10to9_out_1 );
  Intermediate_P_G temp9to7 (temp9to7_out_0 , temp9to7_out_1 , temp8to7_out_0 , P_G_i_14_out_1, temp8to7_out_1 , P_G_i_14_out_0);
  Intermediate_P_G temp8to7 (temp8to7_out_0 , temp8to7_out_1 , P_G_i_12_out_1, P_G_i_13_out_1, P_G_i_12_out_0, P_G_i_13_out_0);
  Intermediate_P_G temp6to5 (temp6to5_out_0 , temp6to5_out_1 , P_G_i_8_out_1, P_G_i_9_out_1, P_G_i_8_out_0, P_G_i_9_out_0);
  Intermediate_P_G temp6to3 (temp6to3_out_0 , temp6to3_out_1 , temp4to3_out_0 , temp6to5_out_0 , temp4to3_out_1 , temp6to5_out_1 );
  Intermediate_P_G temp5to3 (temp5to3_out_0 , temp5to3_out_1 , temp4to3_out_0 , P_G_i_8_out_1, temp4to3_out_1 , P_G_i_8_out_0);
  Intermediate_P_G temp4to3 (temp4to3_out_0 , temp4to3_out_1 , P_G_i_5_out_1, P_G_i_6_out_1, P_G_i_5_out_0, P_G_i_6_out_0);
  Intermediate_P_G temp2to1 (temp2to1_out_0 , temp2to1_out_1 , P_G_i_3_out_1, P_G_i_4_out_1, P_G_i_3_out_0, P_G_i_4_out_0);
  
  
endmodule
