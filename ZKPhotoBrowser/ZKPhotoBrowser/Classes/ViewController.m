//
//  ViewController.m
//  ZKPhotoBrowser
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ZKWebCache.h"
#import "ZKPhotoBrowser.h"

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
}

- (void)setupUI
{
    [self setupScrollView];
    
    // 1.创建9个UIImageView
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    CGFloat width = 70;
    CGFloat height = 70;
    CGFloat margin = 10;
    CGFloat startX = (self.view.frame.size.width - 3 * width - 2 * margin) * 0.5;
    CGFloat startY = _contentView.center.y;
    for (int i = 0; i<9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [_contentView addSubview:imageView];
        // 计算位置
        int row    = i/3;
        int column = i%3;
        CGFloat x = startX + column * (width + margin);
        CGFloat y = startY + row * (height + margin);
        imageView.frame = CGRectMake(x, y, width, height);
        
        // 下载图片
        [imageView setImageURLStr:self.urls[i] placeholder:placeholder];
        
        // 事件监听
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        
        // 内容模式
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [self showPhotoBrowserWithTap:tap];
}

- (void)showPhotoBrowserWithTap:(UITapGestureRecognizer *)tap
{
    NSInteger count = self.urls.count;
    // 1.封装图片数据
    NSMutableArray <ZKPhoto *> *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为大尺寸图片 中:bmiddle  大:large
        NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
        ZKPhoto *photo = [[ZKPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"class == %@", [UIImageView class]];
        NSArray *tempArray = [[NSArray alloc] init];
        tempArray = [_contentView.subviews filteredArrayUsingPredicate:predicate];
        
        photo.srcImageView = tempArray[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    ZKPhotoBrowser *browser = [[ZKPhotoBrowser alloc] initWithPhotos:photos currentPhotoIndex:tap.view.tag];
    [browser show];
}

#pragma mark - Lazy Loading
- (NSArray<NSString *> *)urls
{
    if (!_urls) {
        _urls = @[@"http://ww4.sinaimg.cn/thumbnail/7f8c1087gw1e9g06pc68ug20ag05y4qq.gif",
                  @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg",
                  @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1d0vyj20pf0gytcj.jpg",
                  @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                  @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                  @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                  //@"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                  //@"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                  @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                  @"http://images.himoca.com/dynamic/db/77/13da5b006642a5a95c512cb528058dff.jpg",
                  @"http://images.himoca.com/dynamic/db/77/29b553b49130570391d9288ef09dc39b.jpg"];
    }
    return _urls;
}

@end
