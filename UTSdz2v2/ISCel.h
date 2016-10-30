//
//  ISCel.h
//  UTSdz2v2
//
//  Created by Smirnov Ivan on 30.10.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "matrix.h"

@interface ISCel : NSObject

@property(assign,nonatomic)struct ISVector coordinat;

-(ISCel*)createCelX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z;

@end
