//
//  ViewController.m
//  DPAntiBlockingTextField
//
//  Created by jxchain on 2018/10/24.
//  Copyright © 2018 jxchain. All rights reserved.
//

#import "ViewController.h"
#import "DPAntiBlockingTextField.h"
@interface ViewController ()
@property (nonatomic,strong)DPAntiBlockingTextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _textField=[[DPAntiBlockingTextField alloc]initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, 500, 300, 40)];
    _textField.placeholder=@"测试文字";
    _textField.backgroundColor=[UIColor orangeColor];
    _textField.dp_offset=64;
    [self.view addSubview:_textField];
    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
