//
//  RootViewController.m
//  WPUnlocker
//
//  Created by mufeng on 16/3/19.
//  Copyright © 2016年 puckjs.com. All rights reserved.
//

#import "RootViewController.h"
#import "QRCodeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    self.title = @"iUnlocker";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setBackground];
    [self setDescription];
    [self setButton];
}

- (void)setBackground {
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:(CGRect){(SCREENWIDTH-130.f)/2, 170.f, 130.f, 100.f}];
    [backgroundView setImage:IMG(@"connect_alert_mac.png")];
    
    [self.view addSubview:backgroundView];
}

- (void)setDescription {
    UILabel *description = [[UILabel alloc] initWithFrame:(CGRect){0, 300.f, SCREENWIDTH, 16.f}];
    [description setTextColor:RGB(0x4b4b4b)];
    [description setText:@"扫描二维码以登录网页"];
    [description setFont:[UIFont fontWithName:@"Helvetica" size:18.f]];
    [description setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:description];
}

- (void)setButton {
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){(SCREENWIDTH-150.f)/2, 400.f, 150.f, 35.f}];
    [button setTitle:@"点击扫码" forState:UIControlStateNormal];
    [button setTitleColor:RGB(0x007aff) forState:UIControlStateNormal];
    [button setTitleColor:RGB(0xffffff) forState:UIControlStateHighlighted];
    [button setBackgroundImage:IMG(@"blueHL.png") forState:UIControlStateHighlighted];
    
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 3.0f;
    button.layer.borderColor = [RGB(0x007aff) CGColor];
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(toQRCodeViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)toQRCodeViewController {
    QRCodeViewController *targetController = [[QRCodeViewController alloc] init];
    [self.navigationController pushViewController:targetController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end