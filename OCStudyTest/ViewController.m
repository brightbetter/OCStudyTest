//
//  ViewController.m
//  OCStudyTest
//
//  Created by Bright on 2020/3/22.
//  Copyright © 2020 Bright. All rights reserved.
//

#import "ViewController.h"
#import "BWResponderViewController.h"
#import "BWProperty.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:18];
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    label.text = @"gsfgsdfdssdfsfsfsfsdfs";
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.66;
    [self.view addSubview:label];
    BWProperty *test = [[BWProperty alloc] init];
    [test testCopy];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"444 %@", [self class]);
}


@end
