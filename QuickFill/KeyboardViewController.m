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
@property (strong, nonatomic) NSDictionary *userInfo;

@property int timeCount;

@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    self.userInfo = [shared valueForKey:@"userInfo"];
    
    NSArray *keyboardRect = [shared arrayForKey:@"keyboardRect"];
    
    NSLog(@"found: %f, %f", [keyboardRect[0] floatValue], [keyboardRect[1] floatValue]);
    
    self.myKeyboard = [[QuickFill alloc] initWithFrame:CGRectMake(0, 0, [keyboardRect[0] floatValue], [keyboardRect[1] floatValue])];

    self.inputView = (UIInputView *)self.myKeyboard;

    self.inputView.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    [self addGestureToKeyboard];
    
    UIImage *globalImg = [UIImage imageNamed:@"gkey.png"];
    [self.myKeyboard.nextKeyboard setBackgroundImage:globalImg forState:UIControlStateNormal];
    [self.inputView addSubview:self.myKeyboard.nextKeyboard];
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
    if (self.userInfo[@"firstName"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"firstName"]];
    }
}

-(void)pressLastNameKey {
    if (self.userInfo[@"lastName"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"lastName"]];
    }
}

-(void)pressEmailKey {
    if (self.userInfo[@"email"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"email"]];
    }
}

-(void)pressPhoneKey {
    if (self.userInfo[@"phoneNum"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"phoneNum"]];
    }
}

-(void)pressAddress1Key {
    if (self.userInfo[@"address1"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"address1"]];
    }
}


- (void)pressOptionKey {
    if (self.userInfo[@"optionContent"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"optionContent"]];
    }
}

-(void)pressCityKey {
    if (self.userInfo[@"city"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"city"]];
    }
}

-(void)pressStateKey {
    if (self.userInfo[@"state"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"state"]];
    }
}

-(void)pressZipKey {
    if (self.userInfo[@"zip"]) {
        [self.textDocumentProxy insertText: self.userInfo[@"zip"]];
    }
}

@end
