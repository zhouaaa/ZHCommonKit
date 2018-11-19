//
//  ViewController.m
//  ZHCommonKit
//
//  Created by Mac on 2018/11/14.
//  Copyright © 2018年 周辉. All rights reserved.
//

#import "ViewController.h"
#import "ZHCommonKit.h"


@interface ViewController ()

@property (nonatomic,strong) UIView *bgview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    
    _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2, kScreenWidth, self.view.frame.size.height/2)];
    _bgview.backgroundColor = [UIColor redColor];
    [self.view addSubview:_bgview];
    
    
    [ZHNetClient initWithBasicURL:nil isOpenLog:YES];
    ZHNetRequest *request = [[ZHNetRequest alloc] initWithRelativeURLString:@"https://www.apiopen.top/novelApi" success:^(id data) {
        
    } fail:^(NSError *error) {
        
    }];
    [request postData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
