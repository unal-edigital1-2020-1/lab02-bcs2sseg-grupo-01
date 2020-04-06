module sseg_5display( input [15:0] num, input clk, output [0:6] SSeg, output reg [4:0] an = 5'b11111, output enable );

    reg [3:0] BCD = 0;
    reg [22:0] cfreq = 0;
    reg [2:0] count = 0;
    reg [19:0] allBCD = 0;
    reg [35:0] shifter = 0; 
    integer i; 
   
    BCDtoSSeg bcdtosseg( .BCD(BCD), .SSeg(SSeg) );
   
    always@( num ) begin 

        shifter[15:0] = num; 
    
        for (i = 0; i < 16; i = i+1) begin 

            if ( shifter[19:16] >= 5 ) shifter[19:16] = shifter[19:16]+3; 
            if ( shifter[23:20] >= 5 ) shifter[23:20] = shifter[23:20]+3;
            if ( shifter[27:24] >= 5 ) shifter[27:24] = shifter[27:24]+3; 
            if ( shifter[31:28] >= 5 ) shifter[31:28] = shifter[31:28]+3; 
            if ( shifter[35:32] >= 5 ) shifter[35:32] = shifter[35:32]+3; 
            shifter = shifter<<1;    
        
        end  

        allBCD = shifter[35:16];
    
    end
    
    assign enable = cfreq[22];
    
    always @( posedge clk ) begin
        
	   cfreq <= cfreq+1;

    end

    always @( posedge enable ) begin
	  
        case ( count ) 
				
            0: begin BCD <= allBCD[3:0];   an <= 5'b11110; end 
            1: begin BCD <= allBCD[7:4];   an <= 5'b11101; end 
            2: begin BCD <= allBCD[11:8];  an <= 5'b11011; end 
            3: begin BCD <= allBCD[15:12]; an <= 5'b10111; end 
            4: begin BCD <= allBCD[19:16]; an <= 5'b01111; end 
			
        endcase   
           
        if( count == 3'b100 ) count <= 3'b000;
        else count <= count+1;
           
    end

endmodule