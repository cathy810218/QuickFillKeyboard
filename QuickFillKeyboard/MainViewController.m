//
//  MainViewController.m
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 1/20/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

#import "MainViewController.h"
#import "HelpViewController.h"
#import "Constants.h"
#import <Masonry/Masonry.h>
#import <Crashlytics/Crashlytics.h>
//#define APP_STORE_ID 1067669330
static NSString *const iOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d";

@interface MainViewController ()

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChange:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSArray *rectArr = @[[NSNumber numberWithFloat:keyboardFrameBeginRect.size.width],
                         [NSNumber numberWithFloat:keyboardFrameBeginRect.size.height]];
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    [shared setObject:rectArr forKey:@"keyboardRect"];
    
}

- (IBAction)helpButtonPressed:(id)sender {
    [[Crashlytics sharedInstance] crash];
    HelpViewController *helpVC = [[HelpViewController alloc]init];
    [self.navigationController pushViewController:helpVC animated:YES];
}


- (IBAction)rateMePressed:(id)sender {
  NSURL *linkMe = [NSURL URLWithString:[NSString stringWithFormat: iOSAppStoreURLFormat, [kAppID intValue]]];
  [[UIApplication sharedApplication] openURL:linkMe];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
