//
//  BGFonts.m
//  Fontzar
//
//  Created by UyghurbegPro on 16/4/11.
//  Copyright © 2016年 BG. All rights reserved.
//

#import "BGFonts.h"

@implementation BGFonts

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)fontsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)fonts
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Fontlist" ofType:@"plist"];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *Marray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        [Marray addObject:[self fontsWithDict:dict]];
    }
    
    return [Marray copy];
}

@end
