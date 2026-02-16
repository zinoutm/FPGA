module gw_gao(
    \raw_opcode[7] ,
    \raw_opcode[6] ,
    \raw_opcode[5] ,
    \raw_opcode[4] ,
    \raw_opcode[3] ,
    \raw_opcode[2] ,
    \raw_opcode[1] ,
    \raw_opcode[0] ,
    \The_Decoder/exec_target_x[31] ,
    \The_Decoder/exec_target_x[30] ,
    \The_Decoder/exec_target_x[29] ,
    \The_Decoder/exec_target_x[28] ,
    \The_Decoder/exec_target_x[27] ,
    \The_Decoder/exec_target_x[26] ,
    \The_Decoder/exec_target_x[25] ,
    \The_Decoder/exec_target_x[24] ,
    \The_Decoder/exec_target_x[23] ,
    \The_Decoder/exec_target_x[22] ,
    \The_Decoder/exec_target_x[21] ,
    \The_Decoder/exec_target_x[20] ,
    \The_Decoder/exec_target_x[19] ,
    \The_Decoder/exec_target_x[18] ,
    \The_Decoder/exec_target_x[17] ,
    \The_Decoder/exec_target_x[16] ,
    \The_Decoder/exec_target_x[15] ,
    \The_Decoder/exec_target_x[14] ,
    \The_Decoder/exec_target_x[13] ,
    \The_Decoder/exec_target_x[12] ,
    \The_Decoder/exec_target_x[11] ,
    \The_Decoder/exec_target_x[10] ,
    \The_Decoder/exec_target_x[9] ,
    \The_Decoder/exec_target_x[8] ,
    \The_Decoder/exec_target_x[7] ,
    \The_Decoder/exec_target_x[6] ,
    \The_Decoder/exec_target_x[5] ,
    \The_Decoder/exec_target_x[4] ,
    \The_Decoder/exec_target_x[3] ,
    \The_Decoder/exec_target_x[2] ,
    \The_Decoder/exec_target_x[1] ,
    \The_Decoder/exec_target_x[0] ,
    \feed_rate[15] ,
    \feed_rate[14] ,
    \feed_rate[13] ,
    \feed_rate[12] ,
    \feed_rate[11] ,
    \feed_rate[10] ,
    \feed_rate[9] ,
    \feed_rate[8] ,
    \feed_rate[7] ,
    \feed_rate[6] ,
    \feed_rate[5] ,
    \feed_rate[4] ,
    \feed_rate[3] ,
    \feed_rate[2] ,
    \feed_rate[1] ,
    \feed_rate[0] ,
    \The_Decoder/data_available ,
    instruction_ready,
    is_motion,
    kill_flag,
    pause_flag,
    homing_reset,
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
    \Motor_Driver/delta_x[31] ,
    \Motor_Driver/delta_x[30] ,
    \Motor_Driver/delta_x[29] ,
    \Motor_Driver/delta_x[28] ,
    \Motor_Driver/delta_x[27] ,
    \Motor_Driver/delta_x[26] ,
    \Motor_Driver/delta_x[25] ,
    \Motor_Driver/delta_x[24] ,
    \Motor_Driver/delta_x[23] ,
    \Motor_Driver/delta_x[22] ,
    \Motor_Driver/delta_x[21] ,
    \Motor_Driver/delta_x[20] ,
    \Motor_Driver/delta_x[19] ,
    \Motor_Driver/delta_x[18] ,
    \Motor_Driver/delta_x[17] ,
    \Motor_Driver/delta_x[16] ,
    \Motor_Driver/delta_x[15] ,
    \Motor_Driver/delta_x[14] ,
    \Motor_Driver/delta_x[13] ,
    \Motor_Driver/delta_x[12] ,
    \Motor_Driver/delta_x[11] ,
    \Motor_Driver/delta_x[10] ,
    \Motor_Driver/delta_x[9] ,
    \Motor_Driver/delta_x[8] ,
    \Motor_Driver/delta_x[7] ,
    \Motor_Driver/delta_x[6] ,
    \Motor_Driver/delta_x[5] ,
    \Motor_Driver/delta_x[4] ,
    \Motor_Driver/delta_x[3] ,
    \Motor_Driver/delta_x[2] ,
    \Motor_Driver/delta_x[1] ,
    \Motor_Driver/delta_x[0] ,
    \Motor_Driver/master_steps[31] ,
    \Motor_Driver/master_steps[30] ,
    \Motor_Driver/master_steps[29] ,
    \Motor_Driver/master_steps[28] ,
    \Motor_Driver/master_steps[27] ,
    \Motor_Driver/master_steps[26] ,
    \Motor_Driver/master_steps[25] ,
    \Motor_Driver/master_steps[24] ,
    \Motor_Driver/master_steps[23] ,
    \Motor_Driver/master_steps[22] ,
    \Motor_Driver/master_steps[21] ,
    \Motor_Driver/master_steps[20] ,
    \Motor_Driver/master_steps[19] ,
    \Motor_Driver/master_steps[18] ,
    \Motor_Driver/master_steps[17] ,
    \Motor_Driver/master_steps[16] ,
    \Motor_Driver/master_steps[15] ,
    \Motor_Driver/master_steps[14] ,
    \Motor_Driver/master_steps[13] ,
    \Motor_Driver/master_steps[12] ,
    \Motor_Driver/master_steps[11] ,
    \Motor_Driver/master_steps[10] ,
    \Motor_Driver/master_steps[9] ,
    \Motor_Driver/master_steps[8] ,
    \Motor_Driver/master_steps[7] ,
    \Motor_Driver/master_steps[6] ,
    \Motor_Driver/master_steps[5] ,
    \Motor_Driver/master_steps[4] ,
    \Motor_Driver/master_steps[3] ,
    \Motor_Driver/master_steps[2] ,
    \Motor_Driver/master_steps[1] ,
    \Motor_Driver/master_steps[0] ,
    \Motor_Driver/step_count[31] ,
    \Motor_Driver/step_count[30] ,
    \Motor_Driver/step_count[29] ,
    \Motor_Driver/step_count[28] ,
    \Motor_Driver/step_count[27] ,
    \Motor_Driver/step_count[26] ,
    \Motor_Driver/step_count[25] ,
    \Motor_Driver/step_count[24] ,
    \Motor_Driver/step_count[23] ,
    \Motor_Driver/step_count[22] ,
    \Motor_Driver/step_count[21] ,
    \Motor_Driver/step_count[20] ,
    \Motor_Driver/step_count[19] ,
    \Motor_Driver/step_count[18] ,
    \Motor_Driver/step_count[17] ,
    \Motor_Driver/step_count[16] ,
    \Motor_Driver/step_count[15] ,
    \Motor_Driver/step_count[14] ,
    \Motor_Driver/step_count[13] ,
    \Motor_Driver/step_count[12] ,
    \Motor_Driver/step_count[11] ,
    \Motor_Driver/step_count[10] ,
    \Motor_Driver/step_count[9] ,
    \Motor_Driver/step_count[8] ,
    \Motor_Driver/step_count[7] ,
    \Motor_Driver/step_count[6] ,
    \Motor_Driver/step_count[5] ,
    \Motor_Driver/step_count[4] ,
    \Motor_Driver/step_count[3] ,
    \Motor_Driver/step_count[2] ,
    \Motor_Driver/step_count[1] ,
    \Motor_Driver/step_count[0] ,
    \Motor_Driver/step_x ,
    move_finished,
    \Motor_Driver/step_x_total[31] ,
    \Motor_Driver/step_x_total[30] ,
    \Motor_Driver/step_x_total[29] ,
    \Motor_Driver/step_x_total[28] ,
    \Motor_Driver/step_x_total[27] ,
    \Motor_Driver/step_x_total[26] ,
    \Motor_Driver/step_x_total[25] ,
    \Motor_Driver/step_x_total[24] ,
    \Motor_Driver/step_x_total[23] ,
    \Motor_Driver/step_x_total[22] ,
    \Motor_Driver/step_x_total[21] ,
    \Motor_Driver/step_x_total[20] ,
    \Motor_Driver/step_x_total[19] ,
    \Motor_Driver/step_x_total[18] ,
    \Motor_Driver/step_x_total[17] ,
    \Motor_Driver/step_x_total[16] ,
    \Motor_Driver/step_x_total[15] ,
    \Motor_Driver/step_x_total[14] ,
    \Motor_Driver/step_x_total[13] ,
    \Motor_Driver/step_x_total[12] ,
    \Motor_Driver/step_x_total[11] ,
    \Motor_Driver/step_x_total[10] ,
    \Motor_Driver/step_x_total[9] ,
    \Motor_Driver/step_x_total[8] ,
    \Motor_Driver/step_x_total[7] ,
    \Motor_Driver/step_x_total[6] ,
    \Motor_Driver/step_x_total[5] ,
    \Motor_Driver/step_x_total[4] ,
    \Motor_Driver/step_x_total[3] ,
    \Motor_Driver/step_x_total[2] ,
    \Motor_Driver/step_x_total[1] ,
    \Motor_Driver/step_x_total[0] ,
    \Motor_Driver/step_x_latch ,
    clk,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \raw_opcode[7] ;
input \raw_opcode[6] ;
input \raw_opcode[5] ;
input \raw_opcode[4] ;
input \raw_opcode[3] ;
input \raw_opcode[2] ;
input \raw_opcode[1] ;
input \raw_opcode[0] ;
input \The_Decoder/exec_target_x[31] ;
input \The_Decoder/exec_target_x[30] ;
input \The_Decoder/exec_target_x[29] ;
input \The_Decoder/exec_target_x[28] ;
input \The_Decoder/exec_target_x[27] ;
input \The_Decoder/exec_target_x[26] ;
input \The_Decoder/exec_target_x[25] ;
input \The_Decoder/exec_target_x[24] ;
input \The_Decoder/exec_target_x[23] ;
input \The_Decoder/exec_target_x[22] ;
input \The_Decoder/exec_target_x[21] ;
input \The_Decoder/exec_target_x[20] ;
input \The_Decoder/exec_target_x[19] ;
input \The_Decoder/exec_target_x[18] ;
input \The_Decoder/exec_target_x[17] ;
input \The_Decoder/exec_target_x[16] ;
input \The_Decoder/exec_target_x[15] ;
input \The_Decoder/exec_target_x[14] ;
input \The_Decoder/exec_target_x[13] ;
input \The_Decoder/exec_target_x[12] ;
input \The_Decoder/exec_target_x[11] ;
input \The_Decoder/exec_target_x[10] ;
input \The_Decoder/exec_target_x[9] ;
input \The_Decoder/exec_target_x[8] ;
input \The_Decoder/exec_target_x[7] ;
input \The_Decoder/exec_target_x[6] ;
input \The_Decoder/exec_target_x[5] ;
input \The_Decoder/exec_target_x[4] ;
input \The_Decoder/exec_target_x[3] ;
input \The_Decoder/exec_target_x[2] ;
input \The_Decoder/exec_target_x[1] ;
input \The_Decoder/exec_target_x[0] ;
input \feed_rate[15] ;
input \feed_rate[14] ;
input \feed_rate[13] ;
input \feed_rate[12] ;
input \feed_rate[11] ;
input \feed_rate[10] ;
input \feed_rate[9] ;
input \feed_rate[8] ;
input \feed_rate[7] ;
input \feed_rate[6] ;
input \feed_rate[5] ;
input \feed_rate[4] ;
input \feed_rate[3] ;
input \feed_rate[2] ;
input \feed_rate[1] ;
input \feed_rate[0] ;
input \The_Decoder/data_available ;
input instruction_ready;
input is_motion;
input kill_flag;
input pause_flag;
input homing_reset;
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
input \Motor_Driver/delta_x[31] ;
input \Motor_Driver/delta_x[30] ;
input \Motor_Driver/delta_x[29] ;
input \Motor_Driver/delta_x[28] ;
input \Motor_Driver/delta_x[27] ;
input \Motor_Driver/delta_x[26] ;
input \Motor_Driver/delta_x[25] ;
input \Motor_Driver/delta_x[24] ;
input \Motor_Driver/delta_x[23] ;
input \Motor_Driver/delta_x[22] ;
input \Motor_Driver/delta_x[21] ;
input \Motor_Driver/delta_x[20] ;
input \Motor_Driver/delta_x[19] ;
input \Motor_Driver/delta_x[18] ;
input \Motor_Driver/delta_x[17] ;
input \Motor_Driver/delta_x[16] ;
input \Motor_Driver/delta_x[15] ;
input \Motor_Driver/delta_x[14] ;
input \Motor_Driver/delta_x[13] ;
input \Motor_Driver/delta_x[12] ;
input \Motor_Driver/delta_x[11] ;
input \Motor_Driver/delta_x[10] ;
input \Motor_Driver/delta_x[9] ;
input \Motor_Driver/delta_x[8] ;
input \Motor_Driver/delta_x[7] ;
input \Motor_Driver/delta_x[6] ;
input \Motor_Driver/delta_x[5] ;
input \Motor_Driver/delta_x[4] ;
input \Motor_Driver/delta_x[3] ;
input \Motor_Driver/delta_x[2] ;
input \Motor_Driver/delta_x[1] ;
input \Motor_Driver/delta_x[0] ;
input \Motor_Driver/master_steps[31] ;
input \Motor_Driver/master_steps[30] ;
input \Motor_Driver/master_steps[29] ;
input \Motor_Driver/master_steps[28] ;
input \Motor_Driver/master_steps[27] ;
input \Motor_Driver/master_steps[26] ;
input \Motor_Driver/master_steps[25] ;
input \Motor_Driver/master_steps[24] ;
input \Motor_Driver/master_steps[23] ;
input \Motor_Driver/master_steps[22] ;
input \Motor_Driver/master_steps[21] ;
input \Motor_Driver/master_steps[20] ;
input \Motor_Driver/master_steps[19] ;
input \Motor_Driver/master_steps[18] ;
input \Motor_Driver/master_steps[17] ;
input \Motor_Driver/master_steps[16] ;
input \Motor_Driver/master_steps[15] ;
input \Motor_Driver/master_steps[14] ;
input \Motor_Driver/master_steps[13] ;
input \Motor_Driver/master_steps[12] ;
input \Motor_Driver/master_steps[11] ;
input \Motor_Driver/master_steps[10] ;
input \Motor_Driver/master_steps[9] ;
input \Motor_Driver/master_steps[8] ;
input \Motor_Driver/master_steps[7] ;
input \Motor_Driver/master_steps[6] ;
input \Motor_Driver/master_steps[5] ;
input \Motor_Driver/master_steps[4] ;
input \Motor_Driver/master_steps[3] ;
input \Motor_Driver/master_steps[2] ;
input \Motor_Driver/master_steps[1] ;
input \Motor_Driver/master_steps[0] ;
input \Motor_Driver/step_count[31] ;
input \Motor_Driver/step_count[30] ;
input \Motor_Driver/step_count[29] ;
input \Motor_Driver/step_count[28] ;
input \Motor_Driver/step_count[27] ;
input \Motor_Driver/step_count[26] ;
input \Motor_Driver/step_count[25] ;
input \Motor_Driver/step_count[24] ;
input \Motor_Driver/step_count[23] ;
input \Motor_Driver/step_count[22] ;
input \Motor_Driver/step_count[21] ;
input \Motor_Driver/step_count[20] ;
input \Motor_Driver/step_count[19] ;
input \Motor_Driver/step_count[18] ;
input \Motor_Driver/step_count[17] ;
input \Motor_Driver/step_count[16] ;
input \Motor_Driver/step_count[15] ;
input \Motor_Driver/step_count[14] ;
input \Motor_Driver/step_count[13] ;
input \Motor_Driver/step_count[12] ;
input \Motor_Driver/step_count[11] ;
input \Motor_Driver/step_count[10] ;
input \Motor_Driver/step_count[9] ;
input \Motor_Driver/step_count[8] ;
input \Motor_Driver/step_count[7] ;
input \Motor_Driver/step_count[6] ;
input \Motor_Driver/step_count[5] ;
input \Motor_Driver/step_count[4] ;
input \Motor_Driver/step_count[3] ;
input \Motor_Driver/step_count[2] ;
input \Motor_Driver/step_count[1] ;
input \Motor_Driver/step_count[0] ;
input \Motor_Driver/step_x ;
input move_finished;
input \Motor_Driver/step_x_total[31] ;
input \Motor_Driver/step_x_total[30] ;
input \Motor_Driver/step_x_total[29] ;
input \Motor_Driver/step_x_total[28] ;
input \Motor_Driver/step_x_total[27] ;
input \Motor_Driver/step_x_total[26] ;
input \Motor_Driver/step_x_total[25] ;
input \Motor_Driver/step_x_total[24] ;
input \Motor_Driver/step_x_total[23] ;
input \Motor_Driver/step_x_total[22] ;
input \Motor_Driver/step_x_total[21] ;
input \Motor_Driver/step_x_total[20] ;
input \Motor_Driver/step_x_total[19] ;
input \Motor_Driver/step_x_total[18] ;
input \Motor_Driver/step_x_total[17] ;
input \Motor_Driver/step_x_total[16] ;
input \Motor_Driver/step_x_total[15] ;
input \Motor_Driver/step_x_total[14] ;
input \Motor_Driver/step_x_total[13] ;
input \Motor_Driver/step_x_total[12] ;
input \Motor_Driver/step_x_total[11] ;
input \Motor_Driver/step_x_total[10] ;
input \Motor_Driver/step_x_total[9] ;
input \Motor_Driver/step_x_total[8] ;
input \Motor_Driver/step_x_total[7] ;
input \Motor_Driver/step_x_total[6] ;
input \Motor_Driver/step_x_total[5] ;
input \Motor_Driver/step_x_total[4] ;
input \Motor_Driver/step_x_total[3] ;
input \Motor_Driver/step_x_total[2] ;
input \Motor_Driver/step_x_total[1] ;
input \Motor_Driver/step_x_total[0] ;
input \Motor_Driver/step_x_latch ;
input clk;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \raw_opcode[7] ;
wire \raw_opcode[6] ;
wire \raw_opcode[5] ;
wire \raw_opcode[4] ;
wire \raw_opcode[3] ;
wire \raw_opcode[2] ;
wire \raw_opcode[1] ;
wire \raw_opcode[0] ;
wire \The_Decoder/exec_target_x[31] ;
wire \The_Decoder/exec_target_x[30] ;
wire \The_Decoder/exec_target_x[29] ;
wire \The_Decoder/exec_target_x[28] ;
wire \The_Decoder/exec_target_x[27] ;
wire \The_Decoder/exec_target_x[26] ;
wire \The_Decoder/exec_target_x[25] ;
wire \The_Decoder/exec_target_x[24] ;
wire \The_Decoder/exec_target_x[23] ;
wire \The_Decoder/exec_target_x[22] ;
wire \The_Decoder/exec_target_x[21] ;
wire \The_Decoder/exec_target_x[20] ;
wire \The_Decoder/exec_target_x[19] ;
wire \The_Decoder/exec_target_x[18] ;
wire \The_Decoder/exec_target_x[17] ;
wire \The_Decoder/exec_target_x[16] ;
wire \The_Decoder/exec_target_x[15] ;
wire \The_Decoder/exec_target_x[14] ;
wire \The_Decoder/exec_target_x[13] ;
wire \The_Decoder/exec_target_x[12] ;
wire \The_Decoder/exec_target_x[11] ;
wire \The_Decoder/exec_target_x[10] ;
wire \The_Decoder/exec_target_x[9] ;
wire \The_Decoder/exec_target_x[8] ;
wire \The_Decoder/exec_target_x[7] ;
wire \The_Decoder/exec_target_x[6] ;
wire \The_Decoder/exec_target_x[5] ;
wire \The_Decoder/exec_target_x[4] ;
wire \The_Decoder/exec_target_x[3] ;
wire \The_Decoder/exec_target_x[2] ;
wire \The_Decoder/exec_target_x[1] ;
wire \The_Decoder/exec_target_x[0] ;
wire \feed_rate[15] ;
wire \feed_rate[14] ;
wire \feed_rate[13] ;
wire \feed_rate[12] ;
wire \feed_rate[11] ;
wire \feed_rate[10] ;
wire \feed_rate[9] ;
wire \feed_rate[8] ;
wire \feed_rate[7] ;
wire \feed_rate[6] ;
wire \feed_rate[5] ;
wire \feed_rate[4] ;
wire \feed_rate[3] ;
wire \feed_rate[2] ;
wire \feed_rate[1] ;
wire \feed_rate[0] ;
wire \The_Decoder/data_available ;
wire instruction_ready;
wire is_motion;
wire kill_flag;
wire pause_flag;
wire homing_reset;
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
wire \Motor_Driver/delta_x[31] ;
wire \Motor_Driver/delta_x[30] ;
wire \Motor_Driver/delta_x[29] ;
wire \Motor_Driver/delta_x[28] ;
wire \Motor_Driver/delta_x[27] ;
wire \Motor_Driver/delta_x[26] ;
wire \Motor_Driver/delta_x[25] ;
wire \Motor_Driver/delta_x[24] ;
wire \Motor_Driver/delta_x[23] ;
wire \Motor_Driver/delta_x[22] ;
wire \Motor_Driver/delta_x[21] ;
wire \Motor_Driver/delta_x[20] ;
wire \Motor_Driver/delta_x[19] ;
wire \Motor_Driver/delta_x[18] ;
wire \Motor_Driver/delta_x[17] ;
wire \Motor_Driver/delta_x[16] ;
wire \Motor_Driver/delta_x[15] ;
wire \Motor_Driver/delta_x[14] ;
wire \Motor_Driver/delta_x[13] ;
wire \Motor_Driver/delta_x[12] ;
wire \Motor_Driver/delta_x[11] ;
wire \Motor_Driver/delta_x[10] ;
wire \Motor_Driver/delta_x[9] ;
wire \Motor_Driver/delta_x[8] ;
wire \Motor_Driver/delta_x[7] ;
wire \Motor_Driver/delta_x[6] ;
wire \Motor_Driver/delta_x[5] ;
wire \Motor_Driver/delta_x[4] ;
wire \Motor_Driver/delta_x[3] ;
wire \Motor_Driver/delta_x[2] ;
wire \Motor_Driver/delta_x[1] ;
wire \Motor_Driver/delta_x[0] ;
wire \Motor_Driver/master_steps[31] ;
wire \Motor_Driver/master_steps[30] ;
wire \Motor_Driver/master_steps[29] ;
wire \Motor_Driver/master_steps[28] ;
wire \Motor_Driver/master_steps[27] ;
wire \Motor_Driver/master_steps[26] ;
wire \Motor_Driver/master_steps[25] ;
wire \Motor_Driver/master_steps[24] ;
wire \Motor_Driver/master_steps[23] ;
wire \Motor_Driver/master_steps[22] ;
wire \Motor_Driver/master_steps[21] ;
wire \Motor_Driver/master_steps[20] ;
wire \Motor_Driver/master_steps[19] ;
wire \Motor_Driver/master_steps[18] ;
wire \Motor_Driver/master_steps[17] ;
wire \Motor_Driver/master_steps[16] ;
wire \Motor_Driver/master_steps[15] ;
wire \Motor_Driver/master_steps[14] ;
wire \Motor_Driver/master_steps[13] ;
wire \Motor_Driver/master_steps[12] ;
wire \Motor_Driver/master_steps[11] ;
wire \Motor_Driver/master_steps[10] ;
wire \Motor_Driver/master_steps[9] ;
wire \Motor_Driver/master_steps[8] ;
wire \Motor_Driver/master_steps[7] ;
wire \Motor_Driver/master_steps[6] ;
wire \Motor_Driver/master_steps[5] ;
wire \Motor_Driver/master_steps[4] ;
wire \Motor_Driver/master_steps[3] ;
wire \Motor_Driver/master_steps[2] ;
wire \Motor_Driver/master_steps[1] ;
wire \Motor_Driver/master_steps[0] ;
wire \Motor_Driver/step_count[31] ;
wire \Motor_Driver/step_count[30] ;
wire \Motor_Driver/step_count[29] ;
wire \Motor_Driver/step_count[28] ;
wire \Motor_Driver/step_count[27] ;
wire \Motor_Driver/step_count[26] ;
wire \Motor_Driver/step_count[25] ;
wire \Motor_Driver/step_count[24] ;
wire \Motor_Driver/step_count[23] ;
wire \Motor_Driver/step_count[22] ;
wire \Motor_Driver/step_count[21] ;
wire \Motor_Driver/step_count[20] ;
wire \Motor_Driver/step_count[19] ;
wire \Motor_Driver/step_count[18] ;
wire \Motor_Driver/step_count[17] ;
wire \Motor_Driver/step_count[16] ;
wire \Motor_Driver/step_count[15] ;
wire \Motor_Driver/step_count[14] ;
wire \Motor_Driver/step_count[13] ;
wire \Motor_Driver/step_count[12] ;
wire \Motor_Driver/step_count[11] ;
wire \Motor_Driver/step_count[10] ;
wire \Motor_Driver/step_count[9] ;
wire \Motor_Driver/step_count[8] ;
wire \Motor_Driver/step_count[7] ;
wire \Motor_Driver/step_count[6] ;
wire \Motor_Driver/step_count[5] ;
wire \Motor_Driver/step_count[4] ;
wire \Motor_Driver/step_count[3] ;
wire \Motor_Driver/step_count[2] ;
wire \Motor_Driver/step_count[1] ;
wire \Motor_Driver/step_count[0] ;
wire \Motor_Driver/step_x ;
wire move_finished;
wire \Motor_Driver/step_x_total[31] ;
wire \Motor_Driver/step_x_total[30] ;
wire \Motor_Driver/step_x_total[29] ;
wire \Motor_Driver/step_x_total[28] ;
wire \Motor_Driver/step_x_total[27] ;
wire \Motor_Driver/step_x_total[26] ;
wire \Motor_Driver/step_x_total[25] ;
wire \Motor_Driver/step_x_total[24] ;
wire \Motor_Driver/step_x_total[23] ;
wire \Motor_Driver/step_x_total[22] ;
wire \Motor_Driver/step_x_total[21] ;
wire \Motor_Driver/step_x_total[20] ;
wire \Motor_Driver/step_x_total[19] ;
wire \Motor_Driver/step_x_total[18] ;
wire \Motor_Driver/step_x_total[17] ;
wire \Motor_Driver/step_x_total[16] ;
wire \Motor_Driver/step_x_total[15] ;
wire \Motor_Driver/step_x_total[14] ;
wire \Motor_Driver/step_x_total[13] ;
wire \Motor_Driver/step_x_total[12] ;
wire \Motor_Driver/step_x_total[11] ;
wire \Motor_Driver/step_x_total[10] ;
wire \Motor_Driver/step_x_total[9] ;
wire \Motor_Driver/step_x_total[8] ;
wire \Motor_Driver/step_x_total[7] ;
wire \Motor_Driver/step_x_total[6] ;
wire \Motor_Driver/step_x_total[5] ;
wire \Motor_Driver/step_x_total[4] ;
wire \Motor_Driver/step_x_total[3] ;
wire \Motor_Driver/step_x_total[2] ;
wire \Motor_Driver/step_x_total[1] ;
wire \Motor_Driver/step_x_total[0] ;
wire \Motor_Driver/step_x_latch ;
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
    .data_i({\raw_opcode[7] ,\raw_opcode[6] ,\raw_opcode[5] ,\raw_opcode[4] ,\raw_opcode[3] ,\raw_opcode[2] ,\raw_opcode[1] ,\raw_opcode[0] ,\The_Decoder/exec_target_x[31] ,\The_Decoder/exec_target_x[30] ,\The_Decoder/exec_target_x[29] ,\The_Decoder/exec_target_x[28] ,\The_Decoder/exec_target_x[27] ,\The_Decoder/exec_target_x[26] ,\The_Decoder/exec_target_x[25] ,\The_Decoder/exec_target_x[24] ,\The_Decoder/exec_target_x[23] ,\The_Decoder/exec_target_x[22] ,\The_Decoder/exec_target_x[21] ,\The_Decoder/exec_target_x[20] ,\The_Decoder/exec_target_x[19] ,\The_Decoder/exec_target_x[18] ,\The_Decoder/exec_target_x[17] ,\The_Decoder/exec_target_x[16] ,\The_Decoder/exec_target_x[15] ,\The_Decoder/exec_target_x[14] ,\The_Decoder/exec_target_x[13] ,\The_Decoder/exec_target_x[12] ,\The_Decoder/exec_target_x[11] ,\The_Decoder/exec_target_x[10] ,\The_Decoder/exec_target_x[9] ,\The_Decoder/exec_target_x[8] ,\The_Decoder/exec_target_x[7] ,\The_Decoder/exec_target_x[6] ,\The_Decoder/exec_target_x[5] ,\The_Decoder/exec_target_x[4] ,\The_Decoder/exec_target_x[3] ,\The_Decoder/exec_target_x[2] ,\The_Decoder/exec_target_x[1] ,\The_Decoder/exec_target_x[0] ,\feed_rate[15] ,\feed_rate[14] ,\feed_rate[13] ,\feed_rate[12] ,\feed_rate[11] ,\feed_rate[10] ,\feed_rate[9] ,\feed_rate[8] ,\feed_rate[7] ,\feed_rate[6] ,\feed_rate[5] ,\feed_rate[4] ,\feed_rate[3] ,\feed_rate[2] ,\feed_rate[1] ,\feed_rate[0] ,\The_Decoder/data_available ,instruction_ready,is_motion,kill_flag,pause_flag,homing_reset,\current_x[31] ,\current_x[30] ,\current_x[29] ,\current_x[28] ,\current_x[27] ,\current_x[26] ,\current_x[25] ,\current_x[24] ,\current_x[23] ,\current_x[22] ,\current_x[21] ,\current_x[20] ,\current_x[19] ,\current_x[18] ,\current_x[17] ,\current_x[16] ,\current_x[15] ,\current_x[14] ,\current_x[13] ,\current_x[12] ,\current_x[11] ,\current_x[10] ,\current_x[9] ,\current_x[8] ,\current_x[7] ,\current_x[6] ,\current_x[5] ,\current_x[4] ,\current_x[3] ,\current_x[2] ,\current_x[1] ,\current_x[0] ,\target_x[31] ,\target_x[30] ,\target_x[29] ,\target_x[28] ,\target_x[27] ,\target_x[26] ,\target_x[25] ,\target_x[24] ,\target_x[23] ,\target_x[22] ,\target_x[21] ,\target_x[20] ,\target_x[19] ,\target_x[18] ,\target_x[17] ,\target_x[16] ,\target_x[15] ,\target_x[14] ,\target_x[13] ,\target_x[12] ,\target_x[11] ,\target_x[10] ,\target_x[9] ,\target_x[8] ,\target_x[7] ,\target_x[6] ,\target_x[5] ,\target_x[4] ,\target_x[3] ,\target_x[2] ,\target_x[1] ,\target_x[0] ,\Motor_Driver/delta_x[31] ,\Motor_Driver/delta_x[30] ,\Motor_Driver/delta_x[29] ,\Motor_Driver/delta_x[28] ,\Motor_Driver/delta_x[27] ,\Motor_Driver/delta_x[26] ,\Motor_Driver/delta_x[25] ,\Motor_Driver/delta_x[24] ,\Motor_Driver/delta_x[23] ,\Motor_Driver/delta_x[22] ,\Motor_Driver/delta_x[21] ,\Motor_Driver/delta_x[20] ,\Motor_Driver/delta_x[19] ,\Motor_Driver/delta_x[18] ,\Motor_Driver/delta_x[17] ,\Motor_Driver/delta_x[16] ,\Motor_Driver/delta_x[15] ,\Motor_Driver/delta_x[14] ,\Motor_Driver/delta_x[13] ,\Motor_Driver/delta_x[12] ,\Motor_Driver/delta_x[11] ,\Motor_Driver/delta_x[10] ,\Motor_Driver/delta_x[9] ,\Motor_Driver/delta_x[8] ,\Motor_Driver/delta_x[7] ,\Motor_Driver/delta_x[6] ,\Motor_Driver/delta_x[5] ,\Motor_Driver/delta_x[4] ,\Motor_Driver/delta_x[3] ,\Motor_Driver/delta_x[2] ,\Motor_Driver/delta_x[1] ,\Motor_Driver/delta_x[0] ,\Motor_Driver/master_steps[31] ,\Motor_Driver/master_steps[30] ,\Motor_Driver/master_steps[29] ,\Motor_Driver/master_steps[28] ,\Motor_Driver/master_steps[27] ,\Motor_Driver/master_steps[26] ,\Motor_Driver/master_steps[25] ,\Motor_Driver/master_steps[24] ,\Motor_Driver/master_steps[23] ,\Motor_Driver/master_steps[22] ,\Motor_Driver/master_steps[21] ,\Motor_Driver/master_steps[20] ,\Motor_Driver/master_steps[19] ,\Motor_Driver/master_steps[18] ,\Motor_Driver/master_steps[17] ,\Motor_Driver/master_steps[16] ,\Motor_Driver/master_steps[15] ,\Motor_Driver/master_steps[14] ,\Motor_Driver/master_steps[13] ,\Motor_Driver/master_steps[12] ,\Motor_Driver/master_steps[11] ,\Motor_Driver/master_steps[10] ,\Motor_Driver/master_steps[9] ,\Motor_Driver/master_steps[8] ,\Motor_Driver/master_steps[7] ,\Motor_Driver/master_steps[6] ,\Motor_Driver/master_steps[5] ,\Motor_Driver/master_steps[4] ,\Motor_Driver/master_steps[3] ,\Motor_Driver/master_steps[2] ,\Motor_Driver/master_steps[1] ,\Motor_Driver/master_steps[0] ,\Motor_Driver/step_count[31] ,\Motor_Driver/step_count[30] ,\Motor_Driver/step_count[29] ,\Motor_Driver/step_count[28] ,\Motor_Driver/step_count[27] ,\Motor_Driver/step_count[26] ,\Motor_Driver/step_count[25] ,\Motor_Driver/step_count[24] ,\Motor_Driver/step_count[23] ,\Motor_Driver/step_count[22] ,\Motor_Driver/step_count[21] ,\Motor_Driver/step_count[20] ,\Motor_Driver/step_count[19] ,\Motor_Driver/step_count[18] ,\Motor_Driver/step_count[17] ,\Motor_Driver/step_count[16] ,\Motor_Driver/step_count[15] ,\Motor_Driver/step_count[14] ,\Motor_Driver/step_count[13] ,\Motor_Driver/step_count[12] ,\Motor_Driver/step_count[11] ,\Motor_Driver/step_count[10] ,\Motor_Driver/step_count[9] ,\Motor_Driver/step_count[8] ,\Motor_Driver/step_count[7] ,\Motor_Driver/step_count[6] ,\Motor_Driver/step_count[5] ,\Motor_Driver/step_count[4] ,\Motor_Driver/step_count[3] ,\Motor_Driver/step_count[2] ,\Motor_Driver/step_count[1] ,\Motor_Driver/step_count[0] ,\Motor_Driver/step_x ,move_finished,\Motor_Driver/step_x_total[31] ,\Motor_Driver/step_x_total[30] ,\Motor_Driver/step_x_total[29] ,\Motor_Driver/step_x_total[28] ,\Motor_Driver/step_x_total[27] ,\Motor_Driver/step_x_total[26] ,\Motor_Driver/step_x_total[25] ,\Motor_Driver/step_x_total[24] ,\Motor_Driver/step_x_total[23] ,\Motor_Driver/step_x_total[22] ,\Motor_Driver/step_x_total[21] ,\Motor_Driver/step_x_total[20] ,\Motor_Driver/step_x_total[19] ,\Motor_Driver/step_x_total[18] ,\Motor_Driver/step_x_total[17] ,\Motor_Driver/step_x_total[16] ,\Motor_Driver/step_x_total[15] ,\Motor_Driver/step_x_total[14] ,\Motor_Driver/step_x_total[13] ,\Motor_Driver/step_x_total[12] ,\Motor_Driver/step_x_total[11] ,\Motor_Driver/step_x_total[10] ,\Motor_Driver/step_x_total[9] ,\Motor_Driver/step_x_total[8] ,\Motor_Driver/step_x_total[7] ,\Motor_Driver/step_x_total[6] ,\Motor_Driver/step_x_total[5] ,\Motor_Driver/step_x_total[4] ,\Motor_Driver/step_x_total[3] ,\Motor_Driver/step_x_total[2] ,\Motor_Driver/step_x_total[1] ,\Motor_Driver/step_x_total[0] ,\Motor_Driver/step_x_latch }),
    .clk_i(clk)
);

endmodule
