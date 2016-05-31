//
//  DXPaintView.m
//  画板的实现 07
//
//  Created by Dengerxuan on 16/5/6.
//  Copyright © 2016年 Dengerxuan. All rights reserved.
//

#import "DXPaintView.h"
#import "DXBezierPath.h"
@interface DXPaintView ()

//设置路径属性
@property (nonatomic ,strong) DXBezierPath *path;

//定义一个可变数组
@property (nonatomic ,strong) NSMutableArray<DXBezierPath *> *pathArrM;

@end
@implementation DXPaintView

//MARK: - 清屏
- (void)clearAllLines {
    //移除数组中所有的元素
    [self.pathArrM removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}
//MARK: - 撤销
- (void)back {
    //移除数组中最后一个元素
    [self.pathArrM removeLastObject];
    //重绘
    [self setNeedsDisplay];
}
//MARK: - 截屏
- (UIImage *)snapScreen {
    //开启图形上下文
    UIGraphicsBeginImageContext(self.frame.size);
    //获取上下文
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    //将试图的layer渲染到上下文中
    [self.layer renderInContext:cxtRef];
    //获取图片
    UIImage *snapImg = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return snapImg;
}
#pragma mark - 开始触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取触摸对象
    UITouch *touch = touches.anyObject;
    //获取触摸点
    CGPoint loc = [touch locationInView:self];
    //创建路径对象
    self.path = [DXBezierPath bezierPath];
    //设置起点
    [self.path moveToPoint:loc];
    
    //将路径添加到可变数组中
    [self.pathArrM addObject:self.path];
    
    //MARK: - 设置线宽
    self.path.lineWidth = self.lineW;
    //MARK: - 设置路径颜色
    self.path.lineColor = self.lineC;
    
//    NSLog(@"%@",@[self.path.lineColor]);
    
}
#pragma mark - 开始移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取触摸对象
    UITouch *touch = touches.anyObject;
    //获取触摸点
    CGPoint loc = [touch locationInView:self];
    //添加到路径
    [self.path addLineToPoint:loc];
   
    //重绘
    [self setNeedsDisplay];
}



#pragma mark - 绘图
- (void)drawRect:(CGRect)rect {
    //遍历数组
    [self.pathArrM enumerateObjectsUsingBlock:^(DXBezierPath *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@",@[self.path.lineColor]);
        [obj.lineColor setStroke];
        [obj stroke];
    }];
//    [self.path stroke];
}

#pragma mark - 懒加载
- (NSMutableArray *)pathArrM {
    if (_pathArrM == nil) {
        _pathArrM = [NSMutableArray array];
    }
    return _pathArrM;
}
@end
