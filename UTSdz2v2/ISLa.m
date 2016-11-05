//
//  ISLa.m
//  YTSdz2
//
//  Created by Smirnov Ivan on 10.04.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//

#import "ISLa.h"
#import "matrix.h"

@interface ISLa()



@end;

@implementation ISLa

const CGFloat g=9.80665;


-(instancetype)createLaM0:(CGFloat)m0 Ix:(CGFloat)Ix Iy:(CGFloat)Iy Iz:(CGFloat)Iz
                        l:(CGFloat)l dm:(CGFloat)dm{
    
    ISLa* la=[[ISLa alloc]init];
    la.m0=m0;
    la.I=ISVecrorMake(Ix, Iy, Iz);
    la.l=l;
    la.dm=dm;
    
    return la;
}


-(void)startX0:(CGFloat)x0 H0:(CGFloat)H0 vxo:(CGFloat)v0 TT0:(CGFloat)TT0 shag:(CGFloat)dt{
    
    self.anglesSVnorm=ISVecrorMake(0, 0, 0);
    self.vSkorSist=ISVecrorMake(v0, 0, 0);
    struct ISMartix3 matPerSKsv=[self matPerSKsv:self.anglesSKsvaz];
    self.coordinat=ISVecrorMake(0, H0, 0);
    self.anglesSVnorm=ISVecrorMake(0, (M_PI/180)*TT0, 0);
    self.w=ISVecrorMake(0, 0, 0);
    self.t=0.f;
    struct ISMartix3 matPerSvNorm=[self matPerSvNorm:self.anglesSVnorm];
    self.vNormSist=Martix3multiplyVector(matPerSvNorm, Martix3multiplyVector(matPerSKsv, self.vSkorSist));
    
    self.radrigaGm=[self radrigoGameltonInitAngle:self.anglesSVnorm];
    self.radrigaGm=Vector4Normir(self.radrigaGm);
    
     [self.delegat parametrsdidSelected:self];
    
    while (self.coordinat.y>0) {
        
        struct ISVector dv=VectorMultiplyNumber([self translationalMovie], dt);
        struct ISVector dw =VectorMultiplyNumber([self rotaryMovie], dt);
        struct ISVector dr =VectorMultiplyNumber([self coordinats], dt);
        struct ISVector4 dRg=Vector4MultiplyNumber([self dRadrigoGamelton], dt);
        
        struct ISVector oldVizAnrl=[self solveLinVizAngl];
        
        self.vNormSist=VectorPlusVector(self.vNormSist, dv);
        self.w=VectorPlusVector(self.w, dw);
        self.coordinat=VectorPlusVector(self.coordinat, dr);
        self.radrigaGm=[self radrigoGameltonInitAngle:self.anglesSVnorm];
        self.radrigaGm=Vector4PlusVector4(self.radrigaGm, dRg);
        self.radrigaGm=Vector4Normir(self.radrigaGm);
        struct ISVector dSVvNormDt=VectorMultiplyNumber(VectorMinVector([self angleByRG:self.radrigaGm],self.anglesSVnorm),1/dt);
        
        self.anglesSVnorm=[self angleByRG:self.radrigaGm];
        
        self.TTandPsi=ISVecrorMake(asin(self.vNormSist.y/VectorABS(self.vNormSist)),
                                              atan(self.vNormSist.z/self.vNormSist.x), 0);
        
        self.t=self.t+dt;
        
        self.r=pow(pow(self.cel.coordinat.x-self.coordinat.x, 2)+
                   pow(self.cel.coordinat.y-self.coordinat.y, 2)+
                   pow(self.cel.coordinat.z-self.coordinat.z, 2), 0.5f);
        
        struct ISVector newVizAnrl=[self solveLinVizAngl];

        
        
        struct ISVector dLinAngDt=VectorMultiplyNumber(VectorMinVector(newVizAnrl, oldVizAnrl), 1/dt);
        
        
        
        
        
#pragma mark-rasch abc
        CGFloat a11=-(self.mW.z*self.l)/(self.I.z*VectorABS(self.vNormSist));
        CGFloat a12=-(self.mZ_angle.x)/(self.I.z);
        CGFloat a13=-(self.mZ_delta.x)/(self.I.z);//?
        CGFloat a42=(self.Y_angle.x)/(self.m0*VectorABS(self.vNormSist));
        CGFloat a43=(self.Y_delta.x)/(self.m0*VectorABS(self.vNormSist));
        
        CGFloat b11=-(self.mW.y*self.l)/(self.I.y*VectorABS(self.vNormSist));
        CGFloat b12=-(self.mZ_angle.y)/(self.I.y);
        CGFloat b13=-(self.mZ_delta.y)/(self.I.y);//?
        CGFloat b42=(self.Y_angle.y)/(self.m0*VectorABS(self.vNormSist));
        CGFloat b43=(self.Y_delta.y)/(self.m0*VectorABS(self.vNormSist));
        
        CGFloat Kv=(a11*a43-a13*a42)/(a12+a11*a42);
        CGFloat Kn=(b11*b43-b13*b42)/(b12+b11*b42);
        CGFloat kccV=0.95;
        CGFloat kccn=0.95;
        
       // NSLog(@"%f %f",Kn,Kv);
       // VectorPrint(dLinAngDt);
       // VectorPrint(dSVvNormDt);
        
        self.delta=ISVecrorMake(0,Kv*dLinAngDt.x+kccV*dSVvNormDt.y,
                                Kn*dLinAngDt.y+kccn*dSVvNormDt.x);
       // NSLog(@"%f %f",self.delta.y*180/M_PI,self.delta.z*180/M_PI);
       // NSLog(@"%f",dLinAngDt.y);
        [self.delegat parametrsdidSelected:self];
        
    }
    
}


-(struct ISVector) translationalMovie

{
    CGFloat v=VectorABS(self.vNormSist);
    CGFloat M=v/[[[ISTabl alloc]h:self.coordinat.y type:geomertrik] a];
    
    CGFloat Cx=1.0/(73.211/exp(M)- 47.483/M + 16.878);
    CGFloat Ds=1.86*(11.554/exp(M) - 2.5191e-3*M*M - 5.024/M + 52.836e-3*M +4.112);
    CGFloat Cy_alfa;
    if(Ds>=0)
        Cy_alfa= sqrt(Ds);
    else
        Cy_alfa=1.86*1.039;
    
    struct ISMartix3 matPerSvNorm=[self matPerSvNorm:self.anglesSVnorm];
    struct ISVector vSVsist=Martix3multiplyVector(Martix3Transp(matPerSvNorm), self.vNormSist);
    self.anglesSKsvaz=ISVecrorMake(-atan(vSVsist.y/vSVsist.x),asin(vSVsist.z/VectorABS(vSVsist)), 0);
    struct ISVector C=ISVecrorMake(Cx,
                                   Cy_alfa*self.anglesSKsvaz.x+[self Cy_deltaM:M alfa:self.anglesSKsvaz.x]*self.delta.y,
                                   -Cy_alfa*self.anglesSKsvaz.y+[self Cz_deltaM:M alfa:self.anglesSKsvaz.y]*self.delta.z);
    
    
    CGFloat ro=[[[ISTabl alloc]h:self.coordinat.y type:geomertrik] ro];
    CGFloat sm=M_PI*pow(self.dm, 2)/4;
    CGFloat q=ro*pow(v, 2)/2;
    
    CGFloat y_alfa=Cy_alfa*q*sm;
    CGFloat y_beta=-Cy_alfa*q*sm;
    CGFloat y_deltaV=[self Cy_deltaM:M alfa:self.anglesSKsvaz.x]*q*sm;
    CGFloat y_deltaN=[self Cz_deltaM:M alfa:self.anglesSKsvaz.y]*q*sm;
    
    
    
    struct ISVector F=ISVecrorMake(-C.x*q*sm, C.y*q*sm, C.z*q*sm);
    
    struct ISVector Gg=ISVecrorMake(0, -g*self.m0, 0);
    struct ISVector Fg=Martix3multiplyVector(matPerSvNorm, F);
    struct ISVector vItog=VectorMultiplyNumber(VectorPlusVector(Fg, Gg), 1/self.m0);
    
   // self.Y_angle=ISVecrorMake(F.y/self.anglesSKsvaz.x,F.y/self.anglesSKsvaz.y,0);
    self.Y_angle=ISVecrorMake(y_alfa,y_beta,0);
   // self.Y_delta=ISVecrorMake(F.y/self.delta.z,F.y/self.delta.y,0);
     self.Y_delta=ISVecrorMake(y_deltaV,y_deltaN,0);
    
    return vItog;
    
}

-(struct ISVector) rotaryMovie

{
    
    CGFloat v=VectorABS(self.vNormSist);
    CGFloat Max=v/[[[ISTabl alloc]h:self.coordinat.y type:geomertrik] a];
    CGFloat Mx_wx=-0.005*0.6786;
    CGFloat Mz_wz=1.89*(146.79e-6*Max*Max - 158.98e-3/Max - 7.6396e-3*Max - 68.195e-3);
    CGFloat Mz_alf=(-766.79e-3/exp(Max) + 438.74e-3/Max + 5.8822e-3*Max - 158.34e-3);
    CGFloat My_beta=Mz_alf;
    
    struct ISVector mW=ISVecrorMake(Mx_wx, Mz_wz, Mz_wz);
    self.mW=mW;
    self.mZ_angle=ISVecrorMake(Mz_alf, My_beta, 0);
    self.mZ_delta=ISVecrorMake([self My_deltaM:Max betta:self.anglesSKsvaz.y],
                               [self Mz_deltaM:Max alfa:self.anglesSKsvaz.x],
                               0);
    
    CGFloat mx=(mW.x*_l/v)*self.w.x;
    CGFloat my=(mW.y*_l/v)*self.w.y+My_beta*self.anglesSKsvaz.y+[self My_deltaM:Max betta:self.anglesSKsvaz.y]*self.delta.z;//?
    CGFloat mz=(mW.z*_l/v)*self.w.z+Mz_alf*self.anglesSKsvaz.x+[self Mz_deltaM:Max alfa:self.anglesSKsvaz.x]*self.delta.y;
    
    struct ISVector m=ISVecrorMake(mx, my, mz);
    CGFloat ro=[[[ISTabl alloc]h:self.coordinat.y type:geomertrik] ro];
    CGFloat sm=M_PI*pow(self.dm, 2)/4;
    CGFloat q=ro*pow(v, 2)/2;
    struct ISVector M=VectorMultiplyNumber(m, q*sm);
    CGFloat dWxDt=M.x/_I.x-((_I.z-_I.y)/_I.x)*_w.y*_w.z;
    CGFloat dWyDt=M.y/_I.y-((_I.x-_I.z)/_I.y)*_w.x*_w.z;
    CGFloat dWzDt=M.z/_I.z-((_I.y-_I.x)/_I.z)*_w.y*_w.x;
    
    struct ISVector vItog=ISVecrorMake(dWxDt,dWyDt, dWzDt);

    return vItog;
    
}

-(struct ISVector) coordinats

{
    struct ISVector vItog=ISVecrorMake(_vNormSist.x,_vNormSist.y,_vNormSist.z);
    return vItog;
    
}


-(struct ISVector4) dRadrigoGamelton

{
        CGFloat dPrgDt=-(_w.x*_radrigaGm.x2+_w.y*_radrigaGm.x3+_w.z*_radrigaGm.x4)/2;
        CGFloat dLambdaRgDt=(_w.x*_radrigaGm.x1-_w.y*_radrigaGm.x4+_w.z*_radrigaGm.x3)/2;
        CGFloat dMuRgDt=(_w.x*_radrigaGm.x4-_w.y*_radrigaGm.x1-_w.z*_radrigaGm.x2)/2;
        CGFloat dNuRgDt=(-_w.x*_radrigaGm.x3+_w.y*_radrigaGm.x2+_w.z*_radrigaGm.x1)/2;
        struct ISVector4 vItog=ISVecror4Make(dPrgDt, dLambdaRgDt, dMuRgDt, dNuRgDt);
    
    return vItog;
    
}



-(struct ISVector4) radrigoGameltonInitAngle:(struct ISVector)v

{
    
    struct ISVector4 vItog=ISVecror4Make(cosl(v.x/2)*cosl(v.y/2)*cosl(v.z/2)+
                                 sinl(v.x/2)*sinl(v.y/2)*sinl(v.z/2),
                                -sinl(v.x/2)*sinl(v.y/2)*cosl(v.z/2)+
                                 cosl(v.x/2)*cosl(v.y/2)*sinl(v.z/2),
                                 sinl(v.x/2)*cosl(v.y/2)*cosl(v.z/2)+
                                 cosl(v.x/2)*sinl(v.y/2)*sinl(v.z/2),
                                 cosl(v.x/2)*sinl(v.y/2)*cosl(v.z/2)-
                                 sinl(v.x/2)*cosl(v.y/2)*sinl(v.z/2));
    
    return vItog;
    
}


-(struct ISVector) solveLinVizAngl

{
    
    CGFloat r=pow(pow(self.cel.coordinat.x-self.coordinat.x, 2)+
                  pow(self.cel.coordinat.y-self.coordinat.y, 2)+
                  pow(self.cel.coordinat.z-self.coordinat.z, 2), 0.5f);
    struct ISVector vItog=ISVecrorMake(asin((self.cel.coordinat.y-self.coordinat.y)/r),
                                            -atan((self.cel.coordinat.z-self.coordinat.z)/r), 0);
    
    
    return vItog;
    
}


-(struct ISVector) angleByRG:(struct ISVector4)v

{
    
    struct ISVector vItog=ISVecrorMake(atanl(2*(v.x1*v.x3-v.x2*v.x4)/(pow(v.x1, 2)+pow(v.x2, 2)-pow(v.x3, 2)-pow(v.x4, 2))),
                                        asinl(2*(v.x1*v.x4+v.x2*v.x3)),
                                        atanl(2*(v.x1*v.x2-v.x4*v.x3)/(pow(v.x1, 2)+pow(v.x3, 2)-pow(v.x2, 2)-pow(v.x4, 2))));
    
    return vItog;
    
}


-(struct ISMartix3)matPerSKsv:(struct ISVector)v{
    
    struct ISMartix3 matPerSKsv;
    matPerSKsv.info[0][0]=cosl(v.x)*cosl(v.y);
    matPerSKsv.info[0][1]=sinl(v.x);
    matPerSKsv.info[0][2]=-cosl(v.x)*sinl(v.y);
    matPerSKsv.info[1][0]=-sinl(v.x)*cosl(v.y);
    matPerSKsv.info[1][1]=cosl(v.x);
    matPerSKsv.info[1][2]=sinl(v.x)*sinl(v.y);
    matPerSKsv.info[2][0]=sinl(v.y);
    matPerSKsv.info[2][1]=0.f;
    matPerSKsv.info[2][2]=cosl(v.y);
    
    return matPerSKsv;
}

-(struct ISMartix3)matPerSvNorm:(struct ISVector)v{
    
    struct ISMartix3 matPerSvNorm;
    matPerSvNorm.info[0][0]=cosl(v.y)*cosl(v.x);
    matPerSvNorm.info[0][1]=-sinl(v.y)*cosl(v.x)*cosl(v.z)+sinl(v.x)*sinl(v.z);
    matPerSvNorm.info[0][2]=sinl(v.y)*cosl(v.x)*sinl(v.z)+sinl(v.x)*cosl(v.z);
    matPerSvNorm.info[1][0]=sinl(v.y);
    matPerSvNorm.info[1][1]=cosl(v.y)*cosl(v.z);
    matPerSvNorm.info[1][2]=-cosl(v.y)*sinl(v.z);
    matPerSvNorm.info[2][0]=-cosl(v.y)*sinl(v.x);
    matPerSvNorm.info[2][1]=sinl(v.y)*sinl(v.x)*cosl(v.z)+cosl(v.x)*sinl(v.z);
    matPerSvNorm.info[2][2]=-sinl(v.y)*sinl(v.x)*sinl(v.z)+cosl(v.x)*cosl(v.z);
    
    return matPerSvNorm;
}


#pragma mark-Aerodynamics

-(CGFloat)Mz_deltaM:(CGFloat)M alfa:(CGFloat)alfa
{
	   CGFloat k1 = 0.0, k2 = 0.0;
	   alfa = fabs(alfa*180/M_PI);
	   k1 = exp(-19.488e-3*alfa*alfa - 378.62e-3*alfa + 6.7518);
	   k2 = exp(-21.234e-3*alfa*alfa - 635.84e-6*exp(alfa) - 98.296e-3*alfa + 2.5938);
	   return 1.89*sqrt(k1*1e-9*M*M + k2*1e-6);
};


-(CGFloat)My_deltaM:(CGFloat)M betta:(CGFloat)alfa
{
    return [self Mz_deltaM:M alfa:alfa];
};


-(CGFloat)Cy_deltaM:(CGFloat)M alfa:(CGFloat)alfa
{
	   CGFloat p1 = 0.0, p2 = 0.0, p3 = 0.0, p4 = 0.0;
	   alfa = fabs(alfa*180/M_PI);
	   p1 =  1/(243.84e-3/exp(alfa) + 74.309e-3);
	   p2 =  log(1.9773*alfa*alfa - 25.587*alfa + 83.354);
	   p3 =  18.985*alfa*alfa - 375.76*alfa + 1471;
	   p4 = -51.164e-3*alfa*alfa + 805.52e-3*alfa + 1.8929;
	   return (-p1*1e-6*M*M + p2*1e-12*exp(M) - p3*1e-6*M - p4*1e-3)*2;
};


-(CGFloat)Cz_deltaM:(CGFloat)M alfa:(CGFloat)alfa
{
    return -[self Cy_deltaM:M alfa:alfa];
};


@end
