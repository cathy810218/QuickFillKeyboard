//
//  MainViewController.m
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 1/20/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

#import "MainViewController.h"
#import "LaunchKit.h"
#import "HelpViewController.h"
#import "Constants.h"
//#define APP_STORE_ID 1067669330
@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fillInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *setupLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

@implementation MainViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    self.title = NSLocalizedString(@"QuickFillKeyboard", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    self.fillInfoLabel.text = NSLocalizedString(@"fill_your_info", nil);
    self.setupLabel.text = NSLocalizedString(@"how_to_setup", nil);
    self.rateLabel.text = NSLocalizedString(@"rate_review", nil);
    
    [self.view addSubview: self.fillInfoLabel];
    [self.view addSubview: self.setupLabel];
    [self.view addSubview: self.rateLabel];
}


//-(void)keyboardOnScreen:(NSNotification *)notification
//{
//    NSDictionary *info  = notification.userInfo;
//    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
//    
//    CGRect rawFrame      = [value CGRectValue];
//    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
//    
//    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
//}

- (IBAction)helpButtonPressed:(id)sender {
    HelpViewController *helpVC = [[HelpViewController alloc]init];
    [self.navigationController pushViewController:helpVC animated:YES];
}


- (IBAction)rateMePressed:(id)sender {
  static NSString *const iOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%d";
  static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";
  
  NSURL *linkMe = [NSURL URLWithString:[NSString stringWithFormat:([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)? iOS7AppStoreURLFormat: iOSAppStoreURLFormat, [kAppID intValue]]]; // Would contain the right link
  [[UIApplication sharedApplication] openURL:linkMe];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[LaunchKit sharedInstance] presentAppReleaseNotesIfNeededFromViewController:self completion:^(BOOL didPresent) {
        if (didPresent) {
            NSLog(@"Woohoo, we showed the release notes card!");
        }
    }];
}
@end
