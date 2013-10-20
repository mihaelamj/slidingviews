//
//  UIColor+StandardColors.m
//  SlidingHarmonicaViews
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//
//TODO replace with regex
//([a-z]+)([A-Z][a-z]*){1}
//([a-z]+)Color

#import "UIColor+StandardColors.h"
#import "NSString+MethodList.h"

@implementation UIColor (StandardColors)

#define RAND_FROM_TO(min,max) (min + arc4random_uniform(max - min + 1))

+ (int)capitalizedWordsCountInString:(NSString *)string
{
    NSCharacterSet *separators = [NSCharacterSet uppercaseLetterCharacterSet];
    NSArray *capWords = [string componentsSeparatedByCharactersInSet:separators];
    return [capWords count] - 1;
}

+ (NSArray *)standardColorNames
{
    //get all class methods of UIColor class
    NSMutableArray *colorClassMethods = [NSString getClassOrInstanceMethodsFromClassName:@"UIColor" getClassMethods:YES];
    
    //return only methods that end with "Color", not start with "_" and have only one capitalized letter
    NSArray *colors = [colorClassMethods filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:
                                                                    ^BOOL(id method, NSDictionary *bindings)
                                                                      {
                                                                          NSString *methodName = (NSString *)method;
                                                                          BOOL endsWithColor = [methodName hasSuffix:@"Color"];
                                                                          BOOL startsWithUnderscore = [methodName hasPrefix:@"_"];
                                                                          BOOL hasMoreThanOneUppercase = [self capitalizedWordsCountInString:methodName] > 1;
                                                                          return (endsWithColor && !startsWithUnderscore && !hasMoreThanOneUppercase);
                                                                    }]];
    return  colors;
}

+ (UIColor *)randomStandardColor
{
    NSArray *standardColors = [self standardColorNames];
    if (standardColors) {
        NSInteger rndNo = RAND_FROM_TO(0,[standardColors count]-1);
        SEL colorSel = NSSelectorFromString(standardColors[rndNo]);
        NSLog(@"Color:%@", standardColors[rndNo]);
        return [UIColor performSelector:colorSel];
    }
    return nil;
}

@end
