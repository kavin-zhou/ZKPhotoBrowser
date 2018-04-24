//
//  ViewController.m
//  ZKPhotoBrowser
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ViewController.h"
#import "ZKPhotoBrowser.h"
#import "NSString+Common.h"
#import "UIImage+Common.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray <NSString *> *urls;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 1000.f);
    
    _contentView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, scrollView.frame.size}];
    [scrollView addSubview:_contentView];
    
    MCDisableAutoAdjustScrollViewInsets(scrollView, self);
}

- (void)setupUI
{
    [self setupScrollView];
    UIImage *placeholder = [UIImage zk_imageWithColor:[UIColor lightGrayColor]];
    CGFloat width = 70;
    CGFloat height = 70;
    CGFloat margin = 10;
    CGFloat startX = (self.view.frame.size.width - 3 * width - 2 * margin) * 0.5;
    CGFloat startY = _contentView.center.y;
    for (int i = 0; i<9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [_contentView addSubview:imageView];
        int row    = i/3;
        int column = i%3;
        CGFloat x = startX + column * (width + margin);
        CGFloat y = startY + row * (height + margin);
        imageView.frame = CGRectMake(x, y, width, height);
        
        NSString *imageStr = [self.urls[i] zk_fullThumbImageURLWithMinPixel:150];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:placeholder];
        
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [ZKPhotoBrowser showWithImageUrls:self.urls currentPhotoIndex:tap.view.tag sourceSuperView:tap.view.superview];
}

#pragma mark - Lazy Loading
- (NSArray<NSString *> *)urls
{
    if (!_urls) {
        _urls = @[
                  @"http://images.himoca.com/dynamic/96/6c/b34c49c4df71895ee4e8ef93df25574b.jpg",
                  @"http://images.himoca.com/dynamic/96/6c/5c9cfeda773002e4347d0287015030f6.jpg",
                  @"http://images.himoca.com/dynamic/98/90/6096b7c7013c7423c09d0158daf1a181.jpg",
                  @"http://images.himoca.com/dynamic/96/6c/75309ab952a33ed418cd18b47b14bada.jpg",
                  @"http://images.himoca.com/dynamic/96/6c/f7e9dbd226d0281e7451ac8bf5008df8.jpg",
                  @"http://images.himoca.com/dynamic/96/6c/f02117b77b8a954df4cb09e2ce347f52.jpg",
                  @"http://images.himoca.com/dynamic/96/6c/7f16d678488c87d369f11bff032f7f88.jpg",
                  @"http://images.himoca.com/dynamic/db/77/13da5b006642a5a95c512cb528058dff.jpg",
                  @"http://images.himoca.com/dynamic/db/77/29b553b49130570391d9288ef09dc39b.jpg"];
    }
    return _urls;
}

@end
