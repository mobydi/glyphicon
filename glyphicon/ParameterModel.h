//
//  ParameterModel.h
//  glyphicon
//
//  Created by ilya on 16.09.12.
//  Copyright (c) 2012 mobydi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParameterModel : NSObject 

@property double sizeX;
@property double sizeY;
@property double offsetX;
@property double offsetY;

@property NSString *glyph;
@property CGFloat fontSize;

@property bool center;
@property double border;

@property NSArray *fonts;
@property NSString *fontName;

@property NSArray *persets;
@property NSString *perset;

@end
