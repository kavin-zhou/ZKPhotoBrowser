//
//  ZKZoomingScrollView.h
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKPhotoBrowser, ZKPhoto, ZKPhotoView;

@protocol ZKPhotoViewDelegate <NSObject>

- (void)photoViewImageFinishLoad:(ZKPhotoView *)photoView;
- (void)photoViewSingleTap:(ZKPhotoView *)photoView;
- (void)photoViewDidEndZoom:(ZKPhotoView *)photoView;

@end

@interface ZKPhotoView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) ZKPhoto *photo;
@property (nonatomic, weak) id<ZKPhotoViewDelegate> photoViewDelegate;

@end
