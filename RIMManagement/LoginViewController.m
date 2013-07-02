//
//  LoginViewController.m
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-6.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import "LoginViewController.h"
#import "ShopViewController.h"
#import "Reachability.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize HUD;

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
    self.storyborad = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    [self.txtUserId becomeFirstResponder];
    [self.txtPassword becomeFirstResponder];
    self.txtUserId.delegate = self;
    self.txtPassword.delegate = self;
    if ([UIScreen mainScreen].bounds.size.height == 480.0) {
        [self.lblCopyright setFrame:CGRectMake(0, 385, 320, 31)];
    }
}

- (IBAction)login:(id)sender {
    Reachability *r = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    if ([r currentReachabilityStatus] != NotReachable) {
        [self.txtUserId resignFirstResponder];
        [self.txtPassword resignFirstResponder];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"pop" ofType:@"wav" inDirectory:@"/"]], &soundID);
        AudioServicesPlaySystemSound (soundID);
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        [HUD setDelegate:self];
        [HUD setLabelText:@"登录中..."];
        [HUD showWhileExecuting:@selector(loginTask) onTarget:self withObject:nil animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法连接网络" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void) loginTask {
    ShopModel *shopModel = [ShopModel getShopList:self.txtUserId.text withPwd:self.txtPassword.text];
    if (shopModel.code == nil) {
        
        [self performSelectorOnMainThread:@selector(showError) withObject:nil waitUntilDone:NO];
    } else {
        [self performSelectorOnMainThread:@selector(gotoNextPage) withObject:nil waitUntilDone:NO];
    }
}

- (void) showError {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
    [self.txtUserId becomeFirstResponder];
}

- (void) gotoNextPage {
    ShopViewController *controller = [self.storyborad instantiateViewControllerWithIdentifier:@"ShopViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [self login:nil];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	HUD = nil;
}

@end
