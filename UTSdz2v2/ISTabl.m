//
//  ISTabl.m
//  dz6sem
//
//  Created by Smirnov Ivan on 01.03.15.
//  Copyright (c) 2015 Ivan Smirnov. All rights reserved.
//

#import "ISTabl.h"

@implementation ISTabl

-(ISTabl*) h:(CGFloat)H type:(typeHight)type
{
    CGFloat Rz=6356767;
    if (type) {
        H=Rz*H/(Rz+H);
    }
    
    CGFloat P11,ro,T11,betta,H11,P,a,my,ny;
    if ((H>=-2*pow(10, 3))&(H<0*pow(10, 3)))
       {P11=127774;betta=-6.5*pow(10, -3);T11=301.15;H11=-2*pow(10, 3);}
    if ((H>=0*pow(10, 3))&(H<11*pow(10, 3)))
       {P11=101325;betta=-6.5*pow(10, -3);T11=288.15;H11=0*pow(10, 3);}
    if ((H>=11*pow(10, 3))&(H<20*pow(10, 3)))
        {P11=22632;betta=0*pow(10, -3);T11=216.65;H11=11*pow(10, 3);}
    if ((H>=20*pow(10, 3))&(H<32*pow(10, 3)))
        {P11=5474.87;betta=1*pow(10, -3);T11=216.65;H11=20*pow(10, 3);}
    if ((H>=32*pow(10, 3))&(H<47*pow(10, 3)))
        {P11=868.014;betta=2.8*pow(10, -3);T11=228.65;H11=32*pow(10, 3);}
    if ((H>=47*pow(10, 3))&(H<51*pow(10, 3)))
        {P11=110.906;betta=0*pow(10, -3);T11=270.65;H11=47*pow(10, 3);}
    if ((H>=51*pow(10, 3))&(H<71*pow(10, 3)))
        {P11=66.9384;betta=-2.8*pow(10, -3);T11=270.65;H11=51*pow(10, 3);}
    if ((H>=71*pow(10, 3))&(H<85*pow(10, 3)))
        {P11=3.95639;betta=-2*pow(10, -3);T11=214.65;H11=71*pow(10, 3);}
    if (H>=85*pow(10, 3))
    {P11=0.36341;betta=0*pow(10, -3);T11=186.65;H11=85*pow(10, 3);}
    
    
    CGFloat S=110.4;
    CGFloat bettaS=1.458*pow(10, -6);
    CGFloat ksi=1.4;
    CGFloat gc=9.80665;
    CGFloat R=287.05287;
    CGFloat T=T11+betta*(H-H11);
    if (betta==0) {
        P=P11*pow(M_E, -gc*(H-H11)/(R*T));
    }else{
        P=P11*pow(1+betta*(H-H11)/T11, -gc/(R*betta));
    }
    
    ro=P/(R*T);
    a=20.046796*pow(T, 0.5);
    my=bettaS*pow(T, 3.f/2.f)/(T+S);
    ny=my/ro;
    
    
    self.P=P;self.T=T;self.ro=ro;self.a=a;self.my=my;self.ny=ny;

    return self;
    
}


@end
