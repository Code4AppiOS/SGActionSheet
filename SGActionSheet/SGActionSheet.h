//
//  SGActionSheet.h
//  SGActionSheetExample
//
//  Created by 王腾飞 on 16/9/17.
//  Copyright © 2016年 Jason. All rights reserved.
//

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

@property (nonatomic, weak) id<SGActionSheetDelegate> delegate_SG;

- (instancetype)initWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

+ (instancetype)actionSheetWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray;

- (void)show;

@end
