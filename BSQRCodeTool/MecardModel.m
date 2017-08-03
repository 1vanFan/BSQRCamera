//
//  MecardModel.m
//  BSQRCodeTool
//
//  Created by 范宝珅 on 2017/8/3.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

#import "MecardModel.h"
#import "MJExtension.h"
#import "NSString+BSBlank.h"

//  MECARD:N:Doe,John;TEL:13035551212;EMAIL:john.doe@example.com;;

@implementation MecardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"name"    : @"N",
             @"reading" : @"SOUND",
             @"tel"     : @"TEL",
             @"email"   : @"EMAIL",
             @"birthday": @"BDAY",
             @"address" : @"ADR",
             @"telAV"   : @"TEL-AV",
             @"memo"    : @"NOTE",
             @"url"     : @"URL",
             @"nickname": @"NICKNAME",
             @"orginization" : @"ORG"
             };
}

- (NSString *)generateMecardString
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject: @"MECARD:"];
    [array addObject:[self createStringKey:@"N"
                                   message:_name]];
    [array addObject:[self createStringKey:@"SOUND"
                                   message:_reading]];
    [array addObject:[self createStringKey:@"TEL"
                                   message:_tel]];
    [array addObject:[self createStringKey:@"EMAIL"
                                   message:_email]];
    [array addObject:[self createStringKey:@"BDAY"
                                   message:_birthday]];
    [array addObject:[self createStringKey:@"ADR"
                                   message:_address]];
    [array addObject:[self createStringKey:@"TEL-AV"
                                   message:_telAV]];
    [array addObject:[self createStringKey:@"NOTE"
                                   message:_memo]];
    [array addObject:[self createStringKey:@"URL"
                                   message:_url]];
    [array addObject:[self createStringKey:@"NICKNAME"
                                   message:_nickname]];
    [array addObject:[self createStringKey:@"ORG"
                                   message:_orginization]];
    return [array componentsJoinedByString:@""];
}

- (NSString *)createStringKey:(NSString *)key message:(NSString *)message
{
    if ([message isNotBlank]) {
        return [NSString stringWithFormat:@"%@:%@;", key, message];
    }
    return @"";
}

@end
