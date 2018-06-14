//
//  BGApps.h
//  otkurname
//
//  Created by UyghurbegPro on 16/1/8.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGApps : NSObject

@property (nonatomic, copy) NSString *appUrl;
@property (nonatomic, copy) NSString *appInfo;


+ (instancetype)appsWithDict:(NSDictionary *)dict;


@end
