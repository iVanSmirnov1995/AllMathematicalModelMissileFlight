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
        
//        ISLa* la=[[ISLa alloc]createLaM0:1450 Ix:170.f Iy:640.f Iz:640.f l:9 dm:0.950];
//        la.delegat=self;
//        
//        [la startX0:0 H0:9100 vxo:1200 TT0:-55 shag:0.01];
        ISLa* la=[[ISLa alloc]createLaM0:1450 Ix:170.f Iy:640.f Iz:640.f l:9 dm:0.950];
        ISCel* cel=[[ISCel alloc]createCelX:20000 y:0 z:0];
        la.cel=cel;
        la.delegat=self;
        
        [la startX0:0 H0:9200 vxo:1000 TT0:-55 shag:0.01];
        //10600
        
    }
    return self;
}


-(void) parametrsdidSelected:(ISLa*)la{
//
 //   NSLog(@"t %f x %f y %f alfa %f нак-тр %f тангаж %f wz %f v %f",la.t, la.coordinat.x,la.coordinat.y,la.anglesSKsvaz.x*180/M_PI,
 //         la.TTandPsi.x*180/M_PI,la.anglesSVnorm.y*180/M_PI,la.w.z,VectorABS(la.vNormSist));
    
    NSLog(@"r %f fi %f ks %f ",la.r, la.lineVizAnrl.x*180/M_PI,la.lineVizAnrl.y);
    
}



@end
