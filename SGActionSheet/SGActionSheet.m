//
//  SGActionSheet.m
//  SGActionSheetExample
//
//  Created by 王腾飞 on 16/9/17.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "SGActionSheet.h"
#import "SGActionSheetCell.h"
#import "UIView+SGExtension.h"


#define titleFond [UIFont systemFontOfSize:20]

#define SG_screenWidth [UIScreen mainScreen].bounds.size.width
#define SG_screenHeight [UIScreen mainScreen].bounds.size.height

@interface SGActionSheet () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *coverView;
/** 底部弹出视图 */
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *otherButtons;

@end

@implementation SGActionSheet

static CGFloat const margin = 0;
static CGFloat const cell_rowHeight = 44;
static CGFloat const SheetViewAnimationDuration = 0.25;

- (instancetype)initWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.title = title;
        self.delegate_SG = delegate;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtons = [NSArray array];
        self.otherButtons = otherButtonTitleArray;
        
        [self setupSubviews];
        
    }
    return self;
}

+ (instancetype)actionSheetWithTitle:(NSString *)title delegate:(id<SGActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitleArray:(NSArray *)otherButtonTitleArray {
    return [[self alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitleArray:otherButtonTitleArray];
}


/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


- (void)setupSubviews {
    self.frame = [UIScreen mainScreen].bounds;
    
    // 遮盖视图
    self.coverView = [[UIButton alloc] init];
    self.coverView.frame = self.bounds;
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.coverView addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.coverView];
    
    // 取消按钮的创建
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setTitle:self.cancelButtonTitle forState:(UIControlStateNormal)];
    [cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"SGActionSheet.bundle/cell_bg_image"] forState:(UIControlStateNormal)];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"SGActionSheet.bundle/cell_bg_image_high@2x"] forState:(UIControlStateHighlighted)];
    [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];


    // 提示标题文字
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor redColor];
    label.text = self.title;
    
    CGFloat labelW = SG_screenWidth - 2 * margin;
    CGSize labelSize = [self sizeWithText:label.text font:titleFond maxSize:CGSizeMake(labelW, MAXFLOAT)];
    
    if (label.text) {
        label.frame = CGRectMake(margin, 0, SG_screenWidth - 2 * margin, labelSize.height);
        
        // 创建tableView
        CGFloat tableViewHeight;
        if (_otherButtons.count <= 2) {
            tableViewHeight = cell_rowHeight * _otherButtons.count;
        } else {
            tableViewHeight = cell_rowHeight * 2;
        }
        self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, labelSize.height + 1, SG_screenWidth, tableViewHeight)) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = cell_rowHeight;
        
        
        // 创建底部弹出视图
        self.sheetView = [[UIView alloc] init];
        
        [self.sheetView addSubview:label];
        [self.sheetView addSubview:_tableView];
        [self.sheetView addSubview:cancelButton];
        
        CGFloat sheetViewHeight = labelSize.height + tableViewHeight + 5 + cell_rowHeight;
        if (_otherButtons.count <= 2) {
            self.tableView.scrollEnabled = NO;
            _tableView.bounces = NO;
        }
        
        cancelButton.frame = CGRectMake(0,  sheetViewHeight - cell_rowHeight, SG_screenWidth, cell_rowHeight);
        
        self.sheetView.frame = CGRectMake(0, SG_screenHeight, [UIScreen mainScreen].bounds.size.width, sheetViewHeight);

    } else {
        
        // 创建tableView
        CGFloat tableViewHeight;
        if (_otherButtons.count <= 2) {
            tableViewHeight = cell_rowHeight * _otherButtons.count;
        } else {
            tableViewHeight = cell_rowHeight * 2;
        }
        self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, SG_screenWidth, tableViewHeight)) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = cell_rowHeight;
        
        
        // 创建底部弹出视图
        self.sheetView = [[UIView alloc] init];
        
        [self.sheetView addSubview:_tableView];
        [self.sheetView addSubview:cancelButton];
        
        CGFloat sheetViewHeight = tableViewHeight + 5 + cell_rowHeight;
        if (_otherButtons.count <= 2) {
            self.tableView.scrollEnabled = NO;
            _tableView.bounces = NO;
        }
        
        cancelButton.frame = CGRectMake(0,  sheetViewHeight - cell_rowHeight, SG_screenWidth, cell_rowHeight);

        self.sheetView.frame = CGRectMake(0, SG_screenHeight, [UIScreen mainScreen].bounds.size.width, sheetViewHeight);
    }
    
    [self.coverView addSubview:_sheetView];
}

- (void)show {
    if (self.superview != nil) return;

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:SheetViewAnimationDuration animations:^{
        self.sheetView.transform = CGAffineTransformMakeTranslation(0, - self.sheetView.SG_height);
    }];
}


/** 点击按钮以及遮盖部分执行的方法 */
- (void)dismiss {
    [UIView animateWithDuration:SheetViewAnimationDuration animations:^{
        self.sheetView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

    }];
}

#pragma mark - - - TableView代理以及数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.otherButtons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    SGActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SGActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    cell.titleLabel.text = self.otherButtons[indexPath.row];
    
    cell.splitters.hidden = indexPath.row == 0;
    
    cell.tag = indexPath.row + cell_Tag;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate_SG respondsToSelector:@selector(SGActionSheet:didSelectRowAtIndexPath:)]) {
        [self.delegate_SG SGActionSheet:self didSelectRowAtIndexPath:indexPath.row];
    }
    [self dismiss];
}



@end
