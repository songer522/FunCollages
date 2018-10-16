//
//  StripView.m
//  Fun collages
//
//  Created by Yang Song on 11/19/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "StripView.h"
#import "StripViewBlock.h"
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>
@implementation StripView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithImage:(NSArray*)imageArray
{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    self=[[[NSBundle mainBundle] loadNibNamed:@"StripView_iPhone" owner:self options:nil] objectAtIndex:0];
    }
    else
    {
      self=[[[NSBundle mainBundle] loadNibNamed:@"StripView_iPad" owner:self options:nil] objectAtIndex:0];  
    }
    if(!self.assetsLibrary)
    {
        self.assetsLibrary=[[ALAssetsLibrary alloc] init];
    }
    [self loadPictures:imageArray];
        //[self.backgroundView setFrame:CGRectMake(self.backgroundView.frame.origin.x, self.backgroundView.frame.origin.y, self.backgroundView.frame.size.width, imageArray.count*blockHeight)];
    return self;
}
-(void)loadPictures:(NSArray*)pictureArray
{
    for(UIView *obj in self.subviews)
    {
        [obj removeFromSuperview];
    }
    if(pictureArray.count>0)
    {
    
    CGFloat curXLoc = 10;
    float blockHeight;
    for(PHAsset *imageURL in pictureArray)
    {
        StripViewBlock *block=[[StripViewBlock alloc] initWithImage:imageURL];
        block.delegate=self;
        [block setFrame:CGRectMake(15, curXLoc, self.frame.size.width-30, block.frame.size.height)];
        
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        option.networkAccessAllowed = YES;
        
        
        CGSize targetSize = CGSizeMake(1000, imageURL.pixelHeight*1000/imageURL.pixelWidth);
        [[PHImageManager defaultManager] requestImageForAsset:imageURL targetSize:targetSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
            
            
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                               float ratioWidth=1.0;
                               float ratioHeight=1.0;
                               float s=image.size.height/image.size.width;
                               if (s>=1) {
                                   ratioHeight=s;
                               }
                               else
                               {
                                   ratioWidth=1/s;
                               }
                               if (image != nil && image.size.width > 300) {
                                   
                                   [block.imageBlock setImage:image];
                                   block.imageBlock.layer.masksToBounds=YES;
                                   block.imageBlock.layer.cornerRadius=6;
                                   [self addSubview:block];
                                   
                              }
                           });
            
            
            
        }];

        
        
        
//        NSURL *url=[NSURL URLWithString:imageURL];
//        [self.assetsLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//            UIImage *image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//            [block.imageBlock setImage:image];
//            block.imageBlock.layer.masksToBounds=YES;
//            block.imageBlock.layer.cornerRadius=6;
//            [self addSubview:block];
//        }failureBlock:^(NSError *error) {
//            NSLog(@"error=%@",error);
//        }
//         ];
        
        curXLoc+=block.frame.size.height+10;
        
        blockHeight=block.frame.size.height;
        
        
    }
    
    [self setContentSize:CGSizeMake(self.frame.size.width, pictureArray.count*(blockHeight+10)+10)];
    self.backgroundView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, pictureArray.count*(blockHeight+10)+10)];
    [self.backgroundView setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
    [self insertSubview:self.backgroundView atIndex:0];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if([scrollView isKindOfClass:[StripViewBlock class]])
    {
    return [(StripViewBlock*)scrollView imageBlock];
    }
    else
    {
        return nil;
    }
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
