//
//  ZKPhotoToolbar.m
//
//  Created by ZK on 16/7/19.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKPhotoToolbar.h"
#import "ZKPhoto.h"

@interface ZKPhotoToolbar()

@property (nonatomic, strong) UILabel  *indexLabel;
@property (nonatomic, strong) UIButton *saveImageBtn;

@end

@implementation ZKPhotoToolbar

- (void)setPhotos:(NSArray <ZKPhoto *> *)photos {
    _photos = photos;
    [self setupViews];
}

- (void)setupViews {
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:18];
        _indexLabel.frame = self.bounds;
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_indexLabel];
    }
    
    // 保存图片按钮
    CGFloat btnWidth = self.bounds.size.height;
    _saveImageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveImageBtn.frame = CGRectMake(CGRectGetMaxX(self.frame) - btnWidth, 0, btnWidth, btnWidth);
    [_saveImageBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [_saveImageBtn setTitle:@"保存" forState:UIControlStateNormal];
    _saveImageBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_saveImageBtn setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
    [self addSubview:_saveImageBtn];
}

- (void)saveImage {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ZKPhoto *photo = _photos[_currentPhotoIndex];
        UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存失败");
        
    } else {
        NSLog(@"保存成功");
        ZKPhoto *photo = _photos[_currentPhotoIndex];
        photo.save = YES;
        _saveImageBtn.enabled = NO;
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex {
    _currentPhotoIndex = currentPhotoIndex;
    _indexLabel.text = [NSString stringWithFormat:@"%zd / %zd", _currentPhotoIndex + 1, _photos.count];
    ZKPhoto *photo = _photos[_currentPhotoIndex];
    _saveImageBtn.enabled = photo.image && !photo.save;
}

@end
