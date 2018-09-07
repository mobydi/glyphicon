//
//  ParameterObjectController.m
//  glyphicon
//
//  Created by ilya on 16.09.12.
//  Copyright (c) 2012 mobydi. All rights reserved.
//

#import "ParameterObjectController.h"

@implementation ParameterObjectController


-(void)setValue:(id)value forKeyPath:(NSString *)keyPath
{
    [super setValue:value forKeyPath:keyPath];
    
    [[NSNotificationCenter defaultCenter]
        postNotificationName:@"info.mobydi.glyphicon.value.changed"
        object:self];
}

@end
