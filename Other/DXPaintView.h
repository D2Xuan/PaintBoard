//
//  DXPaintView.h
//  画板的实现 07
//
//  Created by Dengerxuan on 16/5/6.
//  Copyright © 2016年 Dengerxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DXBezierPath.h"

@interface DXPaintView : UIView
//定义线宽属性
@property (nonatomic ,assign) float lineW;
//定义颜色属性
@property (nonatomic ,strong) UIColor *lineC;
//清屏
- (void)clearAllLines;
//撤销
- (void)back;
//保存
- (UIImage *)snapScreen;

@end
