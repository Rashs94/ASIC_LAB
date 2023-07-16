module fifo_tst();
parameter B=8;
reg clk,rst,rd,wr;
reg [B-1:0] w_data;
wire empty,full;
wire [B-1:0]r_data;

 fifo f1(clk,rst,rd,wr, w_data,empty,full,r_data);

always
begin
clk=0;#10;
clk=1;#10;
end

initial
begin
rst=0;#10;
rst=1;#10;
rst=0;
wr=1;rd=0;w_data=8'hda;#20;

wr=1;w_data=8'h31;#20;
wr=1;w_data=8'h0e;#20;
wr=1;w_data=8'he1;#20;
wr=0;rd=1;#100;rd=0;
wr=1;w_data=8'h31;#20;
wr=1;w_data=8'h0e;#20;
wr=1;w_data=8'he1;#20;
#1000;$finish;
end
endmodule



