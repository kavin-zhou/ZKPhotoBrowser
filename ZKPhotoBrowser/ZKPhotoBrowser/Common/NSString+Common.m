//
//  NSString+Common.m
//  ZKPhotoBrowser
//
//  Created by ZK on 17/3/5.
//  Copyright © 2017年 ZK. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (NSString *)zk_fullThumbImageURLWithMinPixel:(NSInteger)minPixel {
    if (!self.length) return self;
    
    NSString *lastComponent = [NSString stringWithFormat:@"_%@.jpg", @(minPixel)];
    
    return [self stringByReplacingOccurrencesOfString:@".jpg" withString:lastComponent];
}

@end
