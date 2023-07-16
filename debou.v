module debou(input clk,rst,sw,output reg db);
parameter zero=3'b000,w1_1=3'b001,w1_2=3'b010,w1_3=3'b011,
	  one=3'b100,w0_1=3'b101,w0_2=3'b110,w0_3=3'b111,n=2;
reg [n-1:0] q=0;
wire [n-1:0] q_nxt;
wire check;
reg [2:0]ps,ns;
always@(posedge clk)
q <= q_nxt;

assign q_nxt = q+1;
assign check=(q==0)?1:0;

always@(posedge clk,posedge rst)
begin
  if(rst)
    ps<=zero;
  else
    ps<=ns;
end

always@*
begin
  ns=ps;
  db=0;
case(ps)
  zero:
     if(sw)
	ns=w1_1;
  w1_1:
     if(!sw)
	ns=zero;
     else if (check)
	ns=w1_2;
  w1_2:
     if(!sw)
	ns=zero;
     else if (check)
	ns=w1_3;
  w1_3:
     if(!sw)
	ns=zero;
     else if (check)
	ns=one;
  one:
    begin
      db=1;
	if(!sw)
	  ns=w0_1;
    end
  w0_1:
    begin
	db=1;
	if(sw)
	  ns=one;
	else if(check)
	  ns=w0_2;
    end
  w0_2:
    begin
	db=1;
	if(sw)
	  ns=one;
	else if(check)
	  ns=w0_3;
    end
  w0_3:
    begin
	db=1;
	if(sw)
	  ns=one;
	else if(check)
	  ns=zero;
    end
  endcase
end
endmodule
