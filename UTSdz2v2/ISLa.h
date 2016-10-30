//
//  ISLa.h
//  YTSdz2
//
//  Created by Smirnov Ivan on 10.04.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "matrix.h"
#import "ISTabl.h"
#import "ISCel.h"

@protocol ISlaDelegat;
@interface ISLa : NSObject

@property(weak,nonatomic) id <ISlaDelegat> delegat;



-(ISLa*)createLaM0:(CGFloat)m0 Ix:(CGFloat)Ix Iy:(CGFloat)Iy Iz:(CGFloat)Iz
                        l:(CGFloat)l dm:(CGFloat)dm;

@property(strong,nonatomic)ISCel* cel;

@property(assign,nonatomic)CGFloat m0;
@property(assign,nonatomic)struct ISVector I;
@property(assign,nonatomic)CGFloat l;
@property(assign,nonatomic)CGFloat dm;

@property(assign,nonatomic)struct ISVector coordinat;
@property(assign,nonatomic)struct ISVector anglesSVnorm;
@property(assign,nonatomic)struct ISVector w;
@property(assign,nonatomic)struct ISVector4 radrigaGm;
@property(assign,nonatomic)struct ISVector anglesSKsvaz;
@property(assign,nonatomic)struct ISVector vSkorSist;

@property(assign,nonatomic)struct ISMartix3 matPerSvNorm;
@property(assign,nonatomic)struct ISVector vNormSist;
@property(assign,nonatomic)struct ISVector  TTandPsi;
@property(assign,nonatomic)CGFloat t;


@property(assign,nonatomic)struct ISVector delta;
@property(assign,nonatomic)struct ISVector lineVizAnrl;
@property(assign,nonatomic)CGFloat r;
@property(assign,nonatomic)struct ISVector kSS;
@property(assign,nonatomic)struct ISVector kn;
@property(assign,nonatomic)struct ISVector mW;
@property(assign,nonatomic)struct ISVector mZ_angle;
@property(assign,nonatomic)struct ISVector mZ_delta;



-(void)startX0:(CGFloat)x0 H0:(CGFloat)H0 vxo:(CGFloat)v0 TT0:(CGFloat)TT0 shag:(CGFloat)dt;

@end


@protocol ISlaDelegat
@required

-(void) parametrsdidSelected:(ISLa*)la;

@end
