//
//  SNCaculaterView.h
//  SNWF
//
//  Created by MJ on 15/6/11.
//  Copyright (c) 2015年 TJ. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  计算器按钮界面实现
 */
typedef void (^CaculaterViewCompleteHandler)(NSInteger selectBtnIndex,NSString *btnTitleText);
@interface SNCaculaterView : UIView
{
    CaculaterViewCompleteHandler myCompleteHandler;
}
/**
 *  单列对象
 *
 *  @return
 */
+ (SNCaculaterView *)shareInstance;
/**
 *  计算器按钮界面显示在某个页面
 *
 *  @param baseView        父视图
 *  @param completeHandler 回调主要用于传于按钮的tag和标题
 */

- (void)showInView:(UIView *)baseView caculaterViewCompleteBlock:(CaculaterViewCompleteHandler)completeHandler;
@end
