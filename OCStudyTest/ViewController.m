//
//  ViewController.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/22.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "ViewController.h"
#import "BWGcdTest.h"
#import "BWResponderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [BWMethodTest metaTest];
    [BWGcdTest taskDepend];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:18];
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"gsfgsdfdssdfsfsfsfsdfs";
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.66;
    [self.view addSubview:label];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"444");
}


@end
