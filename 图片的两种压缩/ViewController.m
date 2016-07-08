//
//  ViewController.m
//  图片的两种压缩
//
//  Created by 王奥东 on 16/7/5.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    //测试压缩后的图片显示
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 200, 300, 200)];
    
    
    //第一种方式：压 - PNG 和 JPEG
//    UIImage *img = [self imageCompressOfMass:[UIImage imageNamed:@"天空-栏杆"]];
    
    
    //第二种方式：缩
    UIImage *img = [self imageCompressOfSize:[UIImage imageNamed:@"天空-栏杆"] andScaleWidth:300];
    
    
    
    
    
    imgView.image = img;
    [self.view addSubview:imgView];
    
    

}

/**
 *  压
 *  第一种方式：尺寸与像素不变，通过质量减少改变大小
 */
-(UIImage *)imageCompressOfMass:(UIImage *)image{
    
    //第一个参数为image，第二个为压缩系数
    //压缩系数越小体积越小，但是过小可能出现黑边等
    //建议0.3~0.7
    
    //两种方式，JPEG压缩后的体积小，但是质量影响大
    //PNG质量影响不大，但是压缩后的体积大
    //若对质量要求不是特别大，用JPEG即可，质量影响不是很大
    
    NSData * data = UIImageJPEGRepresentation(image, 0.3);
    
//    NSData * data = UIImagePNGRepresentation(image);
    
    UIImage *newImage = [UIImage imageWithData:data];

    return newImage;
}



/**
 *  缩
 *  第二种方式：改变尺寸与像素，质量不变来改变大小
 *  以上下文绘制的形式
 *  通过传进来的图片与要求的压缩后的宽度来计算绘制得到压缩后的图片
 *
 */
-(UIImage *)imageCompressOfSize:(UIImage *)image andScaleWidth:(CGFloat)scaleWidth {
    
    //获取图片的Size
    CGSize imgSize = image.size;
    //通过Size获取宽高
    CGFloat width = imgSize.width;
    CGFloat height = imgSize.height;
    //通过要求压缩后的宽度来计算比例，而后得到图片压缩后的高度
    CGFloat scaleHeight = (scaleWidth / width) * height;
    
    //开启上下文
    UIGraphicsBeginImageContext(CGSizeMake(scaleWidth, scaleHeight));
    //将图片绘制到上下文中
    [image drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
    //以图片形式获取上下文
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文，节省资源
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
















@end
