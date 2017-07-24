//
//  QuickFill.m
//  QuickFillKeyboard
//
//  Created by Cathy Oun on 11/24/15.
//  Copyright © 2015 Cathy Oun. All rights reserved.
//

#import "QuickFill.h"
#import <Masonry/Masonry.h>
#import "UIColor+Hex.h"
@implementation QuickFill

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"#D1D5DA"];
        [self drawKeys];
    }
    return self;
}

- (void)drawKeys {
    CGFloat keyboardHeight =  self.bounds.size.height;
    CGFloat margin = 8.0f;
    CGFloat buttonHeight = (keyboardHeight - (margin * 6.0)) / 5.0;
    
    self.firstName = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.firstName];
    self.lastName = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.lastName];
    self.deleteKey = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.deleteKey];
    self.email = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.email];
    self.phoneNum = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.phoneNum];
    self.address1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.address1];
    self.optionKey = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.optionKey];
    self.city = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.city];
    self.state = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.state];
    self.zip = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.zip];
    self.nextKeyboard = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.nextKeyboard];
    self.spaceKey = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.spaceKey];
    self.returnKey = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.returnKey];
    
    [self.firstName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(buttonHeight);
        make.left.top.mas_equalTo(margin);
        make.right.equalTo(self.lastName.mas_left).offset(-margin);
    }];
    
    [self.lastName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.equalTo(self.firstName);
        make.right.equalTo(self.deleteKey.mas_left).offset(-margin);
        make.width.equalTo(self.firstName);
    }];
    
    [self.deleteKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.equalTo(self.firstName);
        make.right.mas_equalTo(-margin);
        make.width.equalTo(self).multipliedBy(0.25);
    }];
    self.deleteKey.backgroundColor = [UIColor colorFromHexString:@"#ACB3BC"];
    
    [self.email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.top.equalTo(self.firstName.mas_bottom).offset(margin);
        make.left.mas_equalTo(margin);
        make.right.equalTo(self.phoneNum.mas_left).offset(-margin);
    }];
    
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.width.equalTo(self.email);
        make.right.mas_equalTo(-margin);
    }];
    
    [self.address1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.top.equalTo(self.email.mas_bottom).offset(margin);
        make.left.mas_equalTo(margin);
        make.right.equalTo(self.phoneNum.mas_left).offset(-margin);
    }];
    
    [self.optionKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.width.equalTo(self.address1);
        make.right.mas_equalTo(-margin);
    }];
    
    [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.left.mas_equalTo(margin);
        make.right.equalTo(self.state.mas_left).offset(-margin);
        make.top.greaterThanOrEqualTo(self.address1.mas_bottom).offset(margin);
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.equalTo(self.city);
        make.right.equalTo(self.zip.mas_left).offset(-margin);
        make.width.equalTo(self.city);
    }];
    
    [self.zip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.equalTo(self.city);
        make.right.mas_greaterThanOrEqualTo(-margin);
        make.width.equalTo(self.city);
    }];
    
    [self.nextKeyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.width.equalTo(@60);
        make.left.mas_equalTo(margin);
        make.top.equalTo(self.city.mas_bottom).offset(margin);
        make.right.equalTo(self.spaceKey.mas_left).offset(-margin);
        make.bottom.mas_equalTo(-margin);
    }];
    self.nextKeyboard.backgroundColor = [UIColor colorFromHexString:@"#ACB3BC"];
    self.nextKeyboard.layer.cornerRadius = 5.0;
    self.nextKeyboard.layer.masksToBounds = NO;
    self.nextKeyboard.layer.shadowOpacity = 1.0;
    self.nextKeyboard.layer.shadowRadius = 0;
    self.nextKeyboard.layer.shadowOffset = CGSizeMake(0, 1.0);
    self.nextKeyboard.layer.shadowColor = [UIColor grayColor].CGColor;
    UIImage *globalImg = [UIImage imageNamed:@"gkey.png"];
    [self.nextKeyboard setBackgroundImage:globalImg forState:UIControlStateNormal];
    
    [self.spaceKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.width.equalTo(self.address1);
        make.centerY.equalTo(self.nextKeyboard);
        make.right.equalTo(self.returnKey.mas_left).offset(-margin);
    }];
    
    [self.returnKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.firstName);
        make.centerY.equalTo(self.nextKeyboard);
        make.right.mas_equalTo(-margin);
    }];
    self.returnKey.backgroundColor = [UIColor colorFromHexString:@"#ACB3BC"];
    
    [self setKeyboardKey:self.city withKey: NSLocalizedString(@"city",nil)];
    [self setKeyboardKey:self.state withKey: NSLocalizedString(@"state",nil)];
    [self setKeyboardKey:self.zip withKey: NSLocalizedString(@"zip",nil)];
    [self setKeyboardKey:self.email withKey: NSLocalizedString(@"email",nil)];
    [self setKeyboardKey:self.address1 withKey: NSLocalizedString(@"address",nil)];
    [self setKeyboardKey:self.phoneNum withKey: NSLocalizedString(@"phoneNum",nil)];
    [self setKeyboardKey:self.firstName withKey: NSLocalizedString(@"firstName",nil)];
    [self setKeyboardKey:self.lastName withKey: NSLocalizedString(@"lastName",nil)];
    [self setKeyboardKey:self.spaceKey withKey: NSLocalizedString(@"space",nil)];
    [self setKeyboardKey:self.returnKey withKey: NSLocalizedString(@"return",nil)];
    [self setKeyboardKey:self.deleteKey withKey: NSLocalizedString(@"delete",nil)];
    [self setKeyboardKey:self.optionKey withKey: NSLocalizedString(@"optional", nil)];
    
}

- (void)setKeyboardKey:(UIButton *)btn withKey:(NSString *)name{
    btn.layer.cornerRadius = 5.0;
    btn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btn.layer.shadowOpacity = 1.0;
    btn.layer.shadowRadius = 0;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    btn.layer.shadowOffset = CGSizeMake(0, 1.0);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    btn.backgroundColor = [UIColor colorFromHexString:@"#FFFFFF"];
//    [btn setBackgroundImage:[self imageWithColor:UIColor.lightGrayColor] forState:UIControlStateHighlighted];
    btn.layer.masksToBounds = NO;

    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.cathyoun.QuickFillKeyboard"];
    id userInfo = [shared valueForKey:@"userInfo"];
    
    if (userInfo[@"optionTitle"]) {
        [self.optionKey setTitle:userInfo[@"optionTitle"] forState:UIControlStateNormal];
    }
    
    if ([name isEqualToString:@"Delete"] || [name isEqualToString:@"Return"]) {
        btn.layer.shadowColor = [UIColor grayColor].CGColor;
    }
}

-(void)drawRect:(CGRect)rect {
    NSLog(@"draw rect");
}

//- (UIImage *)imageWithColor:(UIColor *)color {
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}



@end
