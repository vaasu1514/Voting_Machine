
`include "Button_Control.v"
`include "Vote_Logger.v"
`include "Mode_Control.v"

`timescale 1ns/1ps

module test_bench ;

reg clock,reset,mode ;
reg [4:1] button ;
wire [7:0] vote_result ;

voting_machine VM (clock,reset,mode,button,vote_result) ;

initial // CLOCK
    begin
        clock= 1'b0 ;
        forever 
        #5 clock = ~ clock ;
    end

initial // STIMULUS
    begin
        reset = 1'b1 ;
        mode = 1'b0 ;    // VOTING MODE
        button = 4'b0 ;

        #22 ;
        reset = 1'b0 ;
        #20 ;

             button = 4'b0001 ;
        #20000 button = 4'b0000;
        #2000 button = 4'b0001 ;  // Candidate 1 gets 4 votes
        #20000 button = 4'b0000;
        #2000 button = 4'b0001 ;
        #20000 button = 4'b0000;
        #2000 button = 4'b0001 ;
        #20000 button = 4'b0000;

        #2000 button = 4'b0010 ;  // Candidate 2 gets 3 votes
        #20000 button = 4'b0000;
        #2000 button = 4'b0010 ;
        #20000 button = 4'b0000;
        #2000 button = 4'b0010 ;
        #20000 button = 4'b0000;
        
        #2000 button = 4'b0100 ;  // Candidate 3 gets 2 votes
        #20000 button = 4'b0000;
        #2000 button = 4'b0100 ;
        #20000 button = 4'b0000;

        #2000 button = 4'b1000 ;  // Candidate 4 gets 1 vote
        #20000 button = 4'b0000;

        #2000 mode = 1'b1 ;        // RESULT DISPLAY MODE
        #4000 ;

             button = 4'b0001 ;
        #20000 button = 4'b0010 ;
        #20000 button = 4'b0100 ;
        #20000 button = 4'b1000 ;
    end

initial 
    begin
        $dumpfile ("voting_machine.vcd") ;
        $dumpvars (0,test_bench) ;
        $monitor(" mode=%b | vote_result=%d", mode, vote_result);
      #300000 $finish ;
    end



endmodule