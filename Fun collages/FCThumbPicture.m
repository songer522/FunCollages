//
//  FCThumbPicture.m
//  Fun collages
//
//  Created by Song on 1/18/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCThumbPicture.h"

@implementation FCThumbPicture

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(id)thumbPicture:(UIImage *)image andUrl:(PHAsset*)url
{
    return [[self alloc] initWiththumbPicture:image andUrl:url];
}
-(id)initWiththumbPicture:(UIImage *)image andUrl:(PHAsset*)url
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"FCThumbPicture_iPhone" owner:self options:nil] objectAtIndex:0];
    
    self.layer.cornerRadius=7.0;
    self.layer.shadowOffset=CGSizeMake(0, 3);
    self.layer.shadowRadius=8.0;
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOpacity=1;
    float ratio=image.size.width/image.size.height;
    UIImage *compressedImage=[self imageWithImage:image scaledToSize:CGSizeMake(200,200/ratio )];
    [self.pictureView setImage:compressedImage];
    //self.imageUrl=url;
    self.asset = url;

    return self;
}
- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(IBAction)closeButtonPressed
{
    NSString *url=self.imageUrl;
    PHAsset *asset = self.asset;
     [self removeFromSuperview];
    [self.delegate thumbPictureRemovedWithImageUrl:asset];
    
   
    
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
