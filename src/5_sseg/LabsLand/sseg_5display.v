module sseg_5display( 
    input wire [15:0] V_SW,
    output wire [6:0] G_HEX0=0,
    output wire [6:0] G_HEX1=0,
    output wire [6:0] G_HEX2=0,
    output wire [6:0] G_HEX3=0,
    output wire [6:0] G_HEX4=0);
    
    reg [3:0] BCD1;
    reg [3:0] BCD2;
    reg [3:0] BCD3;
    reg [3:0] BCD4;
    reg [3:0] BCD5;
   
    reg [19:0] allBCD =0;
    reg [35:0] shifter=0 ; 
    integer i; 
   
    BCDtoSSeg bcdtosseg( .BCD(BCD1), .SSeg(G_HEX0) );
    BCDtoSSeg bcdtosseg1( .BCD(BCD2), .SSeg(G_HEX1) );
    BCDtoSSeg bcdtosseg2( .BCD(BCD3), .SSeg(G_HEX2) );
    BCDtoSSeg bcdtosseg3( .BCD(BCD4), .SSeg(G_HEX3) );
    BCDtoSSeg bcdtosseg4( .BCD(BCD5), .SSeg(G_HEX4) );
   
    always@( V_SW ) begin 
        
        shifter=16'b0000000000000000;
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
        BCD1 <= allBCD[3:0]; 
        BCD2 <= allBCD[7:4];  
        BCD3 <= allBCD[11:8]; 
        BCD4 <= allBCD[15:12];  
        BCD5 <= allBCD[19:16];
    
    end

endmodule