// Button Control ( for any one button ) 

module button_control (button,clock,reset,valid_vote) ;

input button,clock,reset ;
output reg valid_vote ;

reg [30:0] counter ;

always @ (posedge clock)
    begin
        if (reset)
            counter <= 0 ;
        else 
            begin
                if (button & counter < 1001) // clock time period = 10^-8 sec and counter counts till 10^8 
                    counter <= counter + 1 ;
                else if (!button)
                    counter <= 0 ;   
            end
    end

always @ (posedge clock)
    begin
        if (reset)
            valid_vote <= 1'b0 ;
        else 
            begin
                if (counter == 1000)
                    valid_vote <= 1'b1 ;
                else
                    valid_vote <= 1'b0 ;    
            end   
    end
endmodule