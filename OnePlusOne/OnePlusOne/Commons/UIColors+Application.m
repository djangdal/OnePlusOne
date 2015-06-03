//
//  UIColors+Application.m
//  OnePlusOne
//
//  Created by David Jangdal on 2015-05-06.
//  Copyright (c) 2015 David Jangdal. All rights reserved.
//

#import "UIColors+Application.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (Application)



// Color set 1 http://www.colorcombos.com/color-schemes/176/ColorCombo176.html
// http://www.colorcombos.com/color-schemes/125/ColorCombo125.html


+ (UIColor *)defaultDarkColor           {return UIColorFromRGB(0x656565);}
+ (UIColor *)defaultLightColor          {return UIColorFromRGB(0xDCDCDC);}
+ (UIColor *)defaultWhiteColor          {return UIColorFromRGB(0xECECEC);}

//+ (UIColor *)defaultBackgroundColor     {return UIColorFromRGB(0xF4F3EE);}
//+ (UIColor *)defaultBorderColor         {return UIColorFromRGB(0xA2ADBC);}
//+ (UIColor *)defaultTextColor           {return UIColorFromRGB(0x333333);}
//
//+ (UIColor *)secondaryBackgroundColor   {return UIColorFromRGB(0xF6F4DA);}
//
//+ (UIColor *)buttonBackgroundColor      {return UIColorFromRGB(0xD9E2E1);}
//+ (UIColor *)buttonBorderColor          {return [UIColor defaultBorderColor];}
//+ (UIColor *)buttonTextColor            {return [UIColor defaultTextColor];}
//
//+ (UIColor *)missionBackgroundColor     {return [UIColor secondaryBackgroundColor];}
//+ (UIColor *)missionBorderColor         {return [UIColor defaultBorderColor];}
//+ (UIColor *)missionTextColor           {return [UIColor defaultTextColor];}

// Color set 2
//+ (UIColor *)defaultBackgroundColor  {return [UIColor colorWithRed:1.0f green:1.0f blue:0.8f alpha:1.0f];}
//+ (UIColor *)defaultBorderColor      {return [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];}
//+ (UIColor *)defaultTextColor        {return [UIColor colorWithRed:0.5f green:0.5f blue:0.5f alpha:1.0f];}
//
//+ (UIColor *)buttonBackgroundColor   {return [UIColor colorWithRed:1.0f green:1.0f blue:0.7f alpha:1.0f];}
//+ (UIColor *)buttonBorderColor       {return [UIColor colorWithRed:0.6f green:0.7f blue:0.9f alpha:1.0f];}
//+ (UIColor *)buttonTextColor         {return [UIColor defaultTextColor];}
//
//+ (UIColor *)missionBackgroundColor  {return [UIColor defaultBackgroundColor];}
//+ (UIColor *)missionBorderColor      {return [UIColor defaultTextColor];}
//+ (UIColor *)missionTextColor


//+ (UIColor *)colorFromHex(NSString *)hex{
//    return nil;
//}

@end
