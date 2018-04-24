//
//  ZKPhoto.m
//  ZKPhotoBrowser
//
//  Created by Zhou Kang on 2018/4/24.
//  Copyright © 2018年 ZK. All rights reserved.
//

#import "ZKPhoto.h"

@implementation ZKPhoto

- (void)setSrcImageView:(UIImageView *)srcImageView {
    _srcImageView = srcImageView;
    _placeholder = srcImageView.image;
}


@end
