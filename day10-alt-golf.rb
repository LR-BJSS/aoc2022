x,c,s=1,0,0;File.readlines('./input/day10-input.txt').each\
{_,a=_1.split;2.times{print (c%40-x).abs<2?"█":"░";c+=1;s+=c*x\
if(c-20)%40==0;puts if c%40==0;!a&&break};x+=a.to_i};p s