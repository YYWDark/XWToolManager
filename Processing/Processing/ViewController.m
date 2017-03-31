//
//  ViewController.m
//  Processing
//
//  Created by wyy on 2017/3/31.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
//    UIImage *image = [UIImage imageNamed:@"7.jpg"];
//    //context 是重量器开销对象 你应该尽量的去重用它
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
//    CIImage *iImage = [CIImage imageWithCGImage:[image CGImage]];
//    
//    [filter setValue:iImage forKey:kCIInputImageKey];
//    CIImage *result = [filter outputImage];
//    CGImageRef resultRef = [context createCGImage:result fromRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:resultRef]];
//    imageView.frame = CGRectMake(10, 350, self.view.frame.size.width - 20, 300);
//    [self.view addSubview:imageView];
    
    
    UIImage *start = [UIImage imageNamed:@"7.jpg"];
    UIImage *target = [UIImage imageNamed:@"9.jpg"];
    
    CIImage *startImg = [CIImage imageWithCGImage:start.CGImage];
    CIImage *endImg = [CIImage imageWithCGImage:target.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CICopyMachineTransition" keysAndValues:
                        @"inputImage" , startImg,
                        @"inputTargetImage" , endImg,
                        @"inputTime" , @9.0, nil];
    
//    CATransition *transition = [CATransition animation];;
//    
//    transition.duration = 7.75;
//    transition.filter = filter;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *result = [filter outputImage];
    CGImageRef resultRef = [context createCGImage:result fromRect:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 350, self.view.frame.size.width - 20, 300)];
//    [imageView.layer addAnimation:transition forKey:kCATransition];
    
    imageView.image = [UIImage imageWithCGImage:resultRef];
    [self.view addSubview:imageView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
 Source
 
 ViewController.swift
 
 
 //
 //  ViewController.swift
 //  CoreImage013
 //
 
 import UIKit
 import CoreImage
 import Foundation
 
 extension UIImage{
 
 class func ResizeÜIImage(image : UIImage,width : CGFloat, height :
 CGFloat)-> UIImage!{
 
 // 指定された画像の大きさのコンテキストを用意.
 UIGraphicsBeginImageContext(CGSizeMake(width, height))
 
 // コンテキストに画像を描画する.
 image.drawInRect(CGRectMake(0, 0, width, height))
 
 // コンテキストからUIImageを作る.
 let newImage = UIGraphicsGetImageFromCurrentImageContext()
 
 // コンテキストを閉じる.
 UIGraphicsGetImageFromCurrentImageContext()
 
 return newImage
 }
 }
 
 class ViewController: UIViewController{
 // UIImageViewnの生成.
 var myImageView:UIImageView!
 var count = 0.0
 var myTime = NSNumber(double:0.0)
 let myFilter = CIFilter(name: "CICopyMachineTransition")
 
 // 画像遷移の時間処理.
 func update(timer: NSTimer) {
 
 count += 0.1
 myTime = count
 
 myFilter.setValue(myTime, forKey: kCIInputTimeKey)
 // 加工後の画像を得る.
 let myOutputImage = UIImage(CIImage: myFilter.outputImage)
 
 // 加工後の画像をUIImageViewに設定.
 myImageView.image = myOutputImage
 
 }
 
 override func viewDidLoad() {
 
 // UIImageViewを生成.
 myImageView = UIImageView(frame: self.view.bounds)
 self.view.addSubview(myImageView)
 
 // 変換元の画像と遷移の終着点の画像を生成.
 let CIImage1 = CIImage(image: UIImage.ResizeÜIImage(UIImage(named:"sample1.jpg")!,width: self.view.frame.maxX, height:self.view.frame.maxY))
 
 let CIImage2 = CIImage(image: UIImage.ResizeÜIImage(UIImage(named: "sample2.jpg")!, width: self.view.frame.maxX, height:self.view.frame.maxY))
 // トランジションカラーの指定.
 let myColor = CIColor(color: UIColor.greenColor())
 // コピーマシン要素の角度を指定するデフォルトは0.
 let myAngle = NSNumber(double: 0)
 // コピーマシン要素の幅を指定するデフォルトは1000.
 let myWidth = NSNumber(double: 200)
 
 myFilter.setValue(myColor, forKey: kCIInputColorKey)
 myFilter.setValue(myAngle, forKey: kCIInputAngleKey)
 myFilter.setValue(myWidth, forKey: kCIInputWidthKey)
 myFilter.setValue(CIImage1, forKey: kCIInputImageKey)
 myFilter.setValue(CIImage2, forKey: kCIInputTargetImageKey)
 var count = 0
 
 // Nstimerの設定.
 NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "update:", userInfo: nil, repeats: true)
 
 // 加工後の画像を得る.
 let myOutputImage = UIImage(CIImage: myFilter.outputImage)
 
 // 加工後の画像をUIImageViewに設定.
 myImageView.image = myOutputImage
 }
 
 }
 */

- (UIImage *)imageProcessedUsingCoreImage:(UIImage *)imageToProcess;
{
    /*
     NSArray *filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
     
     NSLog(@"Built in filters");
     for (NSString *currentFilterName in filterNames)
     {
     NSLog(@"%@", currentFilterName);
     }
     */
    
    CFAbsoluteTime elapsedTime, startTime = CFAbsoluteTimeGetCurrent();
    
    CIImage *inputImage = [[CIImage alloc] initWithCGImage:imageToProcess.CGImage];
    CIFilter *sepiaTone = [CIFilter filterWithName:@"CIAffineTransform" ];
    [sepiaTone setValue:inputImage forKey:kCIInputImageKey];
    [sepiaTone setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMake(0.7, 0.5, 0.3, 1.0, 0.0, 0.0)] forKey:@"inputTransform"];
    //    CIFilter *sepiaTone = [CIFilter filterWithName:@"CISepiaTone"
    //                                     keysAndValues: kCIInputImageKey, inputImage,
    //                           @"inputIntensity", [NSNumber numberWithFloat:.5],//它的默认值是1,最大可取值1,最小可取值0
    //                           nil];
    //    [sepiaTone setValue:[NSValue valueWithCGAffineTransform:CGAffineTransformMake(0.7, 0.5, 0.3, 1.0, 0.0, 0.0)] forKey:@"inputTransform"];
    
    CIImage *result = [sepiaTone outputImage];
    
    //    UIImage *resultImage = [UIImage imageWithCIImage:result]; // This gives a nil image, because it doesn't render, unless I'm doing something wrong
    CIContext *coreImageContext = [CIContext contextWithOptions:nil];
    
    CGImageRef resultRef = [coreImageContext createCGImage:result fromRect:CGRectMake(0, 0, imageToProcess.size.width, imageToProcess.size.height)];
    UIImage *resultImage = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    
    return resultImage;
}



- (UIImage *)applyFilterChain:(UIImage *)source {
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIPhotoEffectProcess" withInputParameters:@{kCIInputImageKey:[[CIImage alloc] initWithCGImage:source.CGImage]}];
    
    
    CIImage *bloomImage = [colorFilter.outputImage imageByApplyingFilter:@"CIBloom" withInputParameters:@{kCIInputRadiusKey : @(10.0),
                                                                                                          kCIInputIntensityKey:@(1.0)
                                                                                                          }];
    
    
    CGRect cropRect = CGRectMake(0, 0, 550, 550);
    CIImage *image = [bloomImage imageByCroppingToRect:cropRect];
    
    CIContext *coreImageContext = [CIContext contextWithOptions:nil];
    CGImageRef resultRef = [coreImageContext createCGImage:image fromRect:CGRectMake(0, 0, 550, 550)];
    UIImage *resultImage = [UIImage imageWithCGImage:resultRef];
    CGImageRelease(resultRef);
    
    return resultImage ;
}

- (UIImage*)createGrayCopy:(UIImage*)source {
    
    int width = source.size.width;
    int height = source.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceCMYK();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,  //bitmap的宽度,单位为像素
                                                  height, //bitmap的高度,单位为像素
                                                  8,      // 内存中像素的每个组件的位数.例如，对于32位像素格式和RGB 颜色空间，你应该将这个值设为8.
                                                  0,  //bitmap的每一行在内存所占的比特数
                                                  colorSpace,   // bitmap上下文使用的颜色空间。
                                                  kCGImageAlphaNone); //指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), source.CGImage);
    
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

-(UIImage*)makeSepiaScale:(UIImage*)image
{
    CGImageRef cgImage = [image CGImage];
    CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
    CFDataRef bitmapData = CGDataProviderCopyData(provider);
    UInt8* data = (UInt8*)CFDataGetBytePtr(bitmapData);
    
    int width = image.size.width;
    int height = image.size.height;
    NSInteger myDataLength = width * height * 4;
    
    
    for (int i = 0; i < myDataLength; i+=4)
    {
        UInt8 r_pixel = data[i];
        UInt8 g_pixel = data[i+1];
        UInt8 b_pixel = data[i+2];
        
        int outputRed = (r_pixel * .393) + (g_pixel *.769) + (b_pixel * .189);
        int outputGreen = (r_pixel * .349) + (g_pixel *.686) + (b_pixel * .168);
        int outputBlue = (r_pixel * .272) + (g_pixel *.534) + (b_pixel * .131);
        
        if(outputRed>255)outputRed=255;
        if(outputGreen>255)outputGreen=255;
        if(outputBlue>255)outputBlue=255;
        
        
        data[i] = outputRed;
        data[i+1] = outputGreen;
        data[i+2] = outputBlue;
    }
    
    CGDataProviderRef provider2 = CGDataProviderCreateWithData(NULL, data, myDataLength, NULL);
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider2, NULL, NO, renderingIntent);
    
    CGColorSpaceRelease(colorSpaceRef); // YOU CAN RELEASE THIS NOW
    CGDataProviderRelease(provider2); // YOU CAN RELEASE THIS NOW
    CFRelease(bitmapData);
    
    UIImage *sepiaImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef); // YOU CAN RELEASE THIS NOW
    return sepiaImage;
}
@end
