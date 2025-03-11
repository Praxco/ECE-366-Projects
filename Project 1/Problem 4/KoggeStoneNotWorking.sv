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
