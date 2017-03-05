# ZKPhotoBrowser
一款体验流畅的图片浏览器，比如朋友圈的图片点击放大预览效果。
### 用法
1. 将 `ZKPhotoBrowser` 下载下来并拖入你的项目。
2. 在需要的地方 `#import "ZKPhotoBrowser.h"`，给每个 `UIImageView` 控件绑定 `tap` 手势。
3. 实现 API 如下：

```oc
- (void)tapImage:(UITapGestureRecognizer *)tap
{
[ZKPhotoBrowser showWithImageUrls:self.urls currentPhotoIndex:tap.view.tag sourceSuperView:tap.view.superview];
}
```
