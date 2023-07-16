module fib(input clk,rst,start,input [4:0]i,output reg ready,done,output [19:0]f);
parameter a=2'b00,b=2'b01,c=2'b10;
reg [1:0] ns,ps;
reg [19:0] t0,t1,t0_nxt,t1_nxt;
reg [4:0]n,n_nxt;

always@(posedge clk,posedge rst)
begin
    if(rst)
	begin
	ps<=a;
	t0<=0;
	t1<=0;
	n<=0;
	end
     else
	begin
	ps<=ns;
	t0<=t0_nxt;
	t1<=t1_nxt;
	n<=n_nxt;
	end
end
always@*
begin
ns=ps;
done=0;
ready=0;
t0_nxt=t0;
t1_nxt=t1;
n_nxt=n;
  case(ps)
  a:begin
    ready=1;
    if(start)
       begin
       t0_nxt=0;
       t1_nxt=1;
       n_nxt=i;
       ns=b;
       end
     end

  b:begin
    if(n==0)
      begin
        t1_nxt=0;
        ns=c;
      end
     else if(n==1)
      ns=c;
     else
       begin
         t1_nxt=t1+t0;
         t0_nxt=t1;
	 n_nxt=n-1;
	end
      end
   c:begin
       done=1;
       ns=a;
     end
    default:ns=a;
   endcase
end
assign f=t1;
endmodule
