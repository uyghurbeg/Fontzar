//
//  BGSetting.h
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/12.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SettingBlock)();

@interface BGSetting : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) Class desClass;
@property (nonatomic, strong) SettingBlock block;


+ (instancetype)settingWithTitle:(NSString *)title withIcon:(NSString *)icon;


@end
