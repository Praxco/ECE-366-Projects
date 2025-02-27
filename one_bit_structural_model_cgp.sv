//One-bit full adder structural model
module one_bit_adder_behavior(Sum, Cout, A, B, Cin);
  output Sum,  Cout;            // output declarations
  input A, B, Cin;              // input declarations
  
  wire t1, t2, t3;              // driver declarations
  
  xor U1(Sum,A,B,Cin);	        // instantiator(output,input1,input2,input3,...)

  and U2(t1,A,Cin);		          // 1st and gate
  and U3(t2,A,B);		            // second and gate	
  and U4(t3,B,Cin);		          // third and gate
  or U5(Cout, t1,t2,t3);	      // all input or together for Cout
  
endmodule
