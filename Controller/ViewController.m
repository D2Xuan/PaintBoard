//
//  ViewController.m
//  画板的实现 07
//
//  Created by Dengerxuan on 16/5/6.
//  Copyright © 2016年 Dengerxuan. All rights reserved.
//

#import "ViewController.h"
#import "DXPaintView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet DXPaintView *painView;

@property (nonatomic ,weak) IBOutlet UISlider *slider;

@property (nonatomic ,weak) IBOutlet UIButton *firstColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //MARK: - 设置初始线宽
    [self sliderValueChange:self.slider];
    
    //MARK: - 设置初始颜色
    [self colorBtnClick:self.firstColor];
    
 

}

#pragma mark - 其他功能的实现
//MARK: - 清屏
- (IBAction)clearSreenBtnClick {
    
    [self.painView clearAllLines];
}
//MARK: - 撤销
- (IBAction)removeLastLine {
    [self.painView back];
}
//MARK: - 橡皮擦
- (IBAction)eraser {
    
    self.painView.lineC = self.painView.backgroundColor;
}
//MARK: - 保存
- (IBAction)save {
    //获取截取的图片
    UIImage *Img = [self.painView snapScreen];
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(Img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//MARK: - 保存完成后弹出提醒框
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    //弹窗设置
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"保存成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertV addAction:action];
    [self presentViewController:alertV animated:YES completion:nil];
}
#pragma mark - 颜色按钮的点击事件
- (IBAction)colorBtnClick:(UIButton *)button {
    //获取按钮的背景颜色
    UIColor *aimColor = button.backgroundColor;
    //传给自定义画板
    self.painView.lineC = aimColor;
//    NSLog(@"%zd",button.tag);
    
}
#pragma mark - 监听滑块的改变
- (IBAction)sliderValueChange:(UISlider *)sender {
    //获取滑块的value值
    float value = sender.value;
    //传给自定义画板
    self.painView.lineW = value;
}


#pragma mark - 取消状态栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
