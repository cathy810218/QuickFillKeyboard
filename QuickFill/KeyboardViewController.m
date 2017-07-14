//
//  KeyboardViewController.m
//  QuickFill
//
//  Created by Cathy Oun on 11/24/15.
//  Copyright © 2015 Cathy Oun. All rights reserved.
//

#import "KeyboardViewController.h"
#import "QuickFill.h"
#import "InfoViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface KeyboardViewController ()
@property (strong, nonatomic) QuickFill *myKeyboard;
@property (strong, nonatomic) UIPasteboard *pasteboard;
@property (strong, nonatomic) NSTimer *timer;

@property int timeCount;

@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myKeyboard = [[QuickFill alloc] initWithFrame:CGRectMake(0, 0, 350, 200)];

    self.inputView = (UIInputView *)self.myKeyboard;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    self.inputView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

//    self.myKeyboard.bounds = CGRectMake(0, 0, 350, 200);

//    self.myKeyboard.nextKeyboard.layer.cornerRadius = 5.0;
//    self.myKeyboard.nextKeyboard.layer.masksToBounds = false;
//    self.myKeyboard.nextKeyboard.layer.shadowOpacity = 1.0;
//    self.myKeyboard.nextKeyboard.layer.shadowRadius = 0;
//    self.myKeyboard.nextKeyboard.layer.shadowOffset = CGSizeMake(0, 1.0);
//    self.myKeyboard.nextKeyboard.layer.shadowColor = [UIColor grayColor].CGColor;
    
//    [self setKeyboardKey:self.myKeyboard.city withKey: NSLocalizedString(@"city",nil)];
//    [self setKeyboardKey:self.myKeyboard.state withKey: NSLocalizedString(@"state",nil)];
//    [self setKeyboardKey:self.myKeyboard.zip withKey: NSLocalizedString(@"zip",nil)];
//    [self setKeyboardKey:self.myKeyboard.email withKey: NSLocalizedString(@"email",nil)];
//    [self setKeyboardKey:self.myKeyboard.address1 withKey: NSLocalizedString(@"address",nil)];
//    [self setKeyboardKey:self.myKeyboard.phoneNum withKey: NSLocalizedString(@"phoneNum",nil)];
//    [self setKeyboardKey:self.myKeyboard.firstName withKey: NSLocalizedString(@"firstName",nil)];
//    [self setKeyboardKey:self.myKeyboard.lastName withKey: NSLocalizedString(@"lastName",nil)];
//    [self setKeyboardKey:self.myKeyboard.spaceKey withKey: NSLocalizedString(@"space",nil)];
//    [self setKeyboardKey:self.myKeyboard.returnKey withKey: NSLocalizedString(@"return",nil)];
//    [self setKeyboardKey:self.myKeyboard.deleteKey withKey: NSLocalizedString(@"delete",nil)];
//    [self setKeyboardKey:self.myKeyboard.optionKey withKey: NSLocalizedString(@"optional", nil)];
    
    [self addGestureToKeyboard];
    
    UIImage *globalImg = [UIImage imageNamed:@"gkey.png"];
    [self.myKeyboard.nextKeyboard setBackgroundImage:globalImg forState:UIControlStateNormal];
    [self.inputView addSubview:self.myKeyboard.nextKeyboard];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
}

#pragma mark - Keyboards
- (void)addGestureToKeyboard {
    
    [self.myKeyboard.nextKeyboard addTarget:self
                                     action:@selector(advanceToNextInputMode)
                           forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.spaceKey addTarget:self
                                 action:@selector(pressSpaceKey)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.returnKey addTarget:self
                                  action:@selector(pressReturnKey)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.deleteKey addTarget:self
                                  action:@selector(touchBegin:)
                        forControlEvents:UIControlEventTouchDown];
    [self.myKeyboard.deleteKey addTarget:self
                                  action:@selector(touchEnd:)
                        forControlEvents: UIControlEventTouchCancel | UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragExit];
    
    [self.myKeyboard.firstName addTarget:self
                                  action:@selector(pressFirstNameKey)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.lastName addTarget:self
                                 action:@selector(pressLastNameKey)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.email addTarget:self
                              action:@selector(pressEmailKey)
                    forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.phoneNum addTarget:self
                                 action:@selector(pressPhoneKey)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.address1 addTarget:self
                                 action:@selector(pressAddress1Key)
                       forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.optionKey addTarget:self
                                  action:@selector(pressOptionKey)
                        forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.city addTarget:self
                             action:@selector(pressCityKey)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.state addTarget:self
                              action:@selector(pressStateKey)
                    forControlEvents:UIControlEventTouchUpInside];
    
    [self.myKeyboard.zip addTarget:self
                            action:@selector(pressZipKey)
                  forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)touchBegin:(UIButton*)sender {
    // set a timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.06
                                                  target:self
                                                selector:@selector(increaseTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)touchEnd:(UIButton*)sender {
    [self.timer invalidate];
    self.timer = nil;
    self.timeCount = 0;
}

- (void)increaseTimer {
    self.timeCount++;
    [self pressDeleteKey];
}

- (void)pressDeleteKey {
    if (self.timeCount < 6) {
        [self.textDocumentProxy deleteBackward];
    } else  {
        while ([self.textDocumentProxy documentContextBeforeInput].length > 0) {
            for (int i = 0; i < self.textDocumentProxy.documentContextBeforeInput.length; i++){
                [self.textDocumentProxy deleteBackward];
            }
        }
    }
}

- (void)pressSpaceKey {
    [self.textDocumentProxy insertText:@" "];
}

-(void)pressReturnKey {
    [self.textDocumentProxy insertText:@"\n"];
}

-(void)pressFirstNameKey{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"firstName"]) {
        [self.textDocumentProxy insertText: userInfo[@"firstName"]];
    }
}

-(void)pressLastNameKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"lastName"]) {
        [self.textDocumentProxy insertText: userInfo[@"lastName"]];
    }
}

-(void)pressEmailKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"email"]) {
        [self.textDocumentProxy insertText: userInfo[@"email"]];
    }
}

-(void)pressPhoneKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"phoneNum"]) {
        [self.textDocumentProxy insertText: userInfo[@"phoneNum"]];
    }
}

-(void)pressAddress1Key {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"address1"]) {
        [self.textDocumentProxy insertText: userInfo[@"address1"]];
    }
}


- (void)pressOptionKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"optionContent"]) {
        [self.textDocumentProxy insertText: userInfo[@"optionContent"]];
    }
}

-(void)pressCityKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"city"]) {
        [self.textDocumentProxy insertText: userInfo[@"city"]];
    }
}

-(void)pressStateKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"state"]) {
        [self.textDocumentProxy insertText: userInfo[@"state"]];
    }
}

-(void)pressZipKey {
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    if (userInfo[@"zip"]) {
        [self.textDocumentProxy insertText: userInfo[@"zip"]];
    }
}


@end
