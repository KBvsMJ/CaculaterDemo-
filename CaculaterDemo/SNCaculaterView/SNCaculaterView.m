//
//  SNCaculaterView.m
//  SNWF
//
//  Created by MJ on 15/6/11.
//  Copyright (c) 2015年 TJ. All rights reserved.
//
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "SNCaculaterView.h"
#define kBtnTitleBlackColor  UIColorFromRGB(0x323335) //黑色字体
#define kBtnTitleWhiteColor  UIColorFromRGB(0xffffff) //白色字体
#define kBtnTitleFont [UIFont systemFontOfSize:30] //字体大小
#define kBtnGrayBackGroundColor UIColorFromRGB(0xd4d5d7) //灰色背景色
#define kBtnDeepGrayBackGroundColor UIColorFromRGB(0xc7c8ca) //灰色背景色
#define kBtnBlueBackGroundColor UIColorFromRGB(0x758dff) //蓝色背景色
#define KACBtnBackGroundColor UIColorFromRGB(0xb4b5b7) //灰色背景色
#define KEqualBtnBackGroundColor UIColorFromRGB(0x759cff) //灰色背景色
#define kRowCount 5   //行数
#define kColounCount 4  //列数
#define kPadding 1.0f   //按钮间距
#define kHeight 80.f  //按钮高度
@interface SNCaculaterView ()
{
    UIView *containerView; //容器view
    NSInteger btnClickNum; //按钮点击次数
}
@end
@implementation SNCaculaterView
+ (SNCaculaterView *)shareInstance
{
    static SNCaculaterView *caculaterInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        caculaterInstance =  [[SNCaculaterView alloc]init];
    });
    return caculaterInstance;

}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        
        [self setUp];
        
       
    }
    return self;
}
- (instancetype)init
{
    if (self = [super init])
    {
        
        [self setUp];
        
    }
    return self;
}
- (void)setUp
{
    ////////////////////////////////////containerView添加约束//////////////////////////////////////////
    containerView = [[UIView alloc]init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:containerView];
    NSDictionary *dic_Constaint = @{ @"containerViewHeight":@(kRowCount*kHeight+kRowCount-1),
                                     @"BtnHeight":@(kHeight)
                                     };
    NSArray *container_Constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)];
    NSArray *container_Constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[containerView(containerViewHeight)]-0-|" options:0 metrics:dic_Constaint views:NSDictionaryOfVariableBindings(containerView)];
    [self addConstraints:container_Constraint_H];
    [self addConstraints:container_Constraint_V];
    
    ////////////////////////////////////第一行按钮//////////////////////////////////////////
    /**正数负数按钮*/
    UIButton *PsitiveornetiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PsitiveornetiveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [PsitiveornetiveBtn setTitle:@"+/-" forState:UIControlStateNormal];
    [PsitiveornetiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    PsitiveornetiveBtn.backgroundColor = kBtnDeepGrayBackGroundColor;
    [PsitiveornetiveBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    PsitiveornetiveBtn.titleLabel.font = kBtnTitleFont;
    [PsitiveornetiveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    PsitiveornetiveBtn.tag = 1;
    [containerView addSubview:PsitiveornetiveBtn];
    NSArray *firstBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[PsitiveornetiveBtn(BtnHeight)]" options:0 metrics:dic_Constaint views:NSDictionaryOfVariableBindings(PsitiveornetiveBtn)];
    [containerView addConstraints:firstBtn_H];
    
    
    
    /**求余按钮*/
    UIButton *modBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    modBtn.translatesAutoresizingMaskIntoConstraints = NO;
    modBtn.backgroundColor = [UIColor yellowColor];
    [modBtn setTitle:@"%" forState:UIControlStateNormal];
    [modBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [modBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    modBtn.tag = 2;
    modBtn.backgroundColor = kBtnDeepGrayBackGroundColor;
    [modBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    modBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:modBtn];
    NSArray *secondBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[modBtn(BtnHeight)]" options:0 metrics:dic_Constaint views:NSDictionaryOfVariableBindings(modBtn)];
    [containerView addConstraints:secondBtn_H];
    
    
    /**开方按钮*/
    UIButton *sqrtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sqrtBtn.translatesAutoresizingMaskIntoConstraints = NO;
    sqrtBtn.backgroundColor = [UIColor yellowColor];
    [sqrtBtn setTitle:@"sqrt" forState:UIControlStateNormal];
    [sqrtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sqrtBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sqrtBtn.tag = 3;
    sqrtBtn.backgroundColor = kBtnDeepGrayBackGroundColor;
    [sqrtBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    sqrtBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:sqrtBtn];
    NSArray *thirdBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[sqrtBtn(BtnHeight)]" options:0 metrics:dic_Constaint views:NSDictionaryOfVariableBindings(sqrtBtn)];
    [containerView addConstraints:thirdBtn_H];
    
    
    
    /**除法按钮*/
    UIButton *divBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    divBtn.translatesAutoresizingMaskIntoConstraints = NO;
    divBtn.backgroundColor = [UIColor yellowColor];
    [divBtn setTitle:@"÷" forState:UIControlStateNormal];
    [divBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [divBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    divBtn.tag = 4;
    divBtn.backgroundColor = kBtnBlueBackGroundColor;
    [divBtn setTitleColor:kBtnTitleWhiteColor forState:UIControlStateNormal];
    divBtn.titleLabel.font = kBtnTitleFont;
    
    [containerView addSubview:divBtn];
    
    NSArray *divBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[divBtn(BtnHeight)]" options:0 metrics:dic_Constaint views:NSDictionaryOfVariableBindings(divBtn)];
    [containerView addConstraints:divBtn_H];
    
    NSDictionary *dic_binds = NSDictionaryOfVariableBindings(PsitiveornetiveBtn,modBtn,sqrtBtn,divBtn);
    NSDictionary *dic_firstBtnMargin = @{
                                         @"padding":@(kPadding)
                                         };
    NSArray *firstRowBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[PsitiveornetiveBtn]-padding-[modBtn(PsitiveornetiveBtn)]-padding-[sqrtBtn(modBtn)]-padding-[divBtn(sqrtBtn)]-0-|" options:0 metrics:dic_firstBtnMargin views:dic_binds];
    [containerView addConstraints:firstRowBtn_H];
    
    ////////////////////////////////////第二行按钮//////////////////////////////////////////
    /**数字“7”按钮*/
    UIButton *sevenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sevenBtn.translatesAutoresizingMaskIntoConstraints = NO;
    sevenBtn.backgroundColor = [UIColor yellowColor];
    [sevenBtn setTitle:@"7" forState:UIControlStateNormal];
    [sevenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sevenBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sevenBtn.tag = 5;
    sevenBtn.backgroundColor = kBtnGrayBackGroundColor;
    [sevenBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    sevenBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:sevenBtn];
    NSDictionary *dic_btnVMargin = @{
                                     @"padding":@(kPadding),
                                     @"BtnHeight":@(kHeight)
                                     };
    
    NSArray *sevenBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[PsitiveornetiveBtn]-padding-[sevenBtn(BtnHeight)]" options:0 metrics:dic_btnVMargin views:NSDictionaryOfVariableBindings(PsitiveornetiveBtn,sevenBtn)];
    [containerView addConstraints:sevenBtn_V];
    
    
    /**数字“8”按钮*/
    UIButton *eightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eightBtn.translatesAutoresizingMaskIntoConstraints = NO;
    eightBtn.backgroundColor = [UIColor yellowColor];
    [eightBtn setTitle:@"8" forState:UIControlStateNormal];
    [eightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [eightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    eightBtn.tag = 6;
    eightBtn.backgroundColor = kBtnGrayBackGroundColor;
    [eightBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    eightBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:eightBtn];
    
    NSArray *eightBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[modBtn]-padding-[eightBtn(BtnHeight)]" options:0 metrics:dic_btnVMargin views:NSDictionaryOfVariableBindings(modBtn,eightBtn)];
    [containerView addConstraints:eightBtn_V];
    
    /**数字“9”按钮*/
    UIButton *nineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nineBtn.translatesAutoresizingMaskIntoConstraints = NO;
    nineBtn.backgroundColor = [UIColor yellowColor];
    [nineBtn setTitle:@"9" forState:UIControlStateNormal];
    [nineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nineBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    nineBtn.tag = 7;
    nineBtn.backgroundColor = kBtnGrayBackGroundColor;
    [nineBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    nineBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:nineBtn];
    
    NSArray *nineBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sqrtBtn]-padding-[nineBtn(BtnHeight)]" options:0 metrics:dic_btnVMargin views:NSDictionaryOfVariableBindings(sqrtBtn,nineBtn)];
    [containerView addConstraints:nineBtn_V];
    
    
    
    /**操作运算符“x”按钮*/
    UIButton *multipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    multipBtn.translatesAutoresizingMaskIntoConstraints = NO;
    multipBtn.backgroundColor = [UIColor yellowColor];
    [multipBtn setTitle:@"×" forState:UIControlStateNormal];
    [multipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [multipBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    multipBtn.tag = 8;
    multipBtn.backgroundColor = kBtnBlueBackGroundColor;
    [multipBtn setTitleColor:kBtnTitleWhiteColor forState:UIControlStateNormal];
    multipBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:multipBtn];
    
    NSArray *multipBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[divBtn]-padding-[multipBtn(BtnHeight)]" options:0 metrics:dic_btnVMargin views:NSDictionaryOfVariableBindings(divBtn,multipBtn)];
    [containerView addConstraints:multipBtn_V];
    
    
    NSDictionary *secondRow_BtnBind = NSDictionaryOfVariableBindings(sevenBtn,eightBtn,nineBtn,multipBtn);
    NSDictionary *dic_secondRowHMargin = @{
                                           @"padding":@(kPadding)
                                           };
    
    NSArray *secondRow_BtnH =[ NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[sevenBtn]-padding-[eightBtn(sevenBtn)]-padding-[nineBtn(eightBtn)]-padding-[multipBtn(nineBtn)]-0-|" options:0 metrics:dic_secondRowHMargin views:secondRow_BtnBind];
    
    
    
    [containerView addConstraints:secondRow_BtnH];
    
    ////////////////////////////////////第三行按钮//////////////////////////////////////////
    /**数字“4”按钮*/
    UIButton *fourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fourBtn.translatesAutoresizingMaskIntoConstraints = NO;
    fourBtn.backgroundColor = [UIColor yellowColor];
    [fourBtn setTitle:@"4" forState:UIControlStateNormal];
    [fourBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fourBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    fourBtn.tag = 9;
    fourBtn.backgroundColor = kBtnGrayBackGroundColor;
    [fourBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    fourBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:fourBtn];
    NSDictionary *dic_thirdRowHMargin = @{
                                          @"padding":@(kPadding),
                                          @"BtnHeight":@(kHeight)
                                          };
    
    
    NSArray *fourBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[PsitiveornetiveBtn]-padding-[sevenBtn]-padding-[fourBtn(BtnHeight)]" options:0 metrics:dic_thirdRowHMargin views:NSDictionaryOfVariableBindings(PsitiveornetiveBtn,sevenBtn,fourBtn)];
    [containerView addConstraints:fourBtn_V];
    
    
    /**数字“5”按钮*/
    UIButton *fiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fiveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    fiveBtn.backgroundColor = [UIColor yellowColor];
    [fiveBtn setTitle:@"5" forState:UIControlStateNormal];
    [fiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fiveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    fiveBtn.tag = 10;
    fiveBtn.backgroundColor = kBtnGrayBackGroundColor;
    [fiveBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    fiveBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:fiveBtn];
    
    NSArray *fiveBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[modBtn]-padding-[eightBtn]-padding-[fiveBtn(BtnHeight)]" options:0 metrics:dic_thirdRowHMargin views:NSDictionaryOfVariableBindings(modBtn,eightBtn,fiveBtn)];
    [containerView addConstraints:fiveBtn_V];
    
    
    /**数字“6”按钮*/
    UIButton *sixBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sixBtn.translatesAutoresizingMaskIntoConstraints = NO;
    sixBtn.backgroundColor = [UIColor yellowColor];
    [sixBtn setTitle:@"6" forState:UIControlStateNormal];
    [sixBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sixBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sixBtn.tag = 11;
    sixBtn.backgroundColor = kBtnGrayBackGroundColor;
    [sixBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    sixBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:sixBtn];
    
    NSArray *sixBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sqrtBtn]-padding-[nineBtn]-padding-[sixBtn(BtnHeight)]" options:0 metrics:dic_thirdRowHMargin views:NSDictionaryOfVariableBindings(sqrtBtn,nineBtn,sixBtn)];
    [containerView addConstraints:sixBtn_V];
    
    
    /**操作运算符“-”按钮*/
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.translatesAutoresizingMaskIntoConstraints = NO;
    subBtn.backgroundColor = [UIColor yellowColor];
    [subBtn setTitle:@"-" forState:UIControlStateNormal];
    [subBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    subBtn.tag = 12;
    subBtn.backgroundColor = kBtnBlueBackGroundColor;
    [subBtn setTitleColor:kBtnTitleWhiteColor forState:UIControlStateNormal];
    subBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:subBtn];
    
    NSArray *subBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[divBtn]-padding-[multipBtn]-padding-[subBtn(BtnHeight)]" options:0 metrics:dic_thirdRowHMargin views:NSDictionaryOfVariableBindings(divBtn,multipBtn,subBtn)];
    [containerView addConstraints:subBtn_V];
    
    
    
    NSDictionary *thirdRow_BtnBind = NSDictionaryOfVariableBindings(fourBtn,fiveBtn,sixBtn,subBtn);
    
    
    NSArray *thirdRow_BtnH =[ NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[fourBtn]-padding-[fiveBtn(fourBtn)]-padding-[sixBtn(fiveBtn)]-padding-[subBtn(sixBtn)]-0-|" options:0 metrics:dic_thirdRowHMargin views:thirdRow_BtnBind];
    
    [containerView addConstraints:thirdRow_BtnH];
    
    
    
    
    ////////////////////////////////////第五行按钮//////////////////////////////////////////
    
    /**数字“0”按钮*/
    UIButton *zeroBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zeroBtn.translatesAutoresizingMaskIntoConstraints = NO;
    zeroBtn.backgroundColor = [UIColor yellowColor];
    [zeroBtn setTitle:@"0" forState:UIControlStateNormal];
    [zeroBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [zeroBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    zeroBtn.tag = 17;
    zeroBtn.backgroundColor = kBtnGrayBackGroundColor;
    [zeroBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    zeroBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:zeroBtn];
    NSDictionary *dic_fiveBtnMargin = @{
                                        @"padding":@(kPadding),
                                        @"BtnHeight":@(kHeight)
                                        
                                        };
    NSArray *zeroBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[zeroBtn(BtnHeight)]-0-|" options:0 metrics:dic_fiveBtnMargin views:NSDictionaryOfVariableBindings(zeroBtn)];
    [containerView addConstraints:zeroBtn_V];
    
    
    
    /**符号“.”按钮*/
    UIButton *dotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dotBtn.translatesAutoresizingMaskIntoConstraints = NO;
    dotBtn.backgroundColor = [UIColor yellowColor];
    [dotBtn setTitle:@"." forState:UIControlStateNormal];
    [dotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dotBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    dotBtn.tag = 18;
    dotBtn.backgroundColor = kBtnGrayBackGroundColor;
    [dotBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    dotBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:dotBtn];
    NSArray *dotBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dotBtn(BtnHeight)]-0-|" options:0 metrics:dic_fiveBtnMargin views:NSDictionaryOfVariableBindings(dotBtn)];
    [containerView addConstraints:dotBtn_V];
    
    
    
    /**操作符“AC”按钮*/
    UIButton *ACBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ACBtn.translatesAutoresizingMaskIntoConstraints = NO;
    ACBtn.backgroundColor = [UIColor yellowColor];
    [ACBtn setTitle:@"AC" forState:UIControlStateNormal];
    [ACBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ACBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    ACBtn.tag = 19;
    ACBtn.backgroundColor = KACBtnBackGroundColor;
    [ACBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    ACBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:ACBtn];
    NSArray *ACBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[ACBtn(BtnHeight)]-0-|" options:0 metrics:dic_fiveBtnMargin views:NSDictionaryOfVariableBindings(ACBtn)];
    [containerView addConstraints:ACBtn_V];
    
    
    
    /**等于符号“=”按钮*/
    UIButton *equalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    equalBtn.translatesAutoresizingMaskIntoConstraints = NO;
    equalBtn.backgroundColor = [UIColor yellowColor];
    [equalBtn setTitle:@"=" forState:UIControlStateNormal];
    [equalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [equalBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    equalBtn.tag = 20;
    equalBtn.backgroundColor = KEqualBtnBackGroundColor;
    [equalBtn setTitleColor:kBtnTitleWhiteColor forState:UIControlStateNormal];
    equalBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:equalBtn];
    NSArray *equalBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[equalBtn(BtnHeight)]-0-|" options:0 metrics:dic_fiveBtnMargin views:NSDictionaryOfVariableBindings(equalBtn)];
    [containerView addConstraints:equalBtn_V];
    
    NSDictionary *dic_fiveRowBtnBind = NSDictionaryOfVariableBindings(zeroBtn,
                                                                      dotBtn,
                                                                      ACBtn,
                                                                      equalBtn);
    
    
    
    NSArray *fiveRowBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[zeroBtn]-padding-[dotBtn(zeroBtn)]-padding-[ACBtn(dotBtn)]-padding-[equalBtn(ACBtn)]-0-|" options:0 metrics:dic_fiveBtnMargin views:dic_fiveRowBtnBind];
    
    
    [containerView addConstraints:fiveRowBtn_H];
    
    
    ////////////////////////////////////第四行按钮//////////////////////////////////////////
    
    /**数字“1”按钮*/
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.translatesAutoresizingMaskIntoConstraints = NO;
    firstBtn.backgroundColor = [UIColor yellowColor];
    [firstBtn setTitle:@"1" forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.tag = 13;
    firstBtn.backgroundColor = kBtnGrayBackGroundColor;
    [firstBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    firstBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:firstBtn];
    NSDictionary *dic_fourBtnMargin = @{
                                        @"padding":@(kPadding),
                                        @"BtnHeight":@(kHeight)
                                        };
    
    
    NSArray *firstBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[firstBtn(BtnHeight)]-padding-[zeroBtn]-0-|" options:0 metrics:dic_fourBtnMargin views:NSDictionaryOfVariableBindings(firstBtn,zeroBtn)];
    [containerView addConstraints:firstBtn_V];
    
    
    /**数字“2”按钮*/
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.translatesAutoresizingMaskIntoConstraints = NO;
    secondBtn.backgroundColor = [UIColor yellowColor];
    [secondBtn setTitle:@"2" forState:UIControlStateNormal];
    [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [secondBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.tag = 14;
    secondBtn.backgroundColor = kBtnGrayBackGroundColor;
    [secondBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    secondBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:secondBtn];
    
    NSArray *secondBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[secondBtn(BtnHeight)]-padding-[dotBtn]-0-|" options:0 metrics:dic_fourBtnMargin views:NSDictionaryOfVariableBindings(secondBtn,dotBtn)];
    [containerView addConstraints:secondBtn_V];
    
    
    
    /**数字“3”按钮*/
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.translatesAutoresizingMaskIntoConstraints = NO;
    thirdBtn.backgroundColor = [UIColor yellowColor];
    [thirdBtn setTitle:@"3" forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [thirdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn.tag = 15;
    thirdBtn.backgroundColor = kBtnGrayBackGroundColor;
    [thirdBtn setTitleColor:kBtnTitleBlackColor forState:UIControlStateNormal];
    thirdBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:thirdBtn];
    
    NSArray *thirdBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[thirdBtn(BtnHeight)]-padding-[ACBtn]-0-|" options:0 metrics:dic_fourBtnMargin views:NSDictionaryOfVariableBindings(thirdBtn,ACBtn)];
    [containerView addConstraints:thirdBtn_V];
    
    
    /**操作运算符“+”按钮*/
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.translatesAutoresizingMaskIntoConstraints = NO;
    addBtn.backgroundColor = [UIColor yellowColor];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = 16;
    addBtn.backgroundColor = kBtnBlueBackGroundColor;
    [addBtn setTitleColor:kBtnTitleWhiteColor forState:UIControlStateNormal];
    addBtn.titleLabel.font = kBtnTitleFont;
    [containerView addSubview:addBtn];
    
    NSArray *addBtn_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[addBtn(BtnHeight)]-padding-[equalBtn]-0-|" options:0 metrics:dic_fourBtnMargin views:NSDictionaryOfVariableBindings(addBtn,equalBtn)];
    [containerView addConstraints:addBtn_V];
    NSDictionary *dic_fourRowBtnBind = NSDictionaryOfVariableBindings(firstBtn,
                                                                      secondBtn,
                                                                      thirdBtn,
                                                                      addBtn);
    
    NSArray *fourRowBtn_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[firstBtn]-padding-[secondBtn(firstBtn)]-padding-[thirdBtn(secondBtn)]-padding-[addBtn(thirdBtn)]-0-|" options:0 metrics:dic_fourBtnMargin views:dic_fourRowBtnBind];
    
    
    [containerView addConstraints:fourRowBtn_H];
    
    
    
}
- (void)showInView:(UIView *)baseView caculaterViewCompleteBlock:(CaculaterViewCompleteHandler)completeHandler
{
    myCompleteHandler = completeHandler;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:self];
    NSArray *self_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    NSArray *self_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    [baseView addConstraints:self_H];
    [baseView addConstraints:self_V];
}
- (void)btnClick:(UIButton *)sender
{
    //对于正数负数按钮处理
    if (sender.tag == 1)
    {
        if (myCompleteHandler)
        {
            myCompleteHandler(1,@"");
        }
    }
    else
    {
        
        if (myCompleteHandler)
        {
            myCompleteHandler(sender.tag,sender.titleLabel.text);
        }
    }
}

@end
