//
//  ParameterModel.m
//  glyphicon
//
//  Created by ilya on 16.09.12.
//  Copyright (c) 2012 mobydi. All rights reserved.
//

#import "ParameterModel.h"

@implementation ParameterModel

-(id)init
{
    self = [super init];
    if (self) {
        self.sizeX = 99;
        self.sizeY = 100;
        self.glyph = @"gid5003";
        self.center = YES;
        self.fontSize = 0.1;
        self.offsetX = 0;
        self.offsetY = 0;
        self.border = 0.0;
        
        self.fonts = [[NSFontManager sharedFontManager] availableFonts];
        self.fontName = @"AppleSymbols";
        
        self.persets = @[
            @"Navigation Bar Icon (20x20)", @"Navigation Bar Icon (40x40)",
            @"Tab Bar Icon (30x30)", @"Tab Bar Icon (60x60)",
            @"Application Icon (57x57)", @"Application Icon (114x114)",
            @"Application Icon (72x72)", @"Application Icon (144x144)",
            @"Spotlight Icon (29x29)", @"Spotlight Icon (50x50)",
            @"Spotlight Icon (58x58)", @"Spotlight Icon (100x100)"];
        self.perset = @"Navigation Bar Icon (20x20)";
    }
    return self;
}

@end
