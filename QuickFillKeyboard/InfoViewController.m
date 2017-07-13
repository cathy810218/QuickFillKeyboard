//
//  InfoViewController.m
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 11/24/15.
//  Copyright © 2015 Cathy Oun. All rights reserved.
//

#import "InfoViewController.h"
#import "UIColor+Extension.h"
@interface InfoViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) UITapGestureRecognizer *scrollGestureRecognizer;

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UITextField *zipTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *optionKeyTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *optionContentTextField;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearAllButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"infoTitle", nil);
    
    [self setupTextField:self.firstNameTextField withTag:0];
    [self setupTextField:self.lastNameTextField withTag:1];
    [self setupTextField:self.emailTextField withTag:2];
    [self setupTextField:self.addressTextField withTag:3];
    [self setupTextField:self.cityTextField withTag:4];
    [self setupTextField:self.stateTextField withTag:5];
    [self setupTextField:self.zipTextField withTag:6];
    [self setupTextField:self.phoneNumTextField withTag:7];
    [self setupTextField:self.optionKeyTitleTextField withTag:8];
    [self setupTextField:self.optionContentTextField withTag:9];
    
    self.firstNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"firstName", nil)];
    self.lastNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"lastName", nil)];
    self.emailLabel.text = [NSString stringWithFormat:NSLocalizedString(@"email", nil)];
    self.addressLabel.text = [NSString stringWithFormat:NSLocalizedString(@"address", nil)];
    self.cityLabel.text = [NSString stringWithFormat:NSLocalizedString(@"city", nil)];
    self.stateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"state", nil)];
    self.zipLabel.text = [NSString stringWithFormat:NSLocalizedString(@"zip", nil)];
    self.phoneLabel.text = [NSString stringWithFormat:NSLocalizedString(@"phoneNum", nil)];
    self.optionKeyTitleTextField.placeholder = NSLocalizedString(@"optional", nil);
    
    self.scrollView.delegate = self;
    self.scrollGestureRecognizer.delegate = self;
    self.scrollGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardWithTouch:)];
    [self.scrollView addGestureRecognizer:self.scrollGestureRecognizer];
    [self.scrollView setContentSize:self.contentView.frame.size];
    
    [self.clearAllButton setTitle: NSLocalizedString(@"clear", nil)];
    [self.saveButton setTitle: NSLocalizedString(@"save", nil)];
    [self.toolbar setBarTintColor:[UIColor primaryColor]];
    [self.toolbar setTintColor: [UIColor whiteColor]];
}

- (void)setupTextField:(UITextField *)textField withTag:(NSInteger)tag {
    textField.delegate = self;
    textField.tag = tag;
    [self updateBorderColorForTextfield:textField];
}

- (void)updateBorderColorForTextfield: (UITextField *)textfield {
    textfield.layer.borderWidth = 1.0f;
    textfield.layer.cornerRadius = 5;
    textfield.layer.borderColor = [[UIColor colorWithRed:70.0f/255.0f green:139.0f/255.0f blue:136.0f/255.0f alpha:1.0] CGColor];
    textfield.textColor = [UIColor darkGrayColor];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self fetchUserLocalKeyboardInfo];
}

- (void)fetchUserLocalKeyboardInfo {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    NSDictionary *currUserInfo = [shared valueForKey:@"userInfo"];
    
    self.firstNameTextField.text = currUserInfo[@"firstName"];
    self.lastNameTextField.text = currUserInfo[@"lastName"];
    self.emailTextField.text = currUserInfo[@"email"];
    self.addressTextField.text = currUserInfo[@"address1"];
    self.optionKeyTitleTextField.text = currUserInfo[@"optionTitle"];
    self.optionContentTextField.text = currUserInfo[@"optionContent"];
    self.cityTextField.text = currUserInfo[@"city"];
    self.stateTextField.text = currUserInfo[@"state"];
    self.zipTextField.text = currUserInfo[@"zip"];
    self.phoneNumTextField.text = currUserInfo[@"phoneNum"];
}


- (IBAction)finishAction:(id)sender {
    self.infoDict = @{@"firstName" : self.firstNameTextField.text,
                      @"lastName" : self.lastNameTextField.text,
                      @"email" : self.emailTextField.text,
                      @"address1" : self.addressTextField.text,
                      @"city" : self.cityTextField.text,
                      @"state" : self.stateTextField.text,
                      @"zip" : self.zipTextField.text,
                      @"phoneNum": self.phoneNumTextField.text,
                      @"optionTitle":self.optionKeyTitleTextField.text,
                      @"optionContent": self.optionContentTextField.text};
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    [shared setObject:self.infoDict forKey:@"userInfo"];
    [shared synchronize];
    
    // show an alert view
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"alert.updated_title", nil)
                                                                   message: NSLocalizedString(@"alert.updated_message", nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle: NSLocalizedString(@"okay", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }];
    [alert addAction:okay];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)clearAllAction:(id)sender {
    
    UIAlertController *clearAlert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"alert.clear_title", nil) message: NSLocalizedString(@"alert.clear_message", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *deleteAll = [UIAlertAction actionWithTitle: NSLocalizedString(@"yes", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        for (id subView in self.contentView.subviews) {
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *t = (UITextField *)subView;
                t.text = @"";
            }
            
        }
        
        NSArray *keys = [self.infoDict allKeys];
        NSMutableDictionary *mutableDict = [NSMutableDictionary new];
        for (NSString *key in keys) {
            mutableDict[key] = @"";
        }
        self.infoDict = [mutableDict copy];
        
        NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
        [shared setObject:self.infoDict forKey:@"userInfo"];
        [shared synchronize];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle: NSLocalizedString(@"cancel", nil)  style:UIAlertActionStyleCancel handler:nil];
    
    [clearAlert addAction:deleteAll];
    [clearAlert addAction:cancel];
    [self presentViewController:clearAlert animated:true completion:nil];
}


- (void)hideKeyboardWithTouch:(id)sender{
    
    [self.view endEditing:YES];
    
    // Scroll position Control
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        [self hideKeyboardWithTouch:nil];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag > 4) {
        
        // Control for Scroll position
        if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"]) {
            if ([UIScreen.mainScreen bounds].size.height < 736) {
                [self.scrollView setContentOffset:CGPointMake(0.0, self.view.frame.size.height/4) animated:YES];
            } else {
                [self.scrollView setContentOffset:CGPointMake(0.0, self.view.frame.size.height/6) animated:YES];
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.optionKeyTitleTextField) {
        if(range.length + range.location > textField.text.length) {
            return NO;
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 15;
    }
    return YES;
}

@end
