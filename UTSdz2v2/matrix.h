//
//  matrix.h
//  YTSdz2
//
//  Created by Smirnov Ivan on 09.04.16.
//  Copyright © 2016 Ivan Smirnov. All rights reserved.
//




#ifndef matrix_h
#define matrix_h



struct ISVector2 {
    CGFloat x1;
    CGFloat x2;
};

struct ISVector {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};


struct ISVector4 {
    CGFloat x1;
    CGFloat x2;
    CGFloat x3;
    CGFloat x4;
};

struct ISMartix3 {
    CGFloat info[3][3];
};

CG_INLINE void MatrPrint(struct ISMartix3 m);
CG_INLINE struct ISVector ISVecrorMake(CGFloat x,CGFloat y, CGFloat z);
CG_INLINE struct ISVector4 ISVecror4Make(CGFloat x1,CGFloat x2, CGFloat x3,CGFloat x4);
CG_INLINE struct ISMartix3 ISMartix3Make(CGFloat x,CGFloat y, CGFloat z);
CG_INLINE struct ISVector Martix3multiplyVector(struct ISMartix3 m,struct ISVector v);
CG_INLINE struct ISMartix3 Martix3Transp(struct ISMartix3 m);
CG_INLINE CGFloat VectorABS(struct ISVector v);
CG_INLINE struct ISVector VectorPlusVector(struct ISVector v1,struct ISVector v2);
CG_INLINE struct ISVector4 Vector4PlusVector4(struct ISVector4 v1,struct ISVector4 v2);
CG_INLINE struct ISVector VectorMultiplyNumber(struct ISVector v,CGFloat x);
CG_INLINE void VectorPrint(struct ISVector v);
CG_INLINE void Vector4Print(struct ISVector4 v);
CG_INLINE struct ISVector4 Vector4MultiplyNumber(struct ISVector4 v,CGFloat x);
CG_INLINE CGFloat Vector4ABS(struct ISVector4 v);
CG_INLINE struct ISVector4 Vector4Normir(struct ISVector4 v);


struct ISVector4 Vector4PlusVector4(struct ISVector4 v1,struct ISVector4 v2){
    
    struct ISVector4 itog;
    itog.x1=v1.x1+v2.x1;
    itog.x2=v1.x2+v2.x2;
    itog.x3=v1.x3+v2.x3;
    itog.x4=v1.x4+v2.x4;
    
    return itog;
}

struct ISVector ISVecrorMake(CGFloat x,CGFloat y, CGFloat z){
    
    struct ISVector v;
    v.x=x;
    v.y=y;
    v.z=z;
    return v;
}

CGFloat VectorABS(struct ISVector v){
    
     
    return sqrt(pow(v.x, 2)+pow(v.y, 2)+pow(v.z, 2));
    
}


struct ISVector4 ISVecror4Make(CGFloat x1,CGFloat x2, CGFloat x3,CGFloat x4){
    
    struct ISVector4 v;
    v.x1=x1;
    v.x2=x2;
    v.x3=x3;
    v.x4=x4;
    
    return v;
}

struct ISMartix3 ISMartix3Make(CGFloat x,CGFloat y, CGFloat z){
    
    struct ISMartix3 m;
    return m;
}


 void MatrPrint(struct ISMartix3 m){
    
     for (int i=0; i<3; i++) {
         
         NSMutableString* s=[NSMutableString string];
         for (int j=0; j<3; j++) {
             
             [s appendString:[NSString stringWithFormat:@" %.2f",m.info[i][j]]];
         }
         
         NSLog(@"%@",s);
         s=[NSMutableString string];
     }
}


struct ISVector Martix3multiplyVector(struct ISMartix3 m,struct ISVector v){
    
    CGFloat vec[]={v.x,v.y,v.z};
    CGFloat vec2[3];
    for (int i=0; i<3; i++) {
        
         CGFloat x=0;
         for (int j=0; j<3; j++) {
             
        x=m.info[i][j]*vec[j]+x;
         }
        vec2[i]=x;
    }
    struct ISVector finVect;
    finVect.x=vec2[0];
    finVect.y=vec2[1];
    finVect.z=vec2[2];
    return finVect;
}


struct ISMartix3 Martix3Transp(struct ISMartix3 m){
    
    struct ISMartix3 finMat;
    for (int i=0; i<3; i++) {
        
        for (int j=0; j<3; j++) {
            finMat.info[j][i] =m.info[i][j];
            
        }
    }
    
    return finMat;
}



struct ISVector VectorPlusVector(struct ISVector v1,struct ISVector v2){
 
    struct ISVector finVect;
    finVect.x=v1.x+v2.x;
    finVect.y=v1.y+v2.y;
    finVect.z=v1.z+v2.z;
    
    return finVect;
}

struct ISVector VectorMultiplyNumber(struct ISVector v,CGFloat x){
    
    struct ISVector finVect;
    finVect.x=v.x*x;
    finVect.y=v.y*x;
    finVect.z=v.z*x;
    
    return finVect;
}


 void VectorPrint(struct ISVector v){
    
    NSLog(@"x= %f y= %f z= %f",v.x,v.y,v.z);
}

void Vector4Print(struct ISVector4 v){
    
    NSLog(@"x1=%f x2=%f x3= %f x4= %f",v.x1,v.x2,v.x3,v.x4);
}

struct ISVector4 Vector4MultiplyNumber(struct ISVector4 v,CGFloat x){
    
    struct ISVector4 finVect;
    finVect.x1=v.x1*x;
    finVect.x2=v.x2*x;
    finVect.x3=v.x3*x;
    finVect.x4=v.x4*x;
    
    return finVect;
}

struct ISVector4 Vector4Normir(struct ISVector4 v){
    
    struct ISVector4 finVect;
    finVect.x1=v.x1/Vector4ABS(v);
    finVect.x2=v.x2/Vector4ABS(v);
    finVect.x3=v.x3/Vector4ABS(v);
    finVect.x4=v.x4/Vector4ABS(v);
    
    return finVect;
}


CGFloat Vector4ABS(struct ISVector4 v){
    
    
    return pow(pow(v.x1, 2)+pow(v.x2, 2)+pow(v.x3, 2)+pow(v.x4, 2),0.5);
    
}


#endif /* matrix_h */


