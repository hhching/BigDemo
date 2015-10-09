//
//  AlbumListModel.h
//  bigdemo
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumListModel : NSObject
@property(nonatomic, strong) NSString *AlbumID;
@property(nonatomic, strong) NSString *Title;
@property(nonatomic, strong) NSString *PhotoURL;
@property(nonatomic, strong) NSString *Sort;
@property(nonatomic, strong) NSString *message;

@property(nonatomic, strong) NSString *IphoneType;
@property(nonatomic, strong) NSString *IpadType;


@end
