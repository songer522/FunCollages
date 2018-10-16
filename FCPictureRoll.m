//
//  PictureRoll.m
//  Fun collages
//
//  Created by Song on 1/17/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCPictureRoll.h"

@implementation FCPictureRoll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(id)pictureRoll
{
    return [[self alloc] initWithPictureRoll];
}
-(id)initWithPictureRoll
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"FCPictureRoll_iPhone" owner:self options:nil] objectAtIndex:0];
    self.pictureCount=0;
   
    return self;
}

-(void)addPicture:(UIImage *)image andUrl:(PHAsset*)url
{
    if(!self.imageStack)
    {
     self.imageStack=[[NSMutableArray alloc] init];
    }
    FCThumbPicture *picture=[FCThumbPicture thumbPicture:image andUrl:url];
    picture.delegate=self;
    [picture setFrame:CGRectMake(95*self.pictureCount, 5, picture.frame.size.width, picture.frame.size.height)];
    //[self.imageStack addObject:picture];
    [self.imageStack addObject:url];
    [self.pictureScrollView addSubview:picture];
    
    self.pictureCount++;
    [self.pictureScrollView setContentSize:CGSizeMake(95*self.pictureCount, 90)];
    if(self.pictureScrollView.contentSize.width>self.pictureScrollView.frame.size.width)
    {
    [self.pictureScrollView setContentOffset:CGPointMake(self.pictureScrollView.contentSize.width-self.pictureScrollView.frame.size.width, 0)];
    }
}

-(void)thumbPictureRemovedWithImageUrl:(PHAsset *)url
{
    self.pictureCount--;
    [self.imageStack removeAllObjects];
    if(!self.imageStack)
    {
        self.imageStack=[[NSMutableArray alloc] init];
    }
    int curX=0;
    for(FCThumbPicture *obj in self.pictureScrollView.subviews)
    {
        if([obj isKindOfClass:[FCThumbPicture class]])
        {
             [obj setFrame:CGRectMake(curX, 5, obj.frame.size.width, obj.frame.size.height)];
             curX=curX+95;
            
            //[self.imageStack addObject:obj];
            [self.imageStack addObject:obj.asset];
        }
    }
    if(self.removePicture)
    {
        self.removePicture(url);
    }
}
-(void)resetPhotos
{
    for(FCThumbPicture *obj in self.pictureScrollView.subviews)
    {
        if([obj isKindOfClass:[FCThumbPicture class]])
        {
            [obj closeButtonPressed];
        }
        
        
    }
    [self.imageStack removeAllObjects];
    
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
