//
//  BGApp.m
//  بۇلبۇلنامە
//
//  Created by UyghurbegPro on 16/3/11.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGApp.h"
#import "BGApps.h"

@implementation BGApp
+ (instancetype)appsWithDict:(NSDictionary *)dict
{
    BGApp *apps = [[self alloc] init];
    apps.title = dict[@"title"];
    apps.thumbnail = dict[@"thumbnail"];
    apps.costumField = dict[@"custom_fields"];
    
    return apps;
}

@end
