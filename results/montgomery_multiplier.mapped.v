/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06
// Date      : Wed Jan 12 16:47:48 2022
/////////////////////////////////////////////////////////////


module SNPS_CLOCK_GATE_HIGH_montgomery_multiplier_0 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule


module SNPS_CLOCK_GATE_HIGH_montgomery_multiplier_1 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule


module SNPS_CLOCK_GATE_HIGH_montgomery_multiplier_2 ( CLK, EN, ENCLK, TE );
  input CLK, EN, TE;
  output ENCLK;


  CLKGATETST_X1 latch ( .CK(CLK), .E(EN), .SE(TE), .GCK(ENCLK) );
endmodule


module montgomery_multiplier ( a, b, clock, reset, start, z, done );
  input [7:0] a;
  input [7:0] b;
  output [7:0] z;
  input clock, reset, start;
  output done;
  wire   count_3_, count_2_, count_1_, count_0_, inic, N22, N23, N24, N25, N26,
         N27, N28, N29, ce_c, net72, net78, net83, n24, n32, n53, n55, n56,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n78, n79, n80, n81, n82, n83, n84, n85;
  wire   [7:0] bb;
  wire   [6:0] new_c;
  wire   [7:0] aa;
  wire   [1:0] current_state;

  SNPS_CLOCK_GATE_HIGH_montgomery_multiplier_0 clk_gate_count_reg ( .CLK(clock), .EN(current_state[1]), .ENCLK(net72), .TE(1'b0) );
  SNPS_CLOCK_GATE_HIGH_montgomery_multiplier_2 clk_gate_bb_reg ( .CLK(clock), 
        .EN(inic), .ENCLK(net78), .TE(1'b0) );
  SNPS_CLOCK_GATE_HIGH_montgomery_multiplier_1 clk_gate_cc_reg ( .CLK(clock), 
        .EN(ce_c), .ENCLK(net83), .TE(1'b0) );
  DFFR_X1 current_state_reg_1_ ( .D(n55), .CK(clock), .RN(n32), .Q(
        current_state[1]), .QN(done) );
  DFFR_X1 current_state_reg_0_ ( .D(n53), .CK(clock), .RN(n32), .Q(
        current_state[0]), .QN(n76) );
  DFFR_X1 count_reg_0_ ( .D(n84), .CK(net72), .RN(n32), .Q(count_0_) );
  DFFR_X1 count_reg_1_ ( .D(n83), .CK(net72), .RN(n32), .Q(count_1_), .QN(n78)
         );
  DFFR_X1 count_reg_2_ ( .D(n82), .CK(net72), .RN(n32), .Q(count_2_), .QN(n80)
         );
  DFFR_X1 count_reg_3_ ( .D(n81), .CK(net72), .RN(n32), .Q(count_3_), .QN(n79)
         );
  DFFR_X1 bb_reg_7_ ( .D(b[7]), .CK(net78), .RN(n32), .Q(bb[7]) );
  DFFR_X1 bb_reg_6_ ( .D(b[6]), .CK(net78), .RN(n32), .Q(bb[6]) );
  DFFR_X1 bb_reg_5_ ( .D(b[5]), .CK(net78), .RN(n32), .Q(bb[5]) );
  DFFR_X1 bb_reg_4_ ( .D(b[4]), .CK(net78), .RN(n32), .Q(bb[4]) );
  DFFR_X1 bb_reg_3_ ( .D(b[3]), .CK(net78), .RN(n32), .Q(bb[3]) );
  DFFR_X1 bb_reg_2_ ( .D(b[2]), .CK(net78), .RN(n32), .Q(bb[2]) );
  DFFR_X1 bb_reg_1_ ( .D(b[1]), .CK(net78), .RN(n32), .Q(bb[1]) );
  DFFR_X1 bb_reg_0_ ( .D(b[0]), .CK(net78), .RN(n32), .Q(bb[0]) );
  DFFR_X1 aa_reg_7_ ( .D(N29), .CK(clock), .RN(n32), .Q(aa[7]) );
  DFFR_X1 aa_reg_6_ ( .D(N28), .CK(clock), .RN(n32), .Q(aa[6]) );
  DFFR_X1 aa_reg_5_ ( .D(N27), .CK(clock), .RN(n32), .Q(aa[5]) );
  DFFR_X1 aa_reg_4_ ( .D(N26), .CK(clock), .RN(n32), .Q(aa[4]) );
  DFFR_X1 aa_reg_3_ ( .D(N25), .CK(clock), .RN(n32), .Q(aa[3]) );
  DFFR_X1 aa_reg_2_ ( .D(N24), .CK(clock), .RN(n32), .Q(aa[2]) );
  DFFR_X1 aa_reg_1_ ( .D(N23), .CK(clock), .RN(n32), .Q(aa[1]) );
  DFFR_X1 aa_reg_0_ ( .D(N22), .CK(clock), .RN(n32), .Q(aa[0]) );
  DFFR_X1 cc_reg_7_ ( .D(n56), .CK(net83), .RN(n24), .Q(z[7]) );
  DFFR_X1 cc_reg_6_ ( .D(new_c[6]), .CK(net83), .RN(n24), .Q(z[6]) );
  DFFR_X1 cc_reg_5_ ( .D(new_c[5]), .CK(net83), .RN(n24), .Q(z[5]) );
  DFFR_X1 cc_reg_4_ ( .D(new_c[4]), .CK(net83), .RN(n24), .Q(z[4]) );
  DFFR_X1 cc_reg_3_ ( .D(new_c[3]), .CK(net83), .RN(n24), .Q(z[3]) );
  DFFR_X1 cc_reg_2_ ( .D(new_c[2]), .CK(net83), .RN(n24), .Q(z[2]) );
  DFFR_X1 cc_reg_1_ ( .D(new_c[1]), .CK(net83), .RN(n24), .Q(z[1]) );
  DFFR_X1 cc_reg_0_ ( .D(new_c[0]), .CK(net83), .RN(n24), .Q(z[0]) );
  INV_X1 U53 ( .A(reset), .ZN(n32) );
  NOR2_X1 U54 ( .A1(current_state[0]), .A2(done), .ZN(inic) );
  NOR2_X1 U55 ( .A1(count_0_), .A2(n76), .ZN(n84) );
  NAND2_X1 U56 ( .A1(current_state[0]), .A2(count_0_), .ZN(n61) );
  AOI21_X1 U58 ( .B1(current_state[0]), .B2(n78), .A(n84), .ZN(n59) );
  AND4_X1 U61 ( .A1(n79), .A2(count_0_), .A3(count_2_), .A4(count_1_), .ZN(n75) );
  AOI21_X1 U62 ( .B1(count_3_), .B2(n80), .A(n75), .ZN(n60) );
  OAI22_X1 U63 ( .A1(n60), .A2(n76), .B1(n59), .B2(n79), .ZN(n81) );
  INV_X1 U64 ( .A(n84), .ZN(n62) );
  AOI22_X1 U65 ( .A1(count_1_), .A2(n62), .B1(n61), .B2(n78), .ZN(n83) );
  NAND2_X1 U67 ( .A1(bb[7]), .A2(aa[0]), .ZN(n63) );
  XNOR2_X1 U68 ( .A(n63), .B(z[7]), .ZN(new_c[6]) );
  NAND2_X1 U69 ( .A1(bb[6]), .A2(aa[0]), .ZN(n64) );
  XNOR2_X1 U70 ( .A(n64), .B(z[6]), .ZN(new_c[5]) );
  NAND2_X1 U71 ( .A1(bb[5]), .A2(aa[0]), .ZN(n65) );
  XNOR2_X1 U72 ( .A(n65), .B(z[5]), .ZN(new_c[4]) );
  NAND2_X1 U73 ( .A1(bb[1]), .A2(aa[0]), .ZN(n66) );
  XNOR2_X1 U74 ( .A(n66), .B(z[1]), .ZN(new_c[0]) );
  MUX2_X1 U75 ( .A(aa[1]), .B(a[0]), .S(inic), .Z(N22) );
  MUX2_X1 U76 ( .A(aa[2]), .B(a[1]), .S(inic), .Z(N23) );
  MUX2_X1 U77 ( .A(aa[3]), .B(a[2]), .S(inic), .Z(N24) );
  MUX2_X1 U78 ( .A(aa[4]), .B(a[3]), .S(inic), .Z(N25) );
  MUX2_X1 U79 ( .A(aa[5]), .B(a[4]), .S(inic), .Z(N26) );
  MUX2_X1 U80 ( .A(aa[6]), .B(a[5]), .S(inic), .Z(N27) );
  MUX2_X1 U81 ( .A(aa[7]), .B(a[6]), .S(inic), .Z(N28) );
  AND2_X1 U82 ( .A1(inic), .A2(a[7]), .ZN(N29) );
  NOR2_X1 U83 ( .A1(n76), .A2(done), .ZN(ce_c) );
  NAND2_X1 U84 ( .A1(bb[0]), .A2(aa[0]), .ZN(n67) );
  XNOR2_X1 U85 ( .A(n67), .B(z[0]), .ZN(n56) );
  XOR2_X1 U86 ( .A(z[4]), .B(n56), .Z(n69) );
  NAND2_X1 U87 ( .A1(bb[4]), .A2(aa[0]), .ZN(n68) );
  XNOR2_X1 U88 ( .A(n69), .B(n68), .ZN(new_c[3]) );
  XOR2_X1 U89 ( .A(z[3]), .B(n56), .Z(n71) );
  NAND2_X1 U90 ( .A1(bb[3]), .A2(aa[0]), .ZN(n70) );
  XNOR2_X1 U91 ( .A(n71), .B(n70), .ZN(new_c[2]) );
  XOR2_X1 U92 ( .A(z[2]), .B(n56), .Z(n73) );
  NAND2_X1 U93 ( .A1(bb[2]), .A2(aa[0]), .ZN(n72) );
  XNOR2_X1 U94 ( .A(n73), .B(n72), .ZN(new_c[1]) );
  AOI21_X1 U95 ( .B1(current_state[0]), .B2(start), .A(current_state[1]), .ZN(
        n74) );
  AOI21_X1 U96 ( .B1(ce_c), .B2(n75), .A(n74), .ZN(n55) );
  AOI22_X1 U97 ( .A1(n75), .A2(ce_c), .B1(start), .B2(done), .ZN(n53) );
  NOR2_X1 U98 ( .A1(inic), .A2(reset), .ZN(n24) );
  OAI21_X1 U57 ( .B1(n59), .B2(n80), .A(n85), .ZN(n82) );
  OR3_X1 U59 ( .A1(count_2_), .A2(n78), .A3(n61), .ZN(n85) );
endmodule

