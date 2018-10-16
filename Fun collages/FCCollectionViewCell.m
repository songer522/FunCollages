//
//  FCCollectionViewCell.m
//  Fun collages
//
//  Created by Yang Song on 6/24/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCCollectionViewCell.h"

@implementation FCCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithImage:(UIImage *)image andImageUrl:(NSString*)url
{
    
    
        self=[[[NSBundle mainBundle] loadNibNamed:@"FCCollectionViewCell" owner:self options:nil] objectAtIndex:0];
       
    //[self.previewImageView setImage:image];
    self.imageUrl=url;
    
    
    
    return self;
}
-(void)showImage
{
    self.loadImage(self.imageUrl);
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
