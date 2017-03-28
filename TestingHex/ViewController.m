//
//  ViewController.m
//  TestingHex
//
//  Created by Jony on 16/10/31.
//  Copyright © 2016年 Jony. All rights reserved.
//

#import "ViewController.h"
Byte buff[4];

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *hexString = @"0xFF";
//
//    unsigned long red = strtoul([hexString UTF8String],0,16);
//    NSLog(@"转换完的数字为：%ld",red);
    [self stringToHex:@"8AFF00A1"];
    NSString *str = [NSString string];
    for (int i = 0; i<4; i++) {
        str = [NSString stringWithFormat:@"%@%c*",str, buff[i]];
    }
    NSLog(@"%@",str);
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)stringToHex:(NSString *)string
{
    int j=0;
    for (NSInteger i = 0; i<string.length; i+=2) {
        NSLog(@"i= %ld, ", i);
        NSRange rang;
        rang.location = i;
        rang.length = 2;
        NSString *tempStr = [string substringWithRange:rang];
        NSLog(@"tempstr = %@", tempStr);
        buff[j++] = strtoul([tempStr UTF8String],0,16);//部分十六进制无法转换字符，在ASCII中有保留，尽量以字节或十进制做中间值，存储尽量以十六进制存储
    }
}


//- (NSString *)stringFromHexString:(NSString *)hexString { //
//    
//    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
//    bzero(myBuffer, [hexString length] / 2 + 1);
//    for (int i = 0; i < [hexString length] - 1; i += 2) {
//        unsigned int anInt;
//        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
//        NSScanner * scanner = [[[NSScanner alloc] initWithString:hexCharStr] autorelease];
//        [scanner scanHexInt:&anInt];
//        myBuffer[i / 2] = (char)anInt;
//    }
//    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
//    NSLog(@"------字符串=======%@",unicodeString);
//    return unicodeString; 
//    
//    
//}
//将十六进制的字符串转换成NSString则可使用如下方式:
- (NSString *)convertHexStrToString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
        NSLog(@"return 88888888");
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSLog(@"转换完的数字为：%lx",anInt);
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
     NSLog(@"转换完的nsdata为：%@",hexData);
    NSString *string = [[NSString alloc]initWithData:hexData encoding:NSUTF8StringEncoding];
    NSLog(@"->%@", string);
    return string;
}

@end
