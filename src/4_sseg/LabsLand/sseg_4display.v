module sseg_4display( 
    
    input wire [15:0] V_SW,
    input wire G_CLOCK_50, 
    output wire [6:0] G_HEX0,
    output wire [6:0] G_HEX1,
    output wire [6:0] G_HEX2,
    output wire [6:0] G_HEX3);

    wire enable;
    wire [15:0] num;
    
    reg [3:0] BCD1 = 0;
    reg [3:0] BCD2 = 0;
    reg [3:0] BCD3 = 0;
    reg [3:0] BCD4 = 0;
    reg [22:0] cfreq = 0;
    reg [1:0] count = 0;
    
    
    BCDtoSSeg bcdtosseg( .BCD(BCD1), .SSeg(G_HEX0));
    BCDtoSSeg bcdtosseg1( .BCD(BCD2), .SSeg(G_HEX1));
    BCDtoSSeg bcdtosseg2( .BCD(BCD3), .SSeg(G_HEX2));
    BCDtoSSeg bcdtosseg3( .BCD(BCD4), .SSeg(G_HEX3));
    
    assign num=V_SW;
    
    assign enable = cfreq[22];
    
    always @( posedge G_CLOCK_50 ) begin
        
	   cfreq <= cfreq+1;

    end

    always @( posedge enable ) begin
	   
        case ( count ) 
				
          2'b00: begin BCD1 <= V_SW[3:0]; end 
		  2'b01: begin BCD2 <= V_SW[7:4]; end 
		  2'b10: begin BCD3 <= V_SW[11:8]; end 
		  2'b11: begin BCD4 <= V_SW[15:12]; end 
			
        endcase   
           
        count <= count+1;
    
    end

endmodule
