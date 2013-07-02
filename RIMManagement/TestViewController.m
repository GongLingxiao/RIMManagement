//
//  TestViewController.m
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-4.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import "TestViewController.h"
#import "WebService.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tabBarController.navigationItem.title = @"首页";
    [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_home_selected"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_home_unselected"]];
    
}

- (IBAction)test:(id)sender {
    [WebService postData:@"1234"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
