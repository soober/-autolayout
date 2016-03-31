//
//  ViewController.m
//  代码实现autolayout
//
//  Created by syq on 15/12/27.
//  Copyright © 2015年 lanou.syq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIButton *but;
}

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"----%@",NSStringFromCGRect(but.frame));
//    [self visualFormatLanguage];
    
    [self visualFormatLanguageTest];
;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"----%@",NSStringFromCGRect(but.frame));
}



-(void)addCenterXYConstaint{
    but = [UIButton new];
    but.backgroundColor = [UIColor redColor];
    [self.view addSubview:but];
    //必须关闭当前视图的自动拉伸属性（系统默认，拉约束自动关闭）才能Autolayout
    but.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    //宽度高度：100
    //位置：居中
    /**
     *  给but添加代码约束
     *
     *  @param NSLayoutAttribute SB中每一根线代表一个约束对象
     *
     */
    //but的width = nil的width * 1.0 + 100 = 100
    NSLayoutConstraint *widthConsraint = [NSLayoutConstraint constraintWithItem:but attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    //加到自身上
    [but addConstraint:widthConsraint];
    //but的heigth = nil的heigth * 1.0 + 100 = 100
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:but attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [but addConstraint:heightConstraint];
    //中心相同
    //but的centerX = self.view的centerX * 1.0 + 0
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:but attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    //加到夫视图上
    [self.view addConstraint:centerX];
    //中心相同
    //but的centerY = self.view的centerY * 1.0 + 0
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:but attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:centerY];
}
-(void)addLeftConstaint{
    UIButton *blueBut = [UIButton new];
    blueBut.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueBut];
    UIButton *redBut = [UIButton new];
    redBut.backgroundColor = [UIColor redColor];
    [self.view addSubview:redBut];
    self.view.layoutMargins = UIEdgeInsetsMake(100, 100, 100, 100);
    NSLog(@"%@",NSStringFromUIEdgeInsets(self.view.layoutMargins));

    //必须关闭当前视图的自动拉伸属性（系统默认，拉约束自动关闭）才能Autolayout
    blueBut.translatesAutoresizingMaskIntoConstraints = NO;
    redBut.translatesAutoresizingMaskIntoConstraints = NO;
    //    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    //宽度高度：100
    //位置：居中
    
    /**
     *  给but添加代码约束
     *
     *  @param NSLayoutAttribute SB中没一根线代表一个约束对象
     *
     */
    //but的left = self.view的left * 1.0 + 20 = 20
    CGFloat margin = 20;
    NSLayoutConstraint *leftConsraint = [NSLayoutConstraint constraintWithItem:blueBut attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
    //加到自身上
    [self.view addConstraint:leftConsraint];
    
    //but的heigth = nil的heigth * 1.0 + 100 = 100
    NSLayoutConstraint *blueheightConstraint = [NSLayoutConstraint constraintWithItem:blueBut attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    [blueBut addConstraint:blueheightConstraint];
    
    
    NSLayoutConstraint *topConsraint = [NSLayoutConstraint constraintWithItem:blueBut attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin * 2];
    [self.view addConstraint:topConsraint];
    
//    NSLayoutConstraint *rightConsraint = [NSLayoutConstraint constraintWithItem:blueBut attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
//    [self.view addConstraint:rightConsraint];
    NSLayoutConstraint *rightConsraint = [NSLayoutConstraint constraintWithItem:blueBut attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:10];
    //旧的写法
//    [self.view addConstraint:rightConsraint];
    //新版方法1
//    [NSLayoutConstraint activateConstraints:@[rightConsraint]];
    //新版方法2
    rightConsraint.active = YES;


    
}
-(void)visualFormatLanguage{
    /**
     *  下面是两个具有代表性的语句示例：
     @"|-50-[buttonA(80@100)]-[buttonB(90@200)]-50-|"
     这条语句的含义是：“左右边距都为50，中间有两个按钮，相隔缺省宽度，一个控件宽度为80，约束优先级为100；另一个控件宽度为90，约束优先级为200”。实际运行后，发现buttonB的控件宽度为90，而buttonA的宽度为自适应宽度，并不是80像素；这是因为buttonB的约束优先级200大于buttonA的约束优先级，所以优先生效。可以把buttonA的优先级改的比buttonB大，就可以看到完全相反的结果。
     @"V:[buttonA(80)]-20-[buttonB(==buttonA)]"
     这条语句的含义是：“垂直方向有一个高度为80的buttonA，然后间隔20有一个和buttonA同样高度的buttonB”
     */
    UIButton *vflBut = [UIButton new];
    vflBut.backgroundColor = [UIColor cyanColor];
    vflBut.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:vflBut];
    
    UIButton *vflBut2 = [UIButton new];
    vflBut2.backgroundColor = [UIColor redColor];
    vflBut2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:vflBut2];

    
    
    NSArray *arr1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[vflBut(100)]-20-[vflBut2(==vflBut)]" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(vflBut,vflBut2)];
    [self.view addConstraints:arr1];
    //垂直方向的距离vflBut
     NSArray *arr2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[vflBut]-200-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(vflBut)];
    [self.view addConstraints:arr2];
    
    //给but2垂直方向的高度
    NSArray *arr3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[vflBut2(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(vflBut2)];
    [self.view addConstraints:arr3];


    
}
-(UIView *)redView{
    if (_redView == nil) {
        self.redView = [UIView new];
        _redView.backgroundColor = [UIColor redColor];
        _redView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _redView;
}
-(UIView *)blueView{
    if (_blueView == nil) {
        self.blueView = [UIView new];
        _blueView.backgroundColor = [UIColor blueColor];
        _blueView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _blueView;
}
/**
 *  VFL:属性view测试
 */
-(void)visualFormatLanguageTest{
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
    //VFL
    /**
     *  **注意：self.redView:vfl无法识别
     *  *@"H:|-20-[_redView]-20-[_blueView(_redView)]-20-|"
     *  *metrics:格式转换，识别Format中特殊标记
     *  options：两个VIew的对齐方式：NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom ：上面跟下面对齐
     */
    
    NSArray *verticalConstrain = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-magin-[_redView]-magin-[_blueView(_redView)]-magin-|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:@{@"magin":@20} views:NSDictionaryOfVariableBindings(_redView,_blueView)];
    [self.view addConstraints:verticalConstrain];
    
    NSArray *horizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_redView(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_redView)];
    [self.view addConstraints:horizontalConstraint];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
