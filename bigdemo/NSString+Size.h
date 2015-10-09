//
//  NSString+Size.h
//  bigdemo
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
-(CGSize)boundingRectWithSize:(CGSize) size withFont:(NSInteger)font;
@end
