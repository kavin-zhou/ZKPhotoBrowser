//
//  ZKPhoto.h
//  ZKPhotoBrowser
//
//  Created by Zhou Kang on 2018/4/24.
//  Copyright © 2018年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKPhoto : NSObject

@property (nonatomic, strong) NSURL       *url;
@property (nonatomic, assign) BOOL        firstShow;
@property (nonatomic, strong) UIImage     *image;        //!< 完整的图片
@property (nonatomic, strong) UIImageView *srcImageView; //!< 来源view
@property (nonatomic, assign) NSInteger   index;         //!< 索引
@property (nonatomic, assign) BOOL        save;          //!< 是否已经保存到相册

@property (nonatomic, strong, readonly) UIImage *placeholder;

@end
