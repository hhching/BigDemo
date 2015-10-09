//
//  Public.h
//  bigdemo
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 com.h.limited. All rights reserved.
//

#ifndef bigdemo_Public_h
#define bigdemo_Public_h

#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)     RGBA(r,g,b,1.0f)

#define navigationBarColor RGB(67,199,176)
#define selectColor RGB(46,158,138)
#define separaterColor RGB(200, 199, 204)

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height





#endif
