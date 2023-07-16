module div(clk,rst,start,dvsr,dvnd,ready,done,quo,rmd);
parameter w=4,c1=3;
input clk,rst,start;input [w-1:0]dvsr,dvnd;output reg ready,done;output [w-1:0]quo,rmd;
parameter a=2'b00,b=2'b01,c=2'b10,d1=2'b11;
reg [1:0] ps,ns;
reg [w-1:0] rh, rh_nxt,rl,rl_nxt,rh_tmp,d_nxt,d;
reg [c1-1:0] n,n_nxt;
reg q;
always @(posedge clk,posedge rst)
begin
  if(rst)
   begin
   ps <= a;
   rh <= 0;
   rl <=0;
   d <= 0;
   n <=0;
   end
  else 
   begin
   ps <= ns;
   rh <= rh_nxt;
   rl <= rl_nxt;
   d<=d_nxt;
   n<=n_nxt;
   end
end
always @ *
begin
ns=ps;
done=0;
ready=0;
rh_nxt=rh;
rl_nxt=rl;
d_nxt=d;
n_nxt=n;
case(ps)
a:begin
  ready=1;
  if(start)
  begin
    rh_nxt=0;
    rl_nxt=dvnd;
    d_nxt=dvsr;
    n_nxt=w+2;
    ns=b;
  end
end

b:begin
  if(rh>=d)
     begin
     rh_tmp=rh-d;
     q=1;
     end
  else
     begin
     rh_tmp=rh;
     q=0;
     end
  rl_nxt={rl[w-2:0],q};
  rh_nxt={rh_tmp[w-2:0],rl[w-1]};
  n_nxt=n-1;
  if(n_nxt==1)
    ns=c;
  end

c:begin
  rh_nxt=rh_tmp;
  ns=d1;
  end
d1:begin
  done=1;
  ns=a;
  end
endcase
end
assign quo=rl;
assign rmd=rh;
endmodule
