module mode_control (mode,clock,reset,valid_vote_casted,cand_1_vote,cand_2_vote,cand_3_vote
                     ,cand_4_vote,candidate_button_press,vote_result);

input mode,clock,reset ;
input valid_vote_casted ; // set if valid vote is casted for any candidate
input [7:0] cand_1_vote,cand_2_vote,cand_3_vote,cand_4_vote ;
input [4:1] candidate_button_press ;
output reg [7:0] vote_result ;

reg [30:0] counter ;

always @ (posedge clock)
    begin
        if (reset)
            counter <= 0 ; // whenever the counter is reset make it zero

        else if (valid_vote_casted)
            counter <= counter +1 ;  // when a valid vote for any candidate comes then make counter 1
            
        else if (counter != 0 & counter < 1000 )
            counter <= counter + 1 ;
        
        else
            counter <= 0 ;
    end

always @ (posedge clock)
    begin
        if (reset)
            vote_result <= 0 ;

        else
            begin
                if ( mode==0 & counter>0 ) // mode0 --> voting mode ; mode1 --> result displaying mode
                    vote_result <= 8'hff ; // make the LED glow for one sec when ever valid vote is casted

                else if (mode==0)  // when mode is 0 and counter==0 then LEDs must be dark
                    vote_result <= 8'h00 ;
                
                else if ( mode==1 )
                    begin
                        if (candidate_button_press[1])
                            vote_result <= cand_1_vote ;

                        else if (candidate_button_press[2])
                            vote_result <= cand_2_vote ;

                        else if (candidate_button_press[3])
                            vote_result <= cand_3_vote ;

                        else if (candidate_button_press[4])
                            vote_result <= cand_4_vote ;   
                    end
            end    
    end
endmodule