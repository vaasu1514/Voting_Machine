// Voting Logger --> Basicaly counts the valid votes by voters to each of candidates

module vote_logger (clock,mode,reset,candidate_valid_vote, cand_1_vote , cand_2_vote , cand_3_vote , cand_4_vote) ;

input clock,reset,mode ;
input [4:1] candidate_valid_vote ; // there are 4 candidates in election (Signals from 4 button control modules)
output reg [7:0] cand_1_vote , cand_2_vote , cand_3_vote , cand_4_vote ; // assume at max a candidate can get 256 votes

always @ (posedge clock)
    begin
        if (reset)
            begin
                cand_1_vote <= 0 ;
                cand_2_vote <= 0 ;
                cand_3_vote <= 0 ;
                cand_4_vote <= 0 ;
            end
        else
            begin
                if (candidate_valid_vote[1] & mode==0 ) // if valid vote is for Candidate-1
                    cand_1_vote <= cand_1_vote + 1 ;

                else if (candidate_valid_vote[2] & mode==0 ) // if valid vote is for Candidate-2
                    cand_2_vote <= cand_2_vote +1 ;
                
                else if (candidate_valid_vote[3] & mode==0 ) // if valid vote is for Candidate-3
                    cand_3_vote <= cand_3_vote +1 ;

                else if (candidate_valid_vote[4]& mode==0 ) // if valid vote is for Candidate-4
                    cand_4_vote <= cand_4_vote +1 ;
            end
    end

endmodule