module fib_tb();
reg clk,rst,start;
reg [4:0]i;
wire ready,done;
wire [19:0]f;
fib f1(clk,rst,start,i,ready,done,f);
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
start=1;i=12;
#2000; $finish;
end
endmodule

