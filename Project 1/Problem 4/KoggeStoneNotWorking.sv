module KoggeStone_16bitAdder (A, B, Cin, S, Cout);
  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;
  
  wire [15:0] P, G;
  wire [15:0] C;
  
  genvar i;
  generate
    for(i=0; i < 16; i = i + 1) begin: propogate_generate
      assign P[i] = A[i] ^ B[i];
      assign G[i] = A[i] & B[i];
    end
  endgenerate
  
  wire [15:0] P_stage [0:15];
  wire [15:0] G_stage [0:15];
  
  assign P_stage[0] = P;
  assign G_stage[0] = G;
  
  generate
    for (i = 1; i < 16; i = i + 1) begin : prefixes
      assign G_stage[i] = (G_stage[i-1]) & P_stage[i-1];
      assign P_stage[i] = P_stage[i-1] & G_stage[i-1];
    end
  endgenerate
  
  assign C[0] = Cin;
  
  generate
    for (i = 1; i < 16; i = i + 1) begin: carries
      assign C[i] = G_stage[i-1][i-1] | (P_stage[i-1][i-1] & C[i-1]);
    end
  endgenerate
  
  assign Cout = C[15];
  
  generate
    for (i = 0; i < 16; i = i + 1) begin: sum
      assign S[i] = A[i] ^ B[i] ^ C[i];
    end
  endgenerate
endmodule
