// Voting Machine

module voting_machine (clock,reset,mode,button,vote_result) ;

input clock,reset,mode ;
input [4:1] button ; // 4 Candidates so 4 buttons 
output [7:0] vote_result ;

wire [4:1] valid_vote ;
wire [7:0] cand_1_vote_recv,cand_2_vote_recv,cand_3_vote_recv,cand_4_vote_recv ;
wire anyValidVote ;

assign anyValidVote = | valid_vote ;

// INSTANTIATING MODULES
button_control bc1 (.button(button[1]),.clock(clock),.reset(reset),.valid_vote(valid_vote[1])) ;
button_control bc2 (.button(button[2]),.clock(clock),.reset(reset),.valid_vote(valid_vote[2])) ;
button_control bc3 (.button(button[3]),.clock(clock),.reset(reset),.valid_vote(valid_vote[3])) ;
button_control bc4 (.button(button[4]),.clock(clock),.reset(reset),.valid_vote(valid_vote[4])) ;
vote_logger VL (.clock(clock),.mode(mode),.reset(reset),.candidate_valid_vote(valid_vote), .cand_1_vote(cand_1_vote_recv) , .cand_2_vote(cand_2_vote_recv) , .cand_3_vote(cand_3_vote_recv) , .cand_4_vote(cand_4_vote_recv)) ;
mode_control MC (.mode(mode),.clock(clock),.reset(reset),.valid_vote_casted(anyValidVote),.cand_1_vote(cand_1_vote_recv),.cand_2_vote(cand_2_vote_recv),.cand_3_vote(cand_3_vote_recv),.cand_4_vote(cand_4_vote_recv),.candidate_button_press(valid_vote),.vote_result(vote_result));
endmodule