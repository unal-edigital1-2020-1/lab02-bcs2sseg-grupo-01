module BCDtoSSeg ( input [3:0] BCD, output reg [0:6] SSeg );

    always @ ( * ) begin
        
        case ( BCD )
            
           4'b0000: SSeg = 7'b1000000; // 0  
            4'b0001: SSeg = 7'b1111001; // 1 
            4'b0010: SSeg = 7'b0100100; // 2 
            4'b0011: SSeg = 7'b0110000; // 3 
            4'b0100: SSeg = 7'b0011001; // 4 
            4'b0101: SSeg = 7'b0010010; // 5 
            4'b0110: SSeg = 7'b0000010; // 6 
            4'b0111: SSeg = 7'b1111000; // 7 
            4'b1000: SSeg = 7'b0000000; // 8  
            4'b1001: SSeg = 7'b0010000; // 9 

            default: SSeg =7'b1111111;

        endcase

    end

endmodule