//
//  ISCel.m
//  UTSdz2v2
//
//  Created by Smirnov Ivan on 30.10.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//

#import "ISCel.h"

@implementation ISCel



-(ISCel*)createCelX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z{
    
    ISCel* c=[[ISCel alloc]init];
    c.coordinat=ISVecrorMake(x, y, z);
    
    return self;
}

@end
