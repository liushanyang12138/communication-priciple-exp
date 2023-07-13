function [f,sf] = ideal_bandpassing(f,sf,fl,fh)
    x=size(f,2);
    i=1;
    while i<x+1
        if (-fh<=f(i) &&f(i)<=-fl)||(fl<=f(i) &&f(i)<=fh)
            sf(i)=sf(i);
        else 
            sf(i)=0;
        end
        i=i+1;
    end   
 end 
    

