module top(clk_in, clk_out, rst, inc, dec);
  parameter DIV = 5'd20;
  
  input clk_in, rst, inc, dec;
  
  output clk_out;
  
  
  reg [4:0] counter;
  reg [4:0] tmp_d;
  
  reg inc_r, dec_r;
  wire [4:0] counter_next;
  
  
  assign clk_out = !(counter < tmp_d);
  assign counter_next = (counter < (DIV - 5'd1)) ? (counter + 5'd1) : 5'd0;
  
  
  always @(posedge clk_in or posedge rst) begin
    if (rst) begin
        counter <= 5'd0;
    end 
    else begin 
		counter <= counter_next;
    end
  end
  
  always @(posedge clk_in)
  begin
	if (rst) begin
		inc_r <= 1'b0;
		dec_r <= 1'b0;
	end
	else begin
		inc_r <= inc;
		dec_r <= dec;
	end
  end
  
  always @(posedge clk_in) begin
      if(rst) begin 
        tmp_d <= 4'd10;
      end 
      else begin
			if (inc & ~inc_r) begin
				if (tmp_d != 5'd0)
					tmp_d <= tmp_d - 5'd1;
			end
			
			if (dec & ~dec_r) begin
				if(tmp_d != 5'd20) begin
					tmp_d <= tmp_d + 5'd1;
				end
			end
      end
    end //always
    
endmodule
