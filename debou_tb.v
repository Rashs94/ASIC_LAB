module debou_tb();
reg clk,rst,sw;
wire db;
debou d1(clk,rst,sw,db);
always
begin
clk=0;#10;
clk=1;#10;
end

initial 
begin
rst=0;
#10;rst=1;
#10;rst=0; sw=0;
#10;sw=1;
#5;sw=0;
#5;sw=1;
#10;sw=0;
#30;sw=1;
#300;sw=0;
#10;sw=1;
#5;sw=0;
#5;sw=1;
#30;sw=0;
#1000; $finish;
end
endmodule
