//
//  ViewController.m
//  SGActionSheetExample
//
//  Created by 王腾飞 on 16/9/17.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "ViewController.h"
#import "SGActionSheet.h"

@interface ViewController () <SGActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照", @"sorgle"]];
    sheet.titleColor = [UIColor redColor];
//    sheet.otherTitleColor = [UIColor brownColor];
    [sheet show];
}


- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {
    NSLog(@"%ld", indexPath);
}

@end
