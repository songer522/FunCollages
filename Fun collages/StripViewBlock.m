//
//  StripViewBlock.m
//  Fun collages
//
//  Created by Yang Song on 11/19/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "StripViewBlock.h"
#import <QuartzCore/QuartzCore.h>
#define BLOCK_SIZE 240;
@implementation StripViewBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithImage:(NSString*)imageURL
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
     self=[[[NSBundle mainBundle] loadNibNamed:@"StripViewBlock_iPhone" owner:self options:nil] objectAtIndex:0];
    }
    else
    {
      self=[[[NSBundle mainBundle] loadNibNamed:@"StripViewBlock_iPad" owner:self options:nil] objectAtIndex:0];  
    }
    //[self.imageBlock setImage:image];

    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
