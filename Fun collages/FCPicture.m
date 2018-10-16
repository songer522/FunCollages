//
//  FCPicture.m
//  Fun collages
//
//  Created by Yang Song on 6/27/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCPicture.h"

@implementation FCPicture

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithImage:(UIImage*)image frame:(CGRect)frame withRotation:(CGFloat)rotation atPoint:(CGPoint)point
{
    self=[super initWithFrame:frame];
  
    UIImageView *aImageView=[[UIImageView alloc] initWithImage:image];
  
    aImageView.frame=CGRectMake(2, 2, frame.size.width-4, frame.size.height-4);
    aImageView.contentMode=UIViewContentModeScaleAspectFill;
    aImageView.clipsToBounds=YES;
    //[aImageView setImage:image borderWidth:2.0 shadowDepth:4.0 controlPointXOffset:0 controlPointYOffset:0];
    [self setFrame:frame];
    self.backgroundColor=[UIColor whiteColor];
    //self.backgroundColor=[UIColor clearColor];
    [self addSubview:aImageView];
    
    CGAffineTransform currentTransform = [self transform];
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    [self setTransform:newTransform];

    self.layer.shadowOffset=CGSizeMake(0, 3);
    self.layer.shadowRadius=5.0;
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOpacity=1.0;
    [self setCenter:point];
    

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
