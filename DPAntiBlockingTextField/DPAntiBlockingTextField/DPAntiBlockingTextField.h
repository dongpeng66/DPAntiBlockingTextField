//
//  DPAntiBlockingTextField.h
//  DPAntiBlockingTextField
//
//  Created by jxchain on 2018/10/24.
//  Copyright © 2018 jxchain. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DPAntiBlockingTextField : UITextField
//上移后，textField需要额外高于键盘顶部的距离，默认为0
@property (nonatomic, assign) CGFloat dp_offset;
//真实的位置

@end

NS_ASSUME_NONNULL_END
