//
//  AlbumCell.h
//  bigdemo
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlbumDelegate <NSObject>
-(void)didSelectedAlbumAtIndex:(NSInteger)index;
@end

@interface AlbumCell : UITableViewCell
@property(nonatomic, strong) NSArray *imgurlArray;/**< 图片URL */
@property(nonatomic, assign) id<AlbumDelegate> delegate;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;

@end
