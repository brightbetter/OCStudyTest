//
//  ViewController.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/22.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "ViewController.h"
#import "BWResponderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [BWMethodTest metaTest];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self presentViewController:[BWResponderViewController new] animated:NO completion:nil];
}


@end
