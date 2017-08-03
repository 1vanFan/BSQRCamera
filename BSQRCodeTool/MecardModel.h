//
//  MecardModel.h
//  BSQRCodeTool
//
//  Created by 范宝珅 on 2017/8/3.
//  Copyright © 2017年 1vanFan. All rights reserved.
//

/*
 参考资料
 https://web.archive.org/web/20160304025131/https://www.nttdocomo.co.jp/english/service/developer/make/content/barcode/function/application/addressbook/index.html
 */
/**
 *  样例
 *  MECARD:N:Doe,John;TEL:13035551212;EMAIL:john.doe@example.com;
 */
#import <Foundation/Foundation.h>

@interface MecardModel : NSObject

/** 
 *  姓名
 *  N:
 *  Designates a text string to be set as the name in the phonebook.(0 or more characters)
 *  When a field is divided by a comma (,), the first half is treated as the last name and the second half is treated as the first name.
 */
@property (nonatomic, copy) NSString * name;

/**
 *  拼音
 *  SOUND:
 *  Designates a text string to be set as the kana name in the phonebook. (0 or more characters)
 *  When a field is divided by a comma (,), the first half is treated as the last name and the second half is treated as the first name.
 */
@property (nonatomic, copy) NSString * reading;

/**
 *  电话
 *  TEL:	
 *  Designates a text string to be set as the telephone number in the phonebook. (1 to 24 digits)
 */
@property (nonatomic, copy) NSString * tel;

/**
 *  邮箱
 *  EMAIL:
 *  Designates a text string to be set as the e-mail address in the phonebook. (0 or more characters)
 */
@property (nonatomic, copy) NSString * email;

/**
 *  地址
 *  ADR:
 *  Designates a text string to be set as the address in the phonebook. (0 or more characters)
 *  The fields divided by commas (,) denote PO box, room number, house number, city, prefecture, zip code and country, in order.
 */
@property (nonatomic, copy) NSString * address;

#pragma mark - Supported by applicable models

/**
 *  生日
 *  BDAY:
 *  Designates a text string to be set as the birthday in the phonebook. (8 digits)
 *  The 8 digits consist of the year (4 digits), month (2 digits) and day (2 digits), in order.
 */
@property (nonatomic, copy) NSString * birthday;

/**
 *  视频电话
 *  TEL-AV:
 *  Designates a text string to be set as the videophone number in the phonebook. (1 to 24 digits)
 */
@property (nonatomic, copy) NSString * telAV;

/**
 *  备注
 *  NOTE:
 *  Designates a text string to be set as the memo in the phonebook. (0 or more characters)
 */
@property (nonatomic, copy) NSString * memo;

/**
 *  url
 *  URL:
 *  Designates a text string to be set as the homepage URL in the phonebook. (0 or more characters)
 */
@property (nonatomic, copy) NSString * url;

/**
 *  昵称
 *  NICKNAME:
 *  Designates a text string to be set as the nickname in the phonebook. (0 or more characters)
 */
@property (nonatomic, copy) NSString * nickname;

/**
 *  公司
 *  ORG:
 *  Designates a text string to be set as the orginization in the phonebook. (0 or more characters)
 */
@property (nonatomic, copy) NSString * orginization;

#pragma mark - generator

- (NSString *)generateMecardString;
@end
