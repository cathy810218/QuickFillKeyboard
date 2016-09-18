//
//  InfoViewController.m
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 11/24/15.
//  Copyright © 2015 Cathy Oun. All rights reserved.
//

#import "InfoViewController.h"
#import "UIColor+Extension.h"
@interface InfoViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate,
                                UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, strong) UITapGestureRecognizer *scrollGestureRecognizer;


@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *zip;
@property (strong, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *optionKeyTitle;
@property (weak, nonatomic) IBOutlet UITextField *optionContent;

// label
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
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.email.delegate = self;
    self.address.delegate = self;
    self.optionContent.delegate = self;
    self.optionKeyTitle.delegate = self;
    self.city.delegate = self;
    self.state.delegate = self;
    self.zip.delegate = self;
    self.phoneNum.delegate = self;
    self.scrollView.delegate = self;
    self.scrollGestureRecognizer.delegate = self;
    self.scrollGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboardWithTouch:)];
    [self.scrollView addGestureRecognizer:self.scrollGestureRecognizer];
    [self.scrollView setContentSize:self.contentView.frame.size];
    // Do any additional setup after loading the view, typically from a nib
    
    [self updateBorderColorForTextfield:self.firstName];
    [self updateBorderColorForTextfield:self.lastName];
    [self updateBorderColorForTextfield:self.email];
    [self updateBorderColorForTextfield:self.address];
    [self updateBorderColorForTextfield:self.optionContent];
    [self updateBorderColorForTextfield:self.optionKeyTitle];
    [self updateBorderColorForTextfield:self.city];
    [self updateBorderColorForTextfield:self.state];
    [self updateBorderColorForTextfield:self.zip];
    [self updateBorderColorForTextfield:self.phoneNum];
    
    self.firstNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"firstName", nil)];
    self.lastNameLabel.text = [NSString stringWithFormat:NSLocalizedString(@"lastName", nil)];
    self.emailLabel.text = [NSString stringWithFormat:NSLocalizedString(@"email", nil)];
    self.addressLabel.text = [NSString stringWithFormat:NSLocalizedString(@"address", nil)];
    self.cityLabel.text = [NSString stringWithFormat:NSLocalizedString(@"city", nil)];
    self.stateLabel.text = [NSString stringWithFormat:NSLocalizedString(@"state", nil)];
    self.zipLabel.text = [NSString stringWithFormat:NSLocalizedString(@"zip", nil)];
    self.phoneLabel.text = [NSString stringWithFormat:NSLocalizedString(@"phoneNum", nil)];
    self.optionKeyTitle.placeholder = NSLocalizedString(@"optional", nil);
    
    [self.clearAllButton setTitle: NSLocalizedString(@"clear", nil)];
    [self.saveButton setTitle: NSLocalizedString(@"save", nil)];
    [self.toolbar setBarTintColor:[UIColor primaryColor]];
    [self.toolbar setTintColor: [UIColor whiteColor]];
}

- (void)updateBorderColorForTextfield: (UITextField *)textfield {
    textfield.layer.borderWidth = 1.0f;
    textfield.layer.cornerRadius = 5;
    textfield.layer.borderColor = [[UIColor colorWithRed:70.0f/255.0f green:139.0f/255.0f blue:136.0f/255.0f alpha:1.0] CGColor];
    textfield.textColor = [UIColor darkGrayColor];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id currUserInfo = [shared valueForKey:@"userInfo"];
    self.firstName.text = currUserInfo[@"firstName"];
    self.lastName.text = currUserInfo[@"lastName"];
    self.email.text = currUserInfo[@"email"];
    self.address.text = currUserInfo[@"address1"];
    self.optionKeyTitle.text = currUserInfo[@"optionTitle"];
    self.optionContent.text = currUserInfo[@"optionContent"];
    self.city.text = currUserInfo[@"city"];
    self.state.text = currUserInfo[@"state"];
    self.zip.text = currUserInfo[@"zip"];
    self.phoneNum.text = currUserInfo[@"phoneNum"];
        
}


- (IBAction)finishAction:(id)sender {
    self.infoDict = @{@"firstName" : self.firstName.text, @"lastName" : self.lastName.text, @"email" : self.email.text ,@"address1" : self.address.text , @"city" : self.city.text ,@"state" : self.state.text ,@"zip" : self.zip.text, @"phoneNum": self.phoneNum.text, @"optionTitle":self.optionKeyTitle.text, @"optionContent": self.optionContent.text};
    
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    [shared setObject:self.infoDict forKey:@"userInfo"];
    [shared synchronize];
    
    // show an alert view
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"alert.updated_title", nil) message: NSLocalizedString(@"alert.updated_message", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okay = [UIAlertAction actionWithTitle: NSLocalizedString(@"okay", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }];
    [alert addAction:okay];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)clearAllAction:(id)sender {
    
    UIAlertController *clearAlert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"alert.clear_title", nil) message: NSLocalizedString(@"alert.clear_message", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *deleteAll = [UIAlertAction actionWithTitle: NSLocalizedString(@"yes", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // empty all the contents
        self.firstName.text = @"";
        self.lastName.text = @"";
        self.email.text = @"";
        self.address.text = @"";
        self.city.text = @"";
        self.state.text = @"";
        self.zip.text = @"";
        self.phoneNum.text = @"";
        self.optionKeyTitle.text = @"";
        self.optionContent.text = @"";
        self.infoDict = @{@"firstName" : self.firstName.text, @"lastName" : self.lastName.text, @"email" : self.email.text ,@"address1" : self.address.text , @"city" : self.city.text ,@"state" : self.state.text ,@"zip" : self.zip.text, @"phoneNum": self.phoneNum.text, @"optionTitle":self.optionKeyTitle.text, @"optionContent": self.optionContent.text};
        
        NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
        [shared setObject:self.infoDict forKey:@"userInfo"];
        [shared synchronize];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle: NSLocalizedString(@"cancel", nil)  style:UIAlertActionStyleCancel handler:nil];
    
    [clearAlert addAction:deleteAll];
    [clearAlert addAction:cancel];
    [self presentViewController:clearAlert animated:true completion:nil];
}


-(void)hideKeyboardWithTouch:(id)sender{
    
    [self.view endEditing:YES];
    
    // Scroll position Control
    [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.firstName){
        [self.lastName becomeFirstResponder];
    } else if (textField == self.lastName){
        [self.email becomeFirstResponder];
    } else if (textField == self.email){
        [self.address becomeFirstResponder];
        
    } else  if (textField == self.address){
        [self.city becomeFirstResponder];
        //    self.scrollView.contentSize = CGSizeMake(0.0, 50.0);
        
    } else if (textField == self.city){
        [self.state becomeFirstResponder];
        
    } else if (textField == self.state) {
        [self.zip becomeFirstResponder];
    } else if (textField == self.zip){
        [self.phoneNum becomeFirstResponder];
    } else if (textField == self.phoneNum){
        [self.optionKeyTitle becomeFirstResponder];
    } else if (textField == self.optionKeyTitle){
        [self.optionContent becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
        [self.scrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
        
    }
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.address) {
        [self.scrollView setContentOffset:CGPointMake(0.0, self.view.frame.size.height/4) animated:YES];
    } else if (textField == self.city || textField == self.zip || textField == self.state) {
        [self.scrollView setContentOffset:CGPointMake(0.0, self.view.frame.size.height/3) animated:YES];
    } else if (textField == self.zip || textField == self.optionKeyTitle || textField == self.optionContent) {
        [self.scrollView setContentOffset:CGPointMake(0.0, self.view.frame.size.height/2) animated:YES];
    }
}

// not allowing long key name
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.optionKeyTitle) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 15;
    }
    return YES;
}

@end
