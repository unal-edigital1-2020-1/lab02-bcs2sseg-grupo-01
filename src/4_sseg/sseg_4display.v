module sseg_4display( input [15:0] num, input clk, output [0:6] SSeg, output reg [3:0] an = 4'b1111, output enable );

    reg [3:0] BCD = 0;
    reg [22:0] cfreq = 0;
    reg [1:0] count = 0;
    
    BCDtoSSeg bcdtosseg( .BCD(BCD), .SSeg(SSeg) );

    assign enable = cfreq[22];
    
    always @( posedge clk ) begin
        
	   cfreq <= cfreq+1;

    end

    always @( posedge enable ) begin
	   
        case ( count ) 
				
          2'b00: begin BCD <= num[3:0];   an <= 4'b1110; end 
		  2'b01: begin BCD <= num[7:4];   an <= 4'b1101; end 
		  2'b10: begin BCD <= num[11:8];  an <= 4'b1011; end 
		  2'b11: begin BCD <= num[15:12]; an <= 4'b0111; end 
			
        endcase   
           
        count <= count+1;
    
    end

endmodule