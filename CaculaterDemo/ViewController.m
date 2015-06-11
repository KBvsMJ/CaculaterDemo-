//
//  ViewController.m
//  CaculaterDemo
//
//  Created by MJ on 15/6/10.
//  Copyright (c) 2015年 SNWFMJ. All rights reserved.
//

#import "ViewController.h"
#import "SNCaculaterView.h"
#import "AdvancedCalculator.h"
@interface ViewController ()
{
     AdvancedCalculator *calculator;

}
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [[SNCaculaterView shareInstance]showInView:self.contentView caculaterViewCompleteBlock:^(NSInteger selectBtnIndex, NSString *btnTitleText) {
        
        if (selectBtnIndex !=1) {
            if ([btnTitleText isEqualToString:@"×"])
            {
                [self.calculator.input appendString:@"*"];
                
            }
            else if([btnTitleText isEqualToString:@"÷"])
            {
                [self.calculator.input appendString:@"/"];
            }
            else
            {
                [self.calculator.input appendString:btnTitleText];
            }
            
            NSMutableString *str = [NSMutableString stringWithString:self.textFieldResult.text];
            [str appendString:btnTitleText];
            self.calculator.screen = str;
            self.textFieldResult.text = str;
            
        }
        
        switch (selectBtnIndex)
        {
            case 1:
            {
                if (0 == [[self.textFieldResult.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
                    
                }else{
                    double d = [self.textFieldResult.text doubleValue];
                    NSMutableString *str;
                    if (d > 0) {
                        str = [NSMutableString stringWithFormat:@"%@%@",@"-",self.textFieldResult.text];
                    }else{
                        str = [NSMutableString stringWithString:[self.textFieldResult.text stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                    }
                    
                    self.calculator.screen = str;
                    self.calculator.input = str;
                    self.textFieldResult.text = str;
                }
                
            }
            break;
            case 2:
            {
                self.textFieldResult.text = [self.calculator percent:self.calculator.input];
                
                NSMutableString *tempStr = [NSMutableString stringWithString:self.textFieldResult.text];
                self.calculator.input = tempStr;
                self.calculator.screen = tempStr;
            }
                break;
            case 3:
            {
                self.textFieldResult.text = [self.calculator sqrt:self.calculator.input];
                
                //NSLog(@"after compute, inputText is %@", self.inputText.text);
                
                NSMutableString *tempStr = [NSMutableString stringWithString:self.textFieldResult.text];
                self.calculator.input = tempStr;
                
                self.calculator.screen = self.calculator.input;
                
            }
                break;
                
            case 19:
            {
                self.textFieldResult.text = @"";
                [self.calculator clearAll];
                break;
            }
            case 20:
            {
                //添加＝符号在输入的字符串中（因为已有的model的计算方式必须以=结尾
                NSMutableString *computeStr = [NSMutableString stringWithString:self.calculator.input];
                // [computeStr appendString:btnTitleText];
                NSLog(@"computeStr:%@", computeStr);
                
                self.textFieldResult.text = [self.calculator ExpressionCalculate:computeStr];
                NSLog(@"after compute, inputText is %@", self.textFieldResult.text);
                
                
                NSMutableString *tempStr = [NSMutableString stringWithString:self.textFieldResult.text];
                self.calculator.input = tempStr;
                self.calculator.screen = tempStr;//每次计算之后，将结果也保存在screen中
                break;
            }
                
            default:
                break;
        }
        

    }];
    
    
}
- (AdvancedCalculator *)calculator
{
    if (!calculator) {
        calculator = [[AdvancedCalculator alloc]init];
    }
    return calculator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
