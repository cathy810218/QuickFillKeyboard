//
//  QuickFill.h
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 11/24/15.
//  Copyright © 2015 Cathy Oun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickFill : UIView
@property (strong, nonatomic) UIButton *firstName;
@property (strong, nonatomic) UIButton *lastName;
@property (strong, nonatomic) UIButton *email;
@property (strong, nonatomic) UIButton *phoneNum;
@property (strong, nonatomic) UIButton *address1;
@property (strong, nonatomic) UIButton *optionKey;
@property (strong, nonatomic) UIButton *city;
@property (strong, nonatomic) UIButton *state;
@property (strong, nonatomic) UIButton *zip;
@property (strong, nonatomic) UIButton *spaceKey;
@property (strong, nonatomic) UIButton *deleteKey;
@property (strong, nonatomic) UIButton *returnKey;
@property (strong, nonatomic) UIButton *nextKeyboard;
@property (strong, nonatomic) UILongPressGestureRecognizer *lpgr;

- (instancetype)initWithFrame:(CGRect)frame;

@end
