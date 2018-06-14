//
//  BGFonts.h
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/11.
//  Copyright © 2016年 BG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGFonts : NSObject

@property (nonatomic, copy) NSString *fontName;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)fontsWithDict:(NSDictionary *)dict;
+ (NSArray *)fonts;

@end
