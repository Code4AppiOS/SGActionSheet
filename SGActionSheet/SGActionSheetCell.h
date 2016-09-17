//
//  SGActionSheetCell.h
//  SGActionSheetExample
//
//  Created by Sorgle on 16/9/17.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

// 欢迎来Github上下载最新、最完善的Demo
// Github下载地址 https://github.com/kingsic/SGActionSheet.git

#import <UIKit/UIKit.h>

#define cell_Tag 100

@interface SGActionSheetCell : UITableViewCell
/** cell上的标题内容 */
@property (nonatomic, strong) UILabel *titleLabel;

/** cell之间的分割线 */
@property (nonatomic, strong) UIImageView *splitters;

@end
