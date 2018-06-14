//
//  BGSetting.m
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/12.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGSetting.h"

@implementation BGSetting

+ (instancetype)settingWithTitle:(NSString *)title withIcon:(NSString *)icon
{
    BGSetting *setting = [[self alloc] init];
    setting.title = title;
    setting.icon = icon;
    
    return setting;
}
@end
