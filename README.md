## SGActionSheet

![](https://github.com/kingsic/SGActionSheet/raw/master/Gif/sorgle.gif) 

### * `自定义的UIActionSheet`<br>

* SGActionSheet使用方法一：

  * 将项目中SGActionSheet文件夹拖入工程

  * 导入#import "SGActionSheet.h"头文件

  * 对象方法创建
```Objective-C
 - (instancetype)initWithFrameWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray 
```

  * 类方法创建
```Objective-C
 + (instancetype)actionSheetWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray
```

  * 属性设置

   * sheet.messageTextColor = [UIColor redColor]; // 设置提示信息文字颜色 （默认为黑色）
 
   * sheet.otherTitleColor = [UIColor brownColor]; // 设置其他按钮文字颜色 （默认为黑色）

   * sheet.cancelButtonTitleColor = [UIColor redColor]; // 设置取消按钮文字颜色 （默认为黑色）

   * sheet.messageTextFont = [UIFont systemFontOfSize:20];  // 设置提示信息文字大小 （默认为17）

   * sheet.otherTitleFont = [UIFont systemFontOfSize:20];  // 设置其他按钮文字大小 （默认为17）

   * sheet.cancelButtonTitleFont = [UIFont systemFontOfSize:20];  // 设置取消按钮文字大小 （默认为17）

   * 遵循SGActionSheetDelegate协议的delegate_SG方法
```Objective-C
 - (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath；
```
  
* SGActionSheet使用方法二：（详细使用方法，请参考Demo）

* 提示信息文字，根据内容自动调节
```Objective-C
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary *)attributes context:(nullable NSStringDrawingContext *)context;
```
