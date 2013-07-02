//
//  LoginViewController.h
//  RIMManagement
//
//  Created by Gong Lingxiao on 13-6-6.
//  Copyright (c) 2013年 Gong Lingxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "ShopModel.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) IBOutlet UITextField *txtUserId;
@property (nonatomic, retain) IBOutlet UITextField *txtPassword;
@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) IBOutlet UILabel *lblCopyright;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UIStoryboard *storyborad;

- (IBAction)login:(id)sender;

@end
