//
//  AppViewController.m
//  glyphicon
//
//  Created by ilya on 15.09.12.
//  Copyright (c) 2012 mobydi. All rights reserved.
//

#import "AppViewController.h"
#import "ParameterModel.h"

@interface AppViewController (){
    NSBitmapImageRep *rep;
}
@property (strong) IBOutlet NSImageView *imageView;
@property (strong) IBOutlet ParameterModel *model;
@end

@implementation AppViewController
@synthesize imageView;
@synthesize model;



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveModelChangedNotification:)
                                                     name:@"info.mobydi.glyphicon.value.changed"
                                                   object:nil];
    }
    
    return self;
}

- (IBAction)openFontBook:(id)sender {
    [[NSWorkspace sharedWorkspace] launchApplication:@"Font Book"];
}

- (IBAction)saveImage:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setNameFieldStringValue:@"image.png"];
    NSInteger result = [savePanel runModal];
    if(result == NSOKButton){
        NSData *data = [rep representationUsingType: NSPNGFileType properties: nil];
        [data writeToURL:savePanel.URL atomically:YES];
    }
}

- (void) receiveModelChangedNotification:(NSNotification *) notification
{
    rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                        pixelsWide:model.sizeX pixelsHigh:model.sizeY
                                                        bitsPerSample:8 samplesPerPixel:4
                                                        hasAlpha:YES isPlanar:NO
                                                        colorSpaceName:NSDeviceRGBColorSpace
                                                        bytesPerRow:0 bitsPerPixel:0];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:rep]];
    
    [[NSColor whiteColor] set];
    NSRect imageBounds = NSMakeRect (0, 0, model.sizeX, model.sizeY);
    NSRectFill (imageBounds);

    NSFont *font = [NSFont fontWithName:model.fontName size:model.fontSize];
    
    if(model.center){
        NSRect rect;
        while (rect.size.height < model.sizeY && rect.size.width < model.sizeX) {
            model.fontSize += 0.1;
            font = [NSFont fontWithName:model.fontName size:model.fontSize];
            rect = [font boundingRectForGlyph:[font glyphWithName:model.glyph]];
        }
        
        if (rect.size.height > model.sizeY || rect.size.width > model.sizeX)
        {
            model.fontSize -= 0.1;
            font = [NSFont fontWithName:model.fontName size:model.fontSize];
            rect = [font boundingRectForGlyph:[font glyphWithName:model.glyph]];
        }

        model.offsetX = (model.sizeX - rect.size.width) / 2 - rect.origin.x;
        model.offsetY = (model.sizeY - rect.size.height) / 2 - rect.origin.y;
    }

    [[NSColor blackColor] set];
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:CGPointMake(model.offsetX, model.offsetY)];
    
    if ([model.glyph hasPrefix:@"gid"])
    {
        [path appendBezierPathWithGlyph:[font glyphWithName:model.glyph] inFont:font];
    }
    else
    {
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
        NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:model.glyph attributes:@{NSFontAttributeName : font}];
        [textStorage addLayoutManager:layoutManager];
        [path appendBezierPathWithGlyph:[layoutManager glyphAtIndex:0] inFont:font];
    }
    
    [path fill];
    [path stroke];
    [NSGraphicsContext restoreGraphicsState];
    
    NSImage *image = [[NSImage alloc] initWithSize:NSMakeSize(model.sizeX, model.sizeY)];
    [image addRepresentation:rep];
    
    [imageView setImage:image];
}

@end
