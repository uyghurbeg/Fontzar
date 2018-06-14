//
//  BGApp.h
//  بۇلبۇلنامە
//
//  Created by UyghurbegPro on 16/3/11.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGApp : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumbnail;


@property (nonatomic, strong) NSDictionary *costumField;

+ (instancetype)appsWithDict:(NSDictionary *)dict;


@end
