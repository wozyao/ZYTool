//
//  ZYTool.h
//  ZYToolClass
//
//  Created by 郑遥 on 15/9/22.
//  Copyright © 2015年 郑遥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYTool : NSObject

/** 判断是否已成年 */
+ (BOOL)isManhoodWithCertID:(NSString *)certID;

/** 判断手机号码格式是否正确 */
+ (BOOL)isValidTelNum:(NSString *)telNum;

/** 判断是否是中文用户名 */
+ (BOOL)validateNickname:(NSString *)nickname;

/** 判断是否是正整数 */
+ (BOOL)isPositiveInteger:(NSString *)number;

/** 转换日期时间字符串格式 */
+ (NSString *)convertToDateWith:(NSString *)dateString separateStr:(NSString *)separateStr;

/** 字符串前面添加空格 */
+ (NSString *)addSpace:(NSString *)string count:(int)count;

/** 将金额字段转换为货币格式 */
+ (NSString *)convertToCurrencyWith:(NSString *)String;

@end