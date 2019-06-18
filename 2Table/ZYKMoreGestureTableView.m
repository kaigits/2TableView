//
//  ZYKMoreGestureTableView.m
//  2Table
//
//  Created by apple on 2019/6/18.
//  Copyright © 2019 zyk. All rights reserved.
//

#import "ZYKMoreGestureTableView.h"

@implementation ZYKMoreGestureTableView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
