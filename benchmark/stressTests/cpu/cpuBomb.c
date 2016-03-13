#include "stdio.h" 
int main(){int i,j,l,k,m,jj;jj=2342;
k= 31455;l= 16452;m= 9823;while(1)
{ m = m^l;k = (k/m * jj) % i; l=j*m*k;
i = (j * k)^m ;k = (k/m * jj) % i;m = m^l;
m = m^l;i = (j * k)^m ;k = (k/m * jj) % i;
m=i*i*i*i*i*i*i;// m=k*l*jj*l;
m = m^l;k = (k/m * jj) % i;l=j*m*k;i = (j * k)^m ;
l = (k/m * jj) % i;m = m^l;m = m^l;i = (j * k)^m ;
k = (k/m * jj) % i; m=k*k*k*k*k - m/i; 
}}
