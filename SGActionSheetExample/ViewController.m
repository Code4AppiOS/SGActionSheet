//
//  ViewController.m
//  SGActionSheetExample
//
//  Created by Sorgle on 16/9/17.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import "ViewController.h"
#import "SGActionSheet.h"
#import "SGAlertView.h"

@interface ViewController () <SGActionSheetDelegate, SGAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)default:(id)sender {
    SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照"]];
    sheet.cancelButtonTitleColor = [UIColor redColor];
    [sheet show];
}

- (IBAction)default_Message:(id)sender {
    SGActionSheet *sheet = [SGActionSheet actionSheetWithTitle:@"信息提示文字, 可以自适应高度" delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照"]];
    [sheet show];
}

- (IBAction)default_Scroll:(id)sender {
    SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照", @"照片", @"选取"]];
    sheet.cancelButtonTitleColor = [UIColor redColor];
    [sheet show];
}

- (IBAction)default_Message_Scroll:(id)sender {
    SGActionSheet *sheet = [SGActionSheet actionSheetWithTitle:@"This is custom UIActionSheet, information prompt text and adaptive height" delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照", @"照片", @"选取"]];
    sheet.messageTextFont = [UIFont systemFontOfSize:20];
    sheet.messageTextColor = [UIColor redColor];
    sheet.otherTitleFont = [UIFont systemFontOfSize:20];
    sheet.cancelButtonTitleFont = [UIFont systemFontOfSize:20];
    [sheet show];
}

- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {
    NSLog(@"%ld", indexPath);
}

#pragma mark - - - AlertView
- (IBAction)default_alertView:(id)sender {
    
    SGAlertView *alert = [[SGAlertView alloc] initWithTitle:@"温馨提示 ! !" delegate:nil contentTitle:@"代码不断更新、优化中, 请移步GitHub下载最新Demo" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
    [alert show];
}

- (IBAction)default_alertView_two:(id)sender {
    SGAlertView *alert = [[SGAlertView alloc] initWithTitle:@"确定退出 ?" delegate:self contentTitle:@"退出登录后将无法查看订单, 重新登录后即可查看" alertViewBottomViewType:(SGAlertViewBottomViewTypeTwo)];
    [alert show];
}

- (void)didSelectedSureButtonClick {
    NSLog(@"nin dian ji de shi que ding an niu");
}

@end
