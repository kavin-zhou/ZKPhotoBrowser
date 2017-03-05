//
//  ZKPhotoBrowser.h
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKPhoto.h"
@class ZKPhotoBrowser;

@protocol ZKPhotoBrowserDelegate <NSObject>
@optional
/** 切换到某一页图片 */
- (void)photoBrowser:(ZKPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end

@interface ZKPhotoBrowser : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<ZKPhotoBrowserDelegate> delegate;

/** 初始化方法, 一定要实现 */
- (instancetype)initWithPhotos:(NSArray <ZKPhoto *> *)photos currentPhotoIndex:(NSUInteger)index;

- (void)show;

@end
