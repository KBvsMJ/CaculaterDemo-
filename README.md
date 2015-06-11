#1：简易计算器使用前需要操作步骤
a：把CaculaterModel文件夹和SNCaculaterView导入项目工程，并在项目中#import "SNCaculaterView.h"  #import "AdvancedCalculator.h"
b:在你故事版上拖拽两个view和一个textfield文本框（具体请看demo）
#2:具体使用方法
 [[SNCaculaterView shareInstance]showInView:self.contentView caculaterViewCompleteBlock:^(NSInteger selectBtnIndex, NSString *btnTitleText) 
 {
   NSLog(@"每个按钮对应的tag=%ld,按钮对应的标题=%@",selectBtnIndex,btnTitleText);

 }];
#3 演示图：
 ![image](https://github.com/KBvsMJ/CaculaterDemo-/demoGif/1.gif)

