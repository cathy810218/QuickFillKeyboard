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
#import <Masonry.h>
//#define APP_STORE_ID 1067669330
@interface MainViewController ()
static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";

@property (weak, nonatomic) IBOutlet UILabel *fillInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *setupLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

@implementation MainViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)helpButtonPressed:(id)sender {
    HelpViewController *helpVC = [[HelpViewController alloc]init];
    [self.navigationController pushViewController:helpVC animated:YES];
}


- (IBAction)rateMePressed:(id)sender {
  NSURL *linkMe = [NSURL URLWithString:[NSString stringWithFormat: iOSAppStoreURLFormat, [kAppID intValue]]];
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
