//
//  ViewController.m
//  Keyboard
//
//  Created by yanshu on 15/10/21.
//  Copyright © 2015年 yanshu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_textField];
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
//键盘将要显示回调
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardBounds = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘动画的duration
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //获取键盘的高度，计算textField需要平移的高度
    CGFloat deltaY = keyboardBounds.size.height;
    //设置要执行动画的block
    void (^animations)() = ^{
        //平移TextField
        self.textField.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    };
    
    if (duration > 0) {
        NSUInteger options = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
        [UIView animateWithDuration:duration delay:0 options:options animations:animations completion:nil];
    } else {
        animations();
    }
    
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    //获取键盘动画的duration
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //设置要执行动画的block
    void (^animations)() = ^{
        self.textField.transform = CGAffineTransformIdentity;
    };
    
    if (duration > 0) {
        NSUInteger options = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
        [UIView animateWithDuration:duration delay:0 options:options animations:animations completion:nil];
    } else {
        animations();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
