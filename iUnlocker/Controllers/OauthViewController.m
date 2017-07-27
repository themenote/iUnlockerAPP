//
//  OauthViewController.m
//  iUnlocker
//
//  Created by mufeng on 16/6/4.
//  Copyright © 2016年 puckjs.com. All rights reserved.
//

#import "OauthViewController.h"
#import "sys/utsname.h"
#import "AFNetworking.h"
#import "SAMKeychain.h"
#import "SVProgressHUD.h"

@interface OauthViewController ()

@end

@implementation OauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews {
    [self setBackground];
    [self setDescription];
    [self setButton];
    [self setCancelButton];
}

- (void)setBackground {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:(CGRect){(SCREENWIDTH-147.f)/2, 170.f, 147.f, 100.f}];
    [backgroundView setImage:IMG(@"connect_alert_mac_mute.png")];
    
    [self.view addSubview:backgroundView];
}

- (void)setDescription {
    UILabel *description = [[UILabel alloc] initWithFrame:(CGRect){0, 300.f, SCREENWIDTH, 16.f}];
    [description setTextColor:RGB(0x4b4b4b)];
    [description setText:@"点击按钮获取授权"];
    [description setFont:[UIFont fontWithName:@"Helvetica" size:18.f]];
    [description setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:description];
}

- (void)setButton {
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){(SCREENWIDTH-150.f)/2, 400.f, 150.f, 35.f}];
    [button setTitle:@"授权网站" forState:UIControlStateNormal];
    [button setTitleColor:RGB(0x37c936) forState:UIControlStateNormal];
    [button setTitleColor:RGB(0xffffff) forState:UIControlStateHighlighted];
    [button setBackgroundImage:IMG(@"greenHL.png") forState:UIControlStateHighlighted];
    
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 3.0f;
    button.layer.borderColor = [RGB(0x37c936) CGColor];
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(generateUUID) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)setCancelButton {
    UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){(SCREENWIDTH-150.f)/2, 460.f, 150.f, 35.f}];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [button setTitle:@"取消授权" forState:UIControlStateNormal];
    [button setTitleColor: RGB(0xaaaaaa) forState:UIControlStateNormal];
    [button setTitleColor: RGB(0x888888) forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(toRootViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)generateUUID {
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *result = [self.url stringByReplacingOccurrencesOfString:@"iunlocker-auth://" withString:@""];
    NSArray *resultArray = [result componentsSeparatedByString:@"#"];
    NSString *adminUrl = [NSString stringWithFormat:@"%@?action=iunlocker_oauth", [resultArray objectAtIndex:0]];
    NSString *appkey = [resultArray objectAtIndex:1];
    
    NSString *UUID = [[NSUUID UUID] UUIDString];
    [SAMKeychain setPassword:UUID forService:@"com.puckjs.iUnlocker" account:@"UUID"];
    [SAMKeychain setPassword:[resultArray objectAtIndex:0] forService:@"com.puckjs.iUnlocker" account:@"ADMINURL"];
    
    NSDictionary *params = @{
                             @"UUID": UUID,
                             @"appkey": appkey,
                             @"deviceName": [[UIDevice currentDevice] name],
                             @"systemVersion": [[UIDevice currentDevice] systemVersion],
                             @"systemInfo": [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]
                             };
    
    [SVProgressHUD showWithStatus:@"授权中..."];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:adminUrl
       parameters:params
         progress:nil
          success:^(NSURLSessionTask *task, id res) {
              [SVProgressHUD showSuccessWithStatus:@"授权成功"];
              [self toRootViewController];
              NSLog(@"response:%@", res);
          }
          failure:^(NSURLSessionTask *task, NSError *error) {
              [SVProgressHUD showErrorWithStatus:@"授权失败"];
              NSLog(@"error:%@", error);
          }];
}

- (void)toRootViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
