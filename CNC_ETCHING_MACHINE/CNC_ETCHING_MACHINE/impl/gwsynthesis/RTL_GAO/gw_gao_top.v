module gw_gao(
    \target_x[31] ,
    \target_x[30] ,
    \target_x[29] ,
    \target_x[28] ,
    \target_x[27] ,
    \target_x[26] ,
    \target_x[25] ,
    \target_x[24] ,
    \target_x[23] ,
    \target_x[22] ,
    \target_x[21] ,
    \target_x[20] ,
    \target_x[19] ,
    \target_x[18] ,
    \target_x[17] ,
    \target_x[16] ,
    \target_x[15] ,
    \target_x[14] ,
    \target_x[13] ,
    \target_x[12] ,
    \target_x[11] ,
    \target_x[10] ,
    \target_x[9] ,
    \target_x[8] ,
    \target_x[7] ,
    \target_x[6] ,
    \target_x[5] ,
    \target_x[4] ,
    \target_x[3] ,
    \target_x[2] ,
    \target_x[1] ,
    \target_x[0] ,
    \current_x[31] ,
    \current_x[30] ,
    \current_x[29] ,
    \current_x[28] ,
    \current_x[27] ,
    \current_x[26] ,
    \current_x[25] ,
    \current_x[24] ,
    \current_x[23] ,
    \current_x[22] ,
    \current_x[21] ,
    \current_x[20] ,
    \current_x[19] ,
    \current_x[18] ,
    \current_x[17] ,
    \current_x[16] ,
    \current_x[15] ,
    \current_x[14] ,
    \current_x[13] ,
    \current_x[12] ,
    \current_x[11] ,
    \current_x[10] ,
    \current_x[9] ,
    \current_x[8] ,
    \current_x[7] ,
    \current_x[6] ,
    \current_x[5] ,
    \current_x[4] ,
    \current_x[3] ,
    \current_x[2] ,
    \current_x[1] ,
    \current_x[0] ,
    \target_y[31] ,
    \target_y[30] ,
    \target_y[29] ,
    \target_y[28] ,
    \target_y[27] ,
    \target_y[26] ,
    \target_y[25] ,
    \target_y[24] ,
    \target_y[23] ,
    \target_y[22] ,
    \target_y[21] ,
    \target_y[20] ,
    \target_y[19] ,
    \target_y[18] ,
    \target_y[17] ,
    \target_y[16] ,
    \target_y[15] ,
    \target_y[14] ,
    \target_y[13] ,
    \target_y[12] ,
    \target_y[11] ,
    \target_y[10] ,
    \target_y[9] ,
    \target_y[8] ,
    \target_y[7] ,
    \target_y[6] ,
    \target_y[5] ,
    \target_y[4] ,
    \target_y[3] ,
    \target_y[2] ,
    \target_y[1] ,
    \target_y[0] ,
    \current_y[31] ,
    \current_y[30] ,
    \current_y[29] ,
    \current_y[28] ,
    \current_y[27] ,
    \current_y[26] ,
    \current_y[25] ,
    \current_y[24] ,
    \current_y[23] ,
    \current_y[22] ,
    \current_y[21] ,
    \current_y[20] ,
    \current_y[19] ,
    \current_y[18] ,
    \current_y[17] ,
    \current_y[16] ,
    \current_y[15] ,
    \current_y[14] ,
    \current_y[13] ,
    \current_y[12] ,
    \current_y[11] ,
    \current_y[10] ,
    \current_y[9] ,
    \current_y[8] ,
    \current_y[7] ,
    \current_y[6] ,
    \current_y[5] ,
    \current_y[4] ,
    \current_y[3] ,
    \current_y[2] ,
    \current_y[1] ,
    \current_y[0] ,
    \target_z[31] ,
    \target_z[30] ,
    \target_z[29] ,
    \target_z[28] ,
    \target_z[27] ,
    \target_z[26] ,
    \target_z[25] ,
    \target_z[24] ,
    \target_z[23] ,
    \target_z[22] ,
    \target_z[21] ,
    \target_z[20] ,
    \target_z[19] ,
    \target_z[18] ,
    \target_z[17] ,
    \target_z[16] ,
    \target_z[15] ,
    \target_z[14] ,
    \target_z[13] ,
    \target_z[12] ,
    \target_z[11] ,
    \target_z[10] ,
    \target_z[9] ,
    \target_z[8] ,
    \target_z[7] ,
    \target_z[6] ,
    \target_z[5] ,
    \target_z[4] ,
    \target_z[3] ,
    \target_z[2] ,
    \target_z[1] ,
    \target_z[0] ,
    \current_z[31] ,
    \current_z[30] ,
    \current_z[29] ,
    \current_z[28] ,
    \current_z[27] ,
    \current_z[26] ,
    \current_z[25] ,
    \current_z[24] ,
    \current_z[23] ,
    \current_z[22] ,
    \current_z[21] ,
    \current_z[20] ,
    \current_z[19] ,
    \current_z[18] ,
    \current_z[17] ,
    \current_z[16] ,
    \current_z[15] ,
    \current_z[14] ,
    \current_z[13] ,
    \current_z[12] ,
    \current_z[11] ,
    \current_z[10] ,
    \current_z[9] ,
    \current_z[8] ,
    \current_z[7] ,
    \current_z[6] ,
    \current_z[5] ,
    \current_z[4] ,
    \current_z[3] ,
    \current_z[2] ,
    \current_z[1] ,
    \current_z[0] ,
    pause_flag,
    instruction_ready,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \target_x[31] ;
input \target_x[30] ;
input \target_x[29] ;
input \target_x[28] ;
input \target_x[27] ;
input \target_x[26] ;
input \target_x[25] ;
input \target_x[24] ;
input \target_x[23] ;
input \target_x[22] ;
input \target_x[21] ;
input \target_x[20] ;
input \target_x[19] ;
input \target_x[18] ;
input \target_x[17] ;
input \target_x[16] ;
input \target_x[15] ;
input \target_x[14] ;
input \target_x[13] ;
input \target_x[12] ;
input \target_x[11] ;
input \target_x[10] ;
input \target_x[9] ;
input \target_x[8] ;
input \target_x[7] ;
input \target_x[6] ;
input \target_x[5] ;
input \target_x[4] ;
input \target_x[3] ;
input \target_x[2] ;
input \target_x[1] ;
input \target_x[0] ;
input \current_x[31] ;
input \current_x[30] ;
input \current_x[29] ;
input \current_x[28] ;
input \current_x[27] ;
input \current_x[26] ;
input \current_x[25] ;
input \current_x[24] ;
input \current_x[23] ;
input \current_x[22] ;
input \current_x[21] ;
input \current_x[20] ;
input \current_x[19] ;
input \current_x[18] ;
input \current_x[17] ;
input \current_x[16] ;
input \current_x[15] ;
input \current_x[14] ;
input \current_x[13] ;
input \current_x[12] ;
input \current_x[11] ;
input \current_x[10] ;
input \current_x[9] ;
input \current_x[8] ;
input \current_x[7] ;
input \current_x[6] ;
input \current_x[5] ;
input \current_x[4] ;
input \current_x[3] ;
input \current_x[2] ;
input \current_x[1] ;
input \current_x[0] ;
input \target_y[31] ;
input \target_y[30] ;
input \target_y[29] ;
input \target_y[28] ;
input \target_y[27] ;
input \target_y[26] ;
input \target_y[25] ;
input \target_y[24] ;
input \target_y[23] ;
input \target_y[22] ;
input \target_y[21] ;
input \target_y[20] ;
input \target_y[19] ;
input \target_y[18] ;
input \target_y[17] ;
input \target_y[16] ;
input \target_y[15] ;
input \target_y[14] ;
input \target_y[13] ;
input \target_y[12] ;
input \target_y[11] ;
input \target_y[10] ;
input \target_y[9] ;
input \target_y[8] ;
input \target_y[7] ;
input \target_y[6] ;
input \target_y[5] ;
input \target_y[4] ;
input \target_y[3] ;
input \target_y[2] ;
input \target_y[1] ;
input \target_y[0] ;
input \current_y[31] ;
input \current_y[30] ;
input \current_y[29] ;
input \current_y[28] ;
input \current_y[27] ;
input \current_y[26] ;
input \current_y[25] ;
input \current_y[24] ;
input \current_y[23] ;
input \current_y[22] ;
input \current_y[21] ;
input \current_y[20] ;
input \current_y[19] ;
input \current_y[18] ;
input \current_y[17] ;
input \current_y[16] ;
input \current_y[15] ;
input \current_y[14] ;
input \current_y[13] ;
input \current_y[12] ;
input \current_y[11] ;
input \current_y[10] ;
input \current_y[9] ;
input \current_y[8] ;
input \current_y[7] ;
input \current_y[6] ;
input \current_y[5] ;
input \current_y[4] ;
input \current_y[3] ;
input \current_y[2] ;
input \current_y[1] ;
input \current_y[0] ;
input \target_z[31] ;
input \target_z[30] ;
input \target_z[29] ;
input \target_z[28] ;
input \target_z[27] ;
input \target_z[26] ;
input \target_z[25] ;
input \target_z[24] ;
input \target_z[23] ;
input \target_z[22] ;
input \target_z[21] ;
input \target_z[20] ;
input \target_z[19] ;
input \target_z[18] ;
input \target_z[17] ;
input \target_z[16] ;
input \target_z[15] ;
input \target_z[14] ;
input \target_z[13] ;
input \target_z[12] ;
input \target_z[11] ;
input \target_z[10] ;
input \target_z[9] ;
input \target_z[8] ;
input \target_z[7] ;
input \target_z[6] ;
input \target_z[5] ;
input \target_z[4] ;
input \target_z[3] ;
input \target_z[2] ;
input \target_z[1] ;
input \target_z[0] ;
input \current_z[31] ;
input \current_z[30] ;
input \current_z[29] ;
input \current_z[28] ;
input \current_z[27] ;
input \current_z[26] ;
input \current_z[25] ;
input \current_z[24] ;
input \current_z[23] ;
input \current_z[22] ;
input \current_z[21] ;
input \current_z[20] ;
input \current_z[19] ;
input \current_z[18] ;
input \current_z[17] ;
input \current_z[16] ;
input \current_z[15] ;
input \current_z[14] ;
input \current_z[13] ;
input \current_z[12] ;
input \current_z[11] ;
input \current_z[10] ;
input \current_z[9] ;
input \current_z[8] ;
input \current_z[7] ;
input \current_z[6] ;
input \current_z[5] ;
input \current_z[4] ;
input \current_z[3] ;
input \current_z[2] ;
input \current_z[1] ;
input \current_z[0] ;
input pause_flag;
input instruction_ready;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \target_x[31] ;
wire \target_x[30] ;
wire \target_x[29] ;
wire \target_x[28] ;
wire \target_x[27] ;
wire \target_x[26] ;
wire \target_x[25] ;
wire \target_x[24] ;
wire \target_x[23] ;
wire \target_x[22] ;
wire \target_x[21] ;
wire \target_x[20] ;
wire \target_x[19] ;
wire \target_x[18] ;
wire \target_x[17] ;
wire \target_x[16] ;
wire \target_x[15] ;
wire \target_x[14] ;
wire \target_x[13] ;
wire \target_x[12] ;
wire \target_x[11] ;
wire \target_x[10] ;
wire \target_x[9] ;
wire \target_x[8] ;
wire \target_x[7] ;
wire \target_x[6] ;
wire \target_x[5] ;
wire \target_x[4] ;
wire \target_x[3] ;
wire \target_x[2] ;
wire \target_x[1] ;
wire \target_x[0] ;
wire \current_x[31] ;
wire \current_x[30] ;
wire \current_x[29] ;
wire \current_x[28] ;
wire \current_x[27] ;
wire \current_x[26] ;
wire \current_x[25] ;
wire \current_x[24] ;
wire \current_x[23] ;
wire \current_x[22] ;
wire \current_x[21] ;
wire \current_x[20] ;
wire \current_x[19] ;
wire \current_x[18] ;
wire \current_x[17] ;
wire \current_x[16] ;
wire \current_x[15] ;
wire \current_x[14] ;
wire \current_x[13] ;
wire \current_x[12] ;
wire \current_x[11] ;
wire \current_x[10] ;
wire \current_x[9] ;
wire \current_x[8] ;
wire \current_x[7] ;
wire \current_x[6] ;
wire \current_x[5] ;
wire \current_x[4] ;
wire \current_x[3] ;
wire \current_x[2] ;
wire \current_x[1] ;
wire \current_x[0] ;
wire \target_y[31] ;
wire \target_y[30] ;
wire \target_y[29] ;
wire \target_y[28] ;
wire \target_y[27] ;
wire \target_y[26] ;
wire \target_y[25] ;
wire \target_y[24] ;
wire \target_y[23] ;
wire \target_y[22] ;
wire \target_y[21] ;
wire \target_y[20] ;
wire \target_y[19] ;
wire \target_y[18] ;
wire \target_y[17] ;
wire \target_y[16] ;
wire \target_y[15] ;
wire \target_y[14] ;
wire \target_y[13] ;
wire \target_y[12] ;
wire \target_y[11] ;
wire \target_y[10] ;
wire \target_y[9] ;
wire \target_y[8] ;
wire \target_y[7] ;
wire \target_y[6] ;
wire \target_y[5] ;
wire \target_y[4] ;
wire \target_y[3] ;
wire \target_y[2] ;
wire \target_y[1] ;
wire \target_y[0] ;
wire \current_y[31] ;
wire \current_y[30] ;
wire \current_y[29] ;
wire \current_y[28] ;
wire \current_y[27] ;
wire \current_y[26] ;
wire \current_y[25] ;
wire \current_y[24] ;
wire \current_y[23] ;
wire \current_y[22] ;
wire \current_y[21] ;
wire \current_y[20] ;
wire \current_y[19] ;
wire \current_y[18] ;
wire \current_y[17] ;
wire \current_y[16] ;
wire \current_y[15] ;
wire \current_y[14] ;
wire \current_y[13] ;
wire \current_y[12] ;
wire \current_y[11] ;
wire \current_y[10] ;
wire \current_y[9] ;
wire \current_y[8] ;
wire \current_y[7] ;
wire \current_y[6] ;
wire \current_y[5] ;
wire \current_y[4] ;
wire \current_y[3] ;
wire \current_y[2] ;
wire \current_y[1] ;
wire \current_y[0] ;
wire \target_z[31] ;
wire \target_z[30] ;
wire \target_z[29] ;
wire \target_z[28] ;
wire \target_z[27] ;
wire \target_z[26] ;
wire \target_z[25] ;
wire \target_z[24] ;
wire \target_z[23] ;
wire \target_z[22] ;
wire \target_z[21] ;
wire \target_z[20] ;
wire \target_z[19] ;
wire \target_z[18] ;
wire \target_z[17] ;
wire \target_z[16] ;
wire \target_z[15] ;
wire \target_z[14] ;
wire \target_z[13] ;
wire \target_z[12] ;
wire \target_z[11] ;
wire \target_z[10] ;
wire \target_z[9] ;
wire \target_z[8] ;
wire \target_z[7] ;
wire \target_z[6] ;
wire \target_z[5] ;
wire \target_z[4] ;
wire \target_z[3] ;
wire \target_z[2] ;
wire \target_z[1] ;
wire \target_z[0] ;
wire \current_z[31] ;
wire \current_z[30] ;
wire \current_z[29] ;
wire \current_z[28] ;
wire \current_z[27] ;
wire \current_z[26] ;
wire \current_z[25] ;
wire \current_z[24] ;
wire \current_z[23] ;
wire \current_z[22] ;
wire \current_z[21] ;
wire \current_z[20] ;
wire \current_z[19] ;
wire \current_z[18] ;
wire \current_z[17] ;
wire \current_z[16] ;
wire \current_z[15] ;
wire \current_z[14] ;
wire \current_z[13] ;
wire \current_z[12] ;
wire \current_z[11] ;
wire \current_z[10] ;
wire \current_z[9] ;
wire \current_z[8] ;
wire \current_z[7] ;
wire \current_z[6] ;
wire \current_z[5] ;
wire \current_z[4] ;
wire \current_z[3] ;
wire \current_z[2] ;
wire \current_z[1] ;
wire \current_z[0] ;
wire pause_flag;
wire instruction_ready;
wire clk;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i(instruction_ready),
    .trig1_i(pause_flag),
    .data_i({\target_x[31] ,\target_x[30] ,\target_x[29] ,\target_x[28] ,\target_x[27] ,\target_x[26] ,\target_x[25] ,\target_x[24] ,\target_x[23] ,\target_x[22] ,\target_x[21] ,\target_x[20] ,\target_x[19] ,\target_x[18] ,\target_x[17] ,\target_x[16] ,\target_x[15] ,\target_x[14] ,\target_x[13] ,\target_x[12] ,\target_x[11] ,\target_x[10] ,\target_x[9] ,\target_x[8] ,\target_x[7] ,\target_x[6] ,\target_x[5] ,\target_x[4] ,\target_x[3] ,\target_x[2] ,\target_x[1] ,\target_x[0] ,\current_x[31] ,\current_x[30] ,\current_x[29] ,\current_x[28] ,\current_x[27] ,\current_x[26] ,\current_x[25] ,\current_x[24] ,\current_x[23] ,\current_x[22] ,\current_x[21] ,\current_x[20] ,\current_x[19] ,\current_x[18] ,\current_x[17] ,\current_x[16] ,\current_x[15] ,\current_x[14] ,\current_x[13] ,\current_x[12] ,\current_x[11] ,\current_x[10] ,\current_x[9] ,\current_x[8] ,\current_x[7] ,\current_x[6] ,\current_x[5] ,\current_x[4] ,\current_x[3] ,\current_x[2] ,\current_x[1] ,\current_x[0] ,\target_y[31] ,\target_y[30] ,\target_y[29] ,\target_y[28] ,\target_y[27] ,\target_y[26] ,\target_y[25] ,\target_y[24] ,\target_y[23] ,\target_y[22] ,\target_y[21] ,\target_y[20] ,\target_y[19] ,\target_y[18] ,\target_y[17] ,\target_y[16] ,\target_y[15] ,\target_y[14] ,\target_y[13] ,\target_y[12] ,\target_y[11] ,\target_y[10] ,\target_y[9] ,\target_y[8] ,\target_y[7] ,\target_y[6] ,\target_y[5] ,\target_y[4] ,\target_y[3] ,\target_y[2] ,\target_y[1] ,\target_y[0] ,\current_y[31] ,\current_y[30] ,\current_y[29] ,\current_y[28] ,\current_y[27] ,\current_y[26] ,\current_y[25] ,\current_y[24] ,\current_y[23] ,\current_y[22] ,\current_y[21] ,\current_y[20] ,\current_y[19] ,\current_y[18] ,\current_y[17] ,\current_y[16] ,\current_y[15] ,\current_y[14] ,\current_y[13] ,\current_y[12] ,\current_y[11] ,\current_y[10] ,\current_y[9] ,\current_y[8] ,\current_y[7] ,\current_y[6] ,\current_y[5] ,\current_y[4] ,\current_y[3] ,\current_y[2] ,\current_y[1] ,\current_y[0] ,\target_z[31] ,\target_z[30] ,\target_z[29] ,\target_z[28] ,\target_z[27] ,\target_z[26] ,\target_z[25] ,\target_z[24] ,\target_z[23] ,\target_z[22] ,\target_z[21] ,\target_z[20] ,\target_z[19] ,\target_z[18] ,\target_z[17] ,\target_z[16] ,\target_z[15] ,\target_z[14] ,\target_z[13] ,\target_z[12] ,\target_z[11] ,\target_z[10] ,\target_z[9] ,\target_z[8] ,\target_z[7] ,\target_z[6] ,\target_z[5] ,\target_z[4] ,\target_z[3] ,\target_z[2] ,\target_z[1] ,\target_z[0] ,\current_z[31] ,\current_z[30] ,\current_z[29] ,\current_z[28] ,\current_z[27] ,\current_z[26] ,\current_z[25] ,\current_z[24] ,\current_z[23] ,\current_z[22] ,\current_z[21] ,\current_z[20] ,\current_z[19] ,\current_z[18] ,\current_z[17] ,\current_z[16] ,\current_z[15] ,\current_z[14] ,\current_z[13] ,\current_z[12] ,\current_z[11] ,\current_z[10] ,\current_z[9] ,\current_z[8] ,\current_z[7] ,\current_z[6] ,\current_z[5] ,\current_z[4] ,\current_z[3] ,\current_z[2] ,\current_z[1] ,\current_z[0] ,pause_flag}),
    .clk_i(clk)
);

endmodule
