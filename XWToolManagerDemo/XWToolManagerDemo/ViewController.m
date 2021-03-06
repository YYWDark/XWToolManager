//
//  ViewController.m
//  XWToolManagerDemo
//
//  Created by wyy on 2017/3/30.
//  Copyright © 2017年 wyy. All rights reserved.
//

#import "ViewController.h"
#import "XWToolManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XWToolManager *manager = [[XWToolManager alloc] init];
    [manager doSomething];
    UIImage *image = [self imageProcessedUsingCoreImage:[UIImage imageNamed:@"7.jpg"]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7.jpg"]];
    imageView.frame = CGRectMake(10, 40, self.view.frame.size.width - 20, 300);
    [self.view addSubview:imageView];
    
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image];
    imageView1.frame = CGRectMake(10, 350, self.view.frame.size.width - 20, 300);
    [self.view addSubview:imageView1];
    
    
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
