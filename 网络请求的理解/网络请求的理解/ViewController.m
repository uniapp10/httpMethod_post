//
//  ViewController.m
//  网络请求的理解
//
//  Created by zhudong on 2017/8/15.
//  Copyright © 2017年 zhudong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define ScreenSize [UIScreen mainScreen].bounds.size
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat leftMargin = 30;
    
    UIButton *btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_close.frame = CGRectMake(leftMargin, 100, ScreenSize.width - 2 * leftMargin, 40);
    btn_close.backgroundColor = [UIColor redColor];
    [btn_close setTitle:@"upload" forState:UIControlStateNormal];
    [btn_close addTarget:self action:@selector(upload_local) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_close];
}

- (void)upload_local{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1/wenjiansccl.php?fileField=aa&action=submit"]]];
    request.HTTPMethod = @"POST";
    
    NSMutableString *dataBody = [NSMutableString string];
    
    [dataBody appendFormat:@"%@\r\n%@\r\n\r\n%@\r\n%@\r\n%@\r\n%@\r\n\r\n",
     @"------WebKitFormBoundary46V91AQBvvC4Z2eI",
     @"Content-Disposition: form-data; name=\"action\"",
     @"submit",
     @"------WebKitFormBoundary46V91AQBvvC4Z2eI",
     @"Content-Disposition: form-data; name=\"fileField\"; filename=\"test.log\"",
     @"Content-Type: application/octet-stream"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test.log" ofType:nil];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [dataBody appendFormat:@"%@", fileData];
    [dataBody appendFormat:@"\r\n%@\r\n%@\r\n\r\n%@\r\n%@",
     @"------WebKitFormBoundary46V91AQBvvC4Z2eI",
     @"Content-Disposition: form-data; name=\"button\"",
     @"提交",
     @"------WebKitFormBoundary46V91AQBvvC4Z2eI--"];
    [request setValue:@"multipart/form-data; boundary=----WebKitFormBoundary46V91AQBvvC4Z2eI" forHTTPHeaderField:@"content-type"];
    request.HTTPBody = [dataBody dataUsingEncoding:NSUTF8StringEncoding];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
    }] resume];

}

@end
