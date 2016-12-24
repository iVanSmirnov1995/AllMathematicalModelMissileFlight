//
//  ISTest.m
//  UTSdz2v2
//
//  Created by Smirnov Ivan on 26.04.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//

#import "ISTest.h"
#import "ISLa.h"
#import "matrix.h"
#import "ISCel.h"

@interface ISTest()<ISlaDelegat>

@end

@implementation ISTest


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        ISLa* la=[[ISLa alloc]createLaM0:1450 Ix:170.f Iy:640.f Iz:640.f l:7.f dm:0.950 Kfi:1 Kpsi:1];
        la.delegat=self;
        ISCel* cel=[[ISCel alloc]init];
        cel.coordinat=ISVecrorMake(7000, 0, 500);
        la.cel=cel;
        la.delegat=self;
       [la startX0:0 H0:10400 vxo:1200 TT0:-55 shag:0.001];// 10600

        CGFloat osh= sqrt(pow(la.pointPad.z-cel.coordinat.z,2)+pow(la.pointPad.x-cel.coordinat.x,2));
        
        
        NSLog(@"x %f z %f ошибка %f",cel.coordinat.x,cel.coordinat.z,osh);
        NSLog(@"x %f z %f ошибка %f",la.pointPad.x,la.pointPad.z,osh);
        
//        
//        CGFloat hag=1000;
//        
//        for (CGFloat x=5630; x<90600; x=x+10) {
//            
//            CGFloat z=0;
//            BOOL stop=YES;
//            while (stop) {
//                
//                z=z+hag;
//            //    NSLog(@"%f %f",x,z);
//        ISLa* la=[[ISLa alloc]createLaM0:1450 Ix:170.f Iy:640.f Iz:640.f l:7.f dm:0.950 Kfi:1 Kpsi:1];
//        ISCel* cel=[[ISCel alloc]init];
//        cel.coordinat=ISVecrorMake(x, 0, z);
//        la.cel=cel;
//        la.delegat=self;
//        [la startX0:0 H0:10400 vxo:1200 TT0:-55 shag:0.001];
//                
//                CGFloat osh= sqrt(pow(la.pointPad.z-cel.coordinat.z,2)+pow(la.pointPad.x-cel.coordinat.x,2));
//                
//                
//        if (osh>4.99f) {
//            
//            if (osh>5.f) {
//                
//                z=z-hag;
//                hag=0.5*hag;
//                if (hag<0.001) {
//                    NSLog(@"x %f z %f",cel.coordinat.x,0.f);
//                    stop=NO;
//                     hag=1000;
//                }
//                
//                
//                
//            }else{
//            
//            NSLog(@"x %f z %f -z %f ошибка %f",cel.coordinat.x,cel.coordinat.z,-cel.coordinat.z,osh);
//            stop=NO;
//                hag=1000;
//            
//            }
//            
//        }
//        //10600
//            
//            }
//        }
        
    }
    return self;
}


-(void) parametrsdidSelected:(ISLa*)la{

//    NSLog(@"t %f x %f y %f alfa %f нак-тр %f тангаж %f wz %f v %f",la.t, la.coordinat.x,la.coordinat.y,la.anglesSKsvaz.x*180/M_PI,
//          la.TTandPsi.x*180/M_PI,la.anglesSVnorm.y*180/M_PI,la.w.z,VectorABS(la.vNormSist));
//    
    NSLog(@"x %f y %f z %f w %f ",la.coordinat.x,la.coordinat.y,la.coordinat.z,la.anglesSVnorm.z);
//    NSLog(@"t %f x %f y %f z %f рыс %f  тангаж %f  крен %f дельтаВ %f дельтаН %f альфа %f бета %f"
//          ,la.t,la.coordinat.x,la.coordinat.y,la.coordinat.z,la.anglesSVnorm.x,la.anglesSVnorm.y,la.anglesSVnorm.z,la.delta.y, la.delta.z,la.anglesSKsvaz.x,la.anglesSKsvaz.y);

    
    
}



@end
