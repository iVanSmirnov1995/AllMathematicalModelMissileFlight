//
//  ISTabl.h
//  dz6sem
//
//  Created by Smirnov Ivan on 01.03.15.
//  Copyright (c) 2015 Ivan Smirnov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ISTabl : NSObject

typedef enum{
 geomertrik=YES,
 geopotensial=NO
    
}typeHight;

@property(assign,nonatomic)CGFloat T;
@property(assign,nonatomic)CGFloat P;
@property(assign,nonatomic)CGFloat ro;
@property(assign,nonatomic)CGFloat a;
@property(assign,nonatomic)CGFloat my;
@property(assign,nonatomic)CGFloat ny;




-(ISTabl*) h:(CGFloat)h type:(typeHight)type ;


@end
