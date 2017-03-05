//
//  UIImageView+ZKWebCache.h
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "UIImageView+WebCache.h"

@interface UIImageView (ZKWebCache)

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)placeholder;
- (void)setImageURLStr:(NSString *)urlStr placeholder:(UIImage *)placeholder;

@end
