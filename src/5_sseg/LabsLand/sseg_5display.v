module sseg_5display( 

    input wire [15:0] V_SW,
    input wire G_CLOCK_50, 
    output wire [6:0] G_HEX0,
    output wire [6:0] G_HEX1,
    output wire [6:0] G_HEX2,
    output wire [6:0] G_HEX3,
    output wire [6:0] G_HEX4);
    
    wire enable;
    
    
    reg [3:0] BCD1;
    reg [3:0] BCD2;
    reg [3:0] BCD3;
    reg [3:0] BCD4;
    reg [3:0] BCD5;
    reg [22:0] cfreq = 0;
    reg [2:0] count = 0;
    reg [19:0] allBCD ;
    reg [35:0] shifter ; 
    integer i; 
   
    BCDtoSSeg bcdtosseg( .BCD(BCD1), .SSeg(G_HEX0) );
    BCDtoSSeg bcdtosseg1( .BCD(BCD2), .SSeg(G_HEX1) );
    BCDtoSSeg bcdtosseg2( .BCD(BCD3), .SSeg(G_HEX2) );
    BCDtoSSeg bcdtosseg3( .BCD(BCD4), .SSeg(G_HEX3) );
    BCDtoSSeg bcdtosseg4( .BCD(BCD5), .SSeg(G_HEX4) );
   
    always@(posedge enable ) begin 

        shifter[15:0] = V_SW; 
    
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
    
    assign enable = cfreq[15];
    
    always @( posedge G_CLOCK_50 ) begin
        
	   cfreq <= cfreq+1;

    end

    always @( posedge enable ) begin
	  
        case ( count ) 
				
            0: begin BCD1 <= allBCD[3:0]; end 
            1: begin BCD2 <= allBCD[7:4]; end 
            2: begin BCD3 <= allBCD[11:8]; end 
            3: begin BCD4 <= allBCD[15:12]; end 
            4: begin BCD5 <= allBCD[19:16]; end 
			
        endcase   
           
        if( count == 3'b100 ) count <= 3'b000;
        else count <= count+1;
           
    end

endmodule