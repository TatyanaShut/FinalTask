//
//  UIColor+CustomColor.m
//  WeekCalendar
//
//  Created by Tatyana Shut on 29.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//
#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+(UIColor *) blueLight {
    return [UIColor colorWithRed:0xD5/255.0f
                           green:0xF0/255.0f
                            blue:0xFA/255.0f alpha:1];

}
+(UIColor *) blueDark {
    return [UIColor colorWithRed:0x90/255.0f
                           green:0xC2/255.0f
                            blue:0xF5/255.0f alpha:1];
    
}
+ (UIColor *) darkTextColor {
    return [UIColor colorWithRed:0x07/255.0f
                           green:0x31/255.0f
                            blue:0x5B/255.0f alpha:1];
}
@end
