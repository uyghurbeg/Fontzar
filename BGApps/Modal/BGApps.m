//
//  BGApps.m
//  otkurname
//
//  Created by UyghurbegPro on 16/1/8.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGApps.h"

@implementation BGApps

+ (instancetype)appsWithDict:(NSDictionary *)dict
{
    BGApps *apps = [[self alloc] init];
    apps.appInfo = dict[@"app-info"];
    apps.appUrl = dict[@"app-url"];
    
    return apps;
}

@end
