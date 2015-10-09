//
//  NSString+Size.m
//  bigdemo
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
-(CGSize)boundingRectWithSize:(CGSize)size withFont:(NSInteger)font
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize retSize = [self boundingRectWithSize:size options:     NSStringDrawingTruncatesLastVisibleLine |
        NSStringDrawingUsesLineFragmentOrigin|
        NSStringDrawingUsesFontLeading
                                     attributes:attribute context:nil].size;
    return retSize;
}


@end
