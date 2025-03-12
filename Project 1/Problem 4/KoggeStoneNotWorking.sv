module pre-computation(A, B, P, G);
  input A, B;
  output P, G;
  assign P = A ^ B;
  assign G = A & B;
endmodule

module post-computation (P, G, S);
  input P, G;
  output S;
  assign S = G ^ P; 
endmodule

module blackCell( Gik, Gkj, Pik, Pkj, Pout, Gout);
  input Gik, Gkj, Pik, Pkj;
  output Pout, Gout;
  
  assign Pout = Pik ^ Pkj;
  assign Gout = Gik | (Pik & Gkj);
endmodule

module grayCell(Gik, Pik, Gkj, Gout);
  input Gik, Pik, Gkj;
  output Gout;
  
  assign Gout = Gik | (Pik & Gkj);
endmodule

module KoggeStone16bit(A, B, Cin, S, Cout);
  wire [15:0] G, Gik, Gkj, Gij, P, Pik, Pkj, Pij;
  
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin : precomp
      pre-computation pc(.A(A[i]), .B(B[i]), .P(P[i]), .G(G[i]));
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
