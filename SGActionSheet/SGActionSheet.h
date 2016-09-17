//
//  SGActionSheet.h
//  SGActionSheetExample
//
//  Created by Sorgle on 16/9/17.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

// 欢迎来Github上下载最新、最完善的Demo
// Github下载地址 https://github.com/kingsic/SGActionSheet.git

#import <UIKit/UIKit.h>
@class SGActionSheet;

@protocol SGActionSheetDelegate <NSObject>

- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath;

@end

@interface SGActionSheet : UIView

/** 提示标题文字 */
@property (nonatomic, copy) NSString *title;

/** 取消按钮标题 */
@property (nonatomic, copy) NSString *cancelButtonTitle;

/** 提示标题文字颜色设置 */
@property (nonatomic, strong) UIColor *titleColor;

/** 其他标题文字颜色设置 */
@property (nonatomic, strong) UIColor *otherTitleColor;

@property (nonatomic, weak) id<SGActionSheetDelegate> delegate_SG;

- (instancetype)initWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

+ (instancetype)actionSheetWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

- (void)show;

@end
