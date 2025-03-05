// Testbench for problem 2, the 32 bit CLA

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
    A = 32'd0; B = 32'd0; Cin = 0; // 0+0=0
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

