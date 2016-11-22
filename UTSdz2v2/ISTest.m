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
        
        ISLa* la=[[ISLa alloc]createLaM0:1450 Ix:170.f Iy:640.f Iz:640.f l:9 dm:0.950 Kfi:0 Kpsi:0];
        la.delegat=self;
        ISCel* cel=[[ISCel alloc]init];
        cel.coordinat=ISVecrorMake(5500, 0, 100);
        la.cel=cel;
        la.delegat=self;
        [la startX0:0 H0:9800 vxo:1200 TT0:-55 shag:0.001];

        CGFloat osh= sqrt(pow(la.pointPad.z-cel.coordinat.z,2)+pow(la.pointPad.x-cel.coordinat.x,2));
        
        
        NSLog(@"x %f z %f ошибка %f",cel.coordinat.x,cel.coordinat.z,osh);
        NSLog(@"x %f z %f ошибка %f",la.pointPad.x,la.pointPad.z,osh);
        
        
                

        
//        for (CGFloat x=6000; x<8000; x=x+10) {
//            
//            CGFloat z=0;
//            BOOL stop=YES;
//            while (stop) {
//                
//                z=z+1;
//            //    NSLog(@"%f %f",x,z);
//        ISLa* la=[[ISLa alloc]createLaM0:1450 Ix:170.f Iy:640.f Iz:640.f l:9 dm:0.950 Kfi:1 Kpsi:1];
//        ISCel* cel=[[ISCel alloc]init];
//        cel.coordinat=ISVecrorMake(x, 0, z);
//        la.cel=cel;
//        la.delegat=self;
//        [la startX0:0 H0:9100 vxo:1200 TT0:-55 shag:0.001];
//                
//                CGFloat osh= sqrt(pow(la.pointPad.z-cel.coordinat.z,2)+pow(la.pointPad.x-cel.coordinat.x,2));
//               // NSLog(@"тест %f",osh);
//        if (osh>5.f) {
//            
//            NSLog(@"x %f z %f ошибка %f",cel.coordinat.x,cel.coordinat.z,osh);
//            stop=NO;
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
//
//    NSLog(@"t %f x %f y %f alfa %f нак-тр %f тангаж %f wz %f v %f",la.t, la.coordinat.x,la.coordinat.y,la.anglesSKsvaz.x*180/M_PI,
//          la.TTandPsi.x*180/M_PI,la.anglesSVnorm.y*180/M_PI,la.w.z,VectorABS(la.vNormSist));
//    
//    NSLog(@"r %f fi %f ks %f ",la.r, la.lineVizAnrl.x*180/M_PI,la.lineVizAnrl.y);
  //  NSLog(@"x %f y %f z %f wz %f", la.coordinat.x,la.coordinat.y,la.coordinat.z,la.anglesSVnorm.z);
    
    //  VectorPrint(VectorMultiplyNumber(la.delta, 180/M_PI));
    
}

-(void)didEnd:(ISLa *)la{
    
    
    
}



@end
