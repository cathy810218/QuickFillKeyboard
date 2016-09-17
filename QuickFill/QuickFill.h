//
//  QuickFill.h
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 11/24/15.
//  Copyright © 2015 Cathy Oun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickFill : UIView
@property (weak, nonatomic) IBOutlet UIButton *firstName;
@property (weak, nonatomic) IBOutlet UIButton *lastName;
@property (weak, nonatomic) IBOutlet UIButton *email;
@property (weak, nonatomic) IBOutlet UIButton *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *address1;
@property (weak, nonatomic) IBOutlet UIButton *optionKey;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UIButton *state;
@property (weak, nonatomic) IBOutlet UIButton *zip;
@property (weak, nonatomic) IBOutlet UIButton *spaceKey;
@property (weak, nonatomic) IBOutlet UIButton *deleteKey;
@property (weak, nonatomic) IBOutlet UIButton *returnKey;
@property (weak, nonatomic) IBOutlet UIButton *nextKeyboard;
@property (weak, nonatomic) IBOutlet UILongPressGestureRecognizer *lpgr;


@end
