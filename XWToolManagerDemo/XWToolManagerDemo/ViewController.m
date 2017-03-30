//
//  ViewController.m
//  XWToolManagerDemo
//
//  Created by wyy on 2017/3/30.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "XWToolManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XWToolManager *manager = [[XWToolManager alloc] init];
    [manager doSomething];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7.jpg"]];
    imageView.frame = CGRectMake(10, 10, 100, 100);
    [self.view addSubview:imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
