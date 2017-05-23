//
//  AlertTableViewController.m
//  LEEAlertDemo
//
//  Created by 李响 on 2017/5/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "AlertTableViewController.h"

#import "LEEAlert.h"

@interface AlertTableViewController ()

@property (nonatomic , strong ) NSMutableArray *dataArray;

@end

@implementation AlertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Alert";
    
    self.dataArray = [NSMutableArray array];
    
    NSMutableArray *baseArray = [NSMutableArray array];
    
    NSMutableArray *demoArray = [NSMutableArray array];
    
    [self.dataArray addObject:baseArray];
    
    [self.dataArray addObject:demoArray];
    
    [baseArray addObject:@{@"title" : @"显示一个默认的 alert 弹框" , @"content" : @""}];
 
    [baseArray addObject:@{@"title" : @"显示一个带输入框的 alert 弹框" , @"content" : @"可以添加多个输入框."}];
    
    [baseArray addObject:@{@"title" : @"显示一个不同控件顺序的 alert 弹框" , @"content" : @"设置的顺序决定了控件显示的顺序."}];
    
    [baseArray addObject:@{@"title" : @"显示一个带自定义视图的 alert 弹框" , @"content" : @"自定义视图的size发生改变时 会自动适应其改变."}];
    
    [baseArray addObject:@{@"title" : @"显示一个横竖屏不同宽度的 alert 弹框" , @"content" : @"可以对横竖屏的最大宽度进行设置"}];
    
    [baseArray addObject:@{@"title" : @"显示一个自定义标题和内容的 alert 弹框" , @"content" : @"除了标题和内容 其他控件均支持自定义."}];
    
    [baseArray addObject:@{@"title" : @"显示一个多种action的 alert 弹框" , @"content" : @"action分为三种类型 可添加多个 设置的顺序决定了显示的顺序."}];
    
    [baseArray addObject:@{@"title" : @"显示一个自定义action的 alert 弹框" , @"content" : @"action的自定义属性可查看\"LEEAction\"类."}];
    
    [baseArray addObject:@{@"title" : @"显示一个可动态改变action的 alert 弹框" , @"content" : @"已经显示后 可再次对action进行调整"}];
    
    [baseArray addObject:@{@"title" : @"显示一个可动态改变标题和内容的 alert 弹框" , @"content" : @"已经显示后 可再次对其进行调整"}];
    
    [baseArray addObject:@{@"title" : @"显示两个加入队列的 alert 弹框" , @"content" : @"会根据显示队列中的先后顺序去显示 ,如果未加入队列 则不会再被显示"}];
    
    [demoArray addObject:@{@"title" : @"显示一个蓝色自定义风格的 alert 弹框" , @"content" : @"弹框背景等颜色均可以自定义"}];
}

#pragma mark - 自定义视图点击事件 (随机调整size)

- (void)viewTapAction:(UITapGestureRecognizer *)tap{
    
    CGFloat randomWidth = arc4random() % 240 + 10;
    
    CGFloat randomHeight = arc4random() % 400 + 10;
    
    CGRect viewFrame = tap.view.frame;
    
    viewFrame.size.width = randomWidth;
    
    viewFrame.size.height = randomHeight;
    
    tap.view.frame = viewFrame;
}

#pragma mark - 基础

- (void)base:(NSInteger)index{
    
    switch (index) {
            
        case 0:
        {
            [LEEAlert alert].config
            .LeeTitle(@"标题")
            .LeeContent(@"内容")
            .LeeCancelAction(@"取消", ^{
                
                // 取消点击事件Block
            })
            .LeeAction(@"确认", ^{
                
                // 确认点击事件Block
            })
            .LeeShow(); // 设置完成后 别忘记调用Show来显示
        }
            break;
            
        case 1:
        {
            // 使用一个变量接收自定义的输入框对象 以便于在其他位置调用
            
            __block UITextField *tf = nil;
            
            [LEEAlert alert].config
            .LeeAddTextField(^(UITextField *textField) {
                
                // 这里可以进行自定义的设置
                
                textField.placeholder = @"输入框";
                
                textField.textColor = [UIColor darkGrayColor];
                
                tf = textField; //赋值
            })
            .LeeTitle(@"标题")
            .LeeContent(@"内容")
            .LeeAction(@"好的", ^{
              
                [tf resignFirstResponder];
            })
            .LeeCancelAction(@"取消", nil) // 点击事件的Block如果不需要可以传nil
            .LeeShow();
        }
            break;
            
        case 2:
        {
            // 添加设置的顺序决定了显示的顺序 可根据需要去调整
            
            [LEEAlert alert].config
            .LeeAddTextField(nil) // 如果不需要其他设置 也可以传入nil 输入框会按照默认样式显示
            .LeeContent(@"内容1")
            .LeeTitle(@"标题")
            .LeeContent(@"内容2")
            .LeeAddTextField(^(UITextField *textField) {
                
                textField.placeholder = @"输入框2";
            })
            .LeeAction(@"好的", nil)
            .LeeCancelAction(@"取消", nil)
            .LeeShow();
        }
            break;
            
        case 3:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
            
            view.backgroundColor = [UIColor colorWithRed:43/255.0f green:133/255.0f blue:208/255.0f alpha:1.0f];
            
            [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapAction:)]];
            
            [LEEAlert alert].config
            .LeeTitle(@"标题")
            .LeeAddCustomView(^(LEECustomView *custom) {
                
                custom.view = view;
                
                custom.positionType = LEECustomViewPositionTypeCenter;
            })
            .LeeItemInsets(UIEdgeInsetsMake(30, 10, 30, 10)) // 想为哪一项设置间距范围 直接在其后面设置即可 ()
            .LeeContent(@"内容")
            .LeeItemInsets(UIEdgeInsetsMake(10, 10, 10, 10)) // 这个间距范围就是对content设置的
            .LeeAddTextField(^(UITextField *textField) {
                
                textField.placeholder = @"输入框";
            })
            .LeeAction(@"确认", nil)
            .LeeCancelAction(@"取消", nil)
            .LeeShow();
        }
            break;
            
        case 4:
        {
            // 宽度发生变化 标题和内容的高度也会自动适应 无需操心
            
            [LEEAlert alert].config
            .LeeTitle(@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题")
            .LeeContent(@"内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容")
            .LeeAddTextField(^(UITextField *textField) {
                
                textField.placeholder = @"输入框";
            })
            .LeeCancelAction(@"取消", ^{
                
            })
            .LeeAction(@"确认", ^{
                
            })
            .LeeConfigMaxWidth(^CGFloat (LEEScreenOrientationType type) {
                
                switch (type) {
                        
                    case LEEScreenOrientationTypeHorizontal:
                        
                        // 横屏时最大宽度
                        
                        return CGRectGetWidth([[UIScreen mainScreen] bounds]) * 0.7f;
                        
                        break;
                    
                    case LEEScreenOrientationTypeVertical:
                        
                        // 竖屏时最大宽度
                        
                        return CGRectGetWidth([[UIScreen mainScreen] bounds]) * 0.9f;
                        
                        break;
                        
                    default:
                        return 0.0f;
                        break;
                }
            })
            .LeeShow();
        }
            break;
            
        case 5:
        {
            [LEEAlert alert].config
            .LeeAddTitle(^(UILabel *label) {
                
                label.text = @"已经退出该群组";
                
                label.textColor = [UIColor darkGrayColor];
                
                label.textAlignment = NSTextAlignmentLeft;
            })
            .LeeAddContent(^(UILabel *label) {
                
                label.text = @"以后将不会再收到该群组的任何消息";
                
                label.textColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
                
                label.textAlignment = NSTextAlignmentLeft;
            })
            .LeeAction(@"好的", nil)
            .LeeShow();
        }
            break;
            
        case 6:
        {
            [LEEAlert alert].config
            .LeeTitle(@"这是一个alert 它有三个不同类型的action!")
            .LeeAction(@"一个默认action", ^{
                
                // 点击事件Block
            })
            .LeeDestructiveAction(@"一个销毁action", ^{
                
                // 点击事件Block
            })
            .LeeCancelAction(@"一个取消action", ^{
                
                // 点击事件Block
            })
            .LeeShow();
        }
            break;
            
        case 7:
        {
            [LEEAlert alert].config
            .LeeTitle(@"自定义 Action 的 Alert!")
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeDefault;
                
                action.title = @"自定义";
                
                action.titleColor = [UIColor brownColor];
                
                action.highlight = @"被点啦";
                
                action.highlightColor = [UIColor orangeColor];
                
                action.image = [UIImage imageNamed:@"smile"];
                
                action.highlightImage = [UIImage imageNamed:@"tongue"];
                
                action.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
                
                action.height = 60.0f;
                
                action.clickBlock = ^{
                    
                    // 点击事件Block
                };
                
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeDefault;
                
                action.title = @"自定义";
                
                action.titleColor = [UIColor orangeColor];
                
                action.highlightColor = [UIColor brownColor];
                
                action.image = [UIImage imageNamed:@"smile"];
                
                action.highlightImage = [UIImage imageNamed:@"tongue"];
                
                action.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
                
                action.height = 60.0f;
                
                action.clickBlock = ^{
                    
                    // 点击事件Block
                };
                
            })
            .LeeShow();
        }
            break;
            
        case 8:
        {
            __block LEEAction *tempAction = nil;
            
            [LEEAlert alert].config
            .LeeContent(@"点击改变 第一个action会长高哦")
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"我是action";
                
                tempAction = action;
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"改变";
                
                action.isClickNotClose = YES; // 设置点击不关闭 (仅适用于默认类型的action)
                
                action.clickBlock = ^{
                    
                    tempAction.height += 40;
                    
                    tempAction.title = @"我长高了";
                    
                    tempAction.titleColor = [UIColor redColor];
                    
                    [tempAction update]; // 更改设置后 调用更新
                };
            })
            .LeeCancelAction(@"取消", nil)
            .LeeShow();
        }
            break;
            
        case 9:
        {
            __block UILabel *tempTitle = nil;
            __block UILabel *tempContent = nil;
            
            [LEEAlert alert].config
            .LeeAddTitle(^(UILabel *label) {
                
                label.text = @"动态改变标题和内容的alert";
                
                tempTitle = label;
            })
            .LeeAddContent(^(UILabel *label) {
                
                label.text = @"点击调整 action 即可改变";
                
                tempContent = label;
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.title = @"调整";
                
                action.isClickNotClose = YES; // 设置点击不关闭 (仅适用于默认类型的action)
                
                action.clickBlock = ^{
                    
                    tempTitle.text = @"一个改变后的标题 ...................................................................";
                    
                    tempTitle.textColor = [UIColor grayColor];
                    
                    tempTitle.textAlignment = NSTextAlignmentLeft;
                    
                    tempContent.text = @"一个改变后的内容";
                    
                    tempContent.textColor = [UIColor lightGrayColor];
                    
                    tempContent.textAlignment = NSTextAlignmentLeft;
                    
                    // 其他控件同理 ,
                };
                
            })
            .LeeCancelAction(@"取消" , nil)
            .LeeShow();
        }
            break;
            
        case 10:
        {
            // 第一个显示时 第二个也显示了 这时会隐藏第一个 ,在第二个显示结束后再将第一个显示出来
            
            [LEEAlert alert].config
            .LeeTitle(@"alert 1")
            .LeeCancelAction(@"取消", nil)
            .LeeAction(@"确认", nil)
            .LeeAddQueue()
            .LeeShow();
            
            
            [LEEAlert alert].config
            .LeeTitle(@"alert 2")
            .LeeCancelAction(@"取消", nil)
            .LeeAction(@"确认", nil)
            .LeeAddQueue()
            .LeeShow();
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - demo

- (void)demo:(NSInteger)index{
    
    switch (index) {
            
        case 0:
        {
            UIColor *blueColor = [UIColor colorWithRed:90/255.0f green:154/255.0f blue:239/255.0f alpha:1.0f];
            
            [LEEAlert alert].config
            .LeeAddTitle(^(UILabel *label) {
                
                label.text = @"确认删除?";
                
                label.textColor = [UIColor whiteColor];
            })
            .LeeAddContent(^(UILabel *label) {
                
                label.text = @"删除后将无法恢复, 请慎重考虑";
                
                label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75f];
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeCancel;
                
                action.title = @"取消";
                
                action.titleColor = blueColor;
                
                action.backgroundColor = [UIColor whiteColor];
                
                action.clickBlock = ^{
                    
                    // 取消点击事件Block
                };
            })
            .LeeAddAction(^(LEEAction *action) {
                
                action.type = LEEActionTypeDefault;
                
                action.title = @"删除";
                
                action.titleColor = blueColor;
                
                action.backgroundColor = [UIColor whiteColor];
                
                action.clickBlock = ^{
                    
                    // 删除点击事件Block
                };
            })
            .LeeHeaderColor(blueColor)
            .LeeShow();
        }
            break;
            
        case 1:
        {
           
        }
            break;
            
        case 2:
        {
           
        }
            break;
            
        case 3:
        {
            
        }
            break;
            
        case 4:
        {
            
        }
            break;
            
        case 5:
        {
            
        }
            break;
            
        case 6:
        {
            
        }
            break;
            
        case 7:
        {
            
        }
            break;
            
        case 8:
        {
            
        }
            break;
            
        case 9:
        {
            
        }
            break;
            
        case 10:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary *info = self.dataArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = info[@"title"];
    
    cell.detailTextLabel.text = info[@"content"];
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        
        case 0:
            
            return @"基础";
            
            break;
            
        case 1:
            
            return @"Demo";
            
            break;
            
        default:
            
            return @"";
            
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        
        case 0:
        
            [self base:indexPath.row];
            
            break;
            
        case 1:
            
            [self demo:indexPath.row];
            
            break;
            
        default:
            break;
    }
    
}

@end
