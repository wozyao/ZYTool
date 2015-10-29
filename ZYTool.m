//
//  ZYTool.m
//  ZYToolClass
//
//  Created by 郑遥 on 15/9/22.
//  Copyright © 2015年 郑遥. All rights reserved.
//

#import "ZYTool.h"
#import "RegexKitLite.h"

@implementation ZYTool

#pragma mark - 判断是否是中文用户名
+ (BOOL)validateNickname:(NSString *)nickname

{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:nickname];
}

#pragma mark - 判断是否已成年
+ (BOOL)isManhoodWithCertID:(NSString *)certID
{
    NSRange range = NSMakeRange(6, 8);
    certID = [certID substringWithRange:range];
    
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = @"yyyyMMdd";
    
    //出生日期
    NSDate *burnDate = [dateF dateFromString:certID];
    
    //当前日期
    NSDate *dateNow = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:burnDate
                                                 toDate:dateNow
                                                options:0];
    if (components.year >= 18) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 判断手机号码格式是否正确
+ (BOOL)isValidTelNum:(NSString *)telNum
{
    NSArray *array = [telNum componentsMatchedByRegex:@"1[34578]\\d{9}"];
    if (array.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 判断是否为正整数
+ (BOOL)isPositiveInteger:(NSString *)number
{
    NSString *Regex = @"^[1-9]\\d*$";
    
    NSPredicate *PositiveIntegerPridi = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [PositiveIntegerPridi evaluateWithObject:number];
}

#pragma mark - 转换日期时间字符串格式
+ (NSString *)convertToDateWith:(NSString *)dateString separateStr:(NSString *)separateStr
{
    if (dateString.length > 8) {
        NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
        NSString *month = [dateString substringWithRange:NSMakeRange(year.length, 2)];
        NSString *day = [dateString substringWithRange:NSMakeRange(year.length + month.length, 2)];
        NSString *hour = [dateString substringWithRange:NSMakeRange(year.length + month.length + day.length, 2)];
        NSString *minute = [dateString substringWithRange:NSMakeRange(year.length + month.length + day.length + hour.length, 2)];
        NSString *second = [dateString substringWithRange:NSMakeRange(year.length + month.length + day.length + hour.length + minute.length, 2)];
        return [NSString stringWithFormat:@"%@%@%@%@%@ %@:%@:%@", year, separateStr, month, separateStr, day, hour, minute, second];
    } else {
        if (dateString.length == 8) {
            NSString *year = [dateString substringWithRange:NSMakeRange(0, 4)];
            NSString *month = [dateString substringWithRange:NSMakeRange(year.length, 2)];
            NSString *day = [dateString substringWithRange:NSMakeRange(year.length + month.length, 2)];
            return [NSString stringWithFormat:@"%@%@%@%@%@", year, separateStr, month, separateStr, day];
        } else if (dateString.length == 6){
            NSString *hour = [dateString substringWithRange:NSMakeRange(0, 2)];
            NSString *minute = [dateString substringWithRange:NSMakeRange(hour.length, 2)];
            NSString *second = [dateString substringWithRange:NSMakeRange(hour.length + minute.length, 2)];
            return [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
        } else {
            return dateString;
        }
    }
}

#pragma mark - 字符串前面添加空格
+ (NSString *)addSpace:(NSString *)string count:(int)count
{
    for (int i=0; i<count; i++) {
        string = [NSString stringWithFormat:@" %@", string];
    }
    return string;
}

#pragma mark - 将金额字段转换为货币格式
+ (NSString *)convertToCurrencyWith:(NSString *)String
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *currencyStr = [formatter stringFromNumber:[NSNumber numberWithDouble:[String doubleValue]]];
    currencyStr = [currencyStr stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""];
    return currencyStr;
}

@end