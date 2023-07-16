module fifo#(parameter B=8,w=3)(input clk,rst,rd,wr,input [B-1:0] w_data,output wire empty,full,output [B-1:0]r_data);

reg [B-1:0] array [2**w-1:0];
reg [w-1:0] w_ptr,w_ptr_nxt,w_ptr_suc,r_ptr,r_ptr_nxt,r_ptr_suc;
reg full_reg,empty_reg,full_nxt,empty_nxt;
wire wr_en;
always@(posedge clk)
if(wr_en)
array[w_ptr]<=w_data;
assign r_data=array[r_ptr];
assign wr_en=wr&(!full_reg);

always@(posedge clk,posedge rst)
begin
if(rst)
begin
w_ptr<=0;
r_ptr<=0;
full_reg <=0;
empty_reg <=1;
end
else
begin
w_ptr<=w_ptr_nxt;
r_ptr<=r_ptr_nxt;
full_reg<=full_nxt;
empty_reg<=empty_nxt;
end
end

always@*
begin
w_ptr_suc=w_ptr+1;
r_ptr_suc=r_ptr+1;
w_ptr_nxt = w_ptr;
r_ptr_nxt = r_ptr;
full_nxt = full_reg;
empty_nxt = empty_reg;
case({wr,rd})
2'b01:if(!empty_reg)
      begin
      r_ptr_nxt=r_ptr_suc;
      full_nxt=0;
      if(r_ptr_suc==w_ptr)
	empty_nxt=1;
      end
2'b10:if(!full_reg)
      begin
      w_ptr_nxt=w_ptr_suc;
      empty_nxt=0;
      if(w_ptr_suc==r_ptr)
	full_nxt=1;
      end
2'b11:begin
      w_ptr_nxt = w_ptr_suc;
      r_ptr_nxt = r_ptr_suc;
      end
endcase
end
assign full=full_reg;
assign empty=empty_reg;
endmodule
