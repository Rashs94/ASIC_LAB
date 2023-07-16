module div_tb();
parameter w=4;
reg clk,rst,start;
reg [w-1:0] dvsr,dvnd;
wire ready,done;
wire [w-1:0]quo,rmd;
div d1(clk,rst,start,dvsr,dvnd,ready,done,quo,rmd);
always
begin
clk=0;#25;
clk=1;#25;
end
initial
begin
rst=0;#50;
rst=1;#50;
rst=0;#50;
start=1;dvsr=5;dvnd=15;#375;
dvsr=6;dvnd=10;#375;
dvsr=8;dvnd=15;
#2000; $finish;
end
endmodule

