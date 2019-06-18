//
//  zykConfig.h
//  2Table
//
#import "UIDeviceHardware.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_SIZE_5 CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)
// iPhone X 判断
#define IS_IPHONE_X ([[UIDeviceHardware platformString] isEqualToString:@"iPhone X"] || SCREEN_SIZE_5)
