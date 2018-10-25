//
//  DPAntiBlockingTextField.m
//  DPAntiBlockingTextField
//
//  Created by jxchain on 2018/10/24.
//  Copyright © 2018 jxchain. All rights reserved.
//

#import "DPAntiBlockingTextField.h"
@interface DPAntiBlockingTextField()
@property (nonatomic, assign) CGRect dp_originalFrame;
@property (nonatomic,strong) UIView *dp_movingView;
@property (nonatomic,assign) BOOL isShow;
@end
@implementation DPAntiBlockingTextField
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addKeyboardNotifications];
        self.isShow=NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addKeyboardNotifications];
        self.isShow=NO;
    }
    return self;
}

- (void)addKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow: (NSNotification *)notification {
    if (self.isFirstResponder) {
        //因为这里会多次调用 所以需要 限制一次
        if (!self.isShow) {
            UIViewController *vc=[self viewControllerSupportView:self];
            UIView *superView=vc.view;
            self.dp_movingView=superView;
            CGRect relativeCGRect= [self convertRect:self.frame toView:[UIApplication sharedApplication].keyWindow];
            NSLog(@"----%f----%f----%f-----%f",superView.frame.size.width,superView.frame.size.height,superView.frame.origin.x,superView.frame.origin.y);
            CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            CGFloat overstep = CGRectGetHeight(self.frame) + relativeCGRect.origin.y/2 + keyboardHeight - CGRectGetHeight([UIScreen mainScreen].bounds);
            overstep += self.dp_offset;
            self.dp_originalFrame = self.dp_movingView.frame;
            if (overstep > 0) {
                CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
                CGRect frame = self.dp_originalFrame;
                frame.origin.y -= overstep;
                [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
                    self.dp_movingView.frame = frame;
                } completion: nil];
            }
            self.isShow=YES;
        }
        
    }
}

- (void)keyboardWillHide: (NSNotification *)notification {
    if (self.isFirstResponder) {
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration: duration delay: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            CGRect cc=self.dp_originalFrame;
            
            
            
            self.dp_movingView.frame = self.dp_originalFrame;
        } completion: nil];
        self.isShow=NO;
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (UIViewController *)viewControllerSupportView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
