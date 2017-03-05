//
//  ZKPhotoToolbar.h
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKPhotoToolbar : UIView

@property (nonatomic, strong) NSArray    *photos;           //!< 所有的图片对象
@property (nonatomic, assign) NSUInteger currentPhotoIndex; //!< 当前展示的图片索引

@end
