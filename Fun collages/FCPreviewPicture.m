//
//  FBProfileImage.m
//  Resultly
//
//  Created by Yang Song on 4/1/13.
//  Copyright (c) 2013 Resultly. All rights reserved.
//

#import "FCPreviewPicture.h"

@implementation FCPreviewPicture

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithImage:(UIImage *)image andImageUrl:(PHAsset*)url;
{
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"FCPreviewPicture_iPad" owner:self options:nil] objectAtIndex:0];
        
    }
    else
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"FCPreviewPicture_iPhone" owner:self options:nil] objectAtIndex:0];
        
    }
    
    [self.previewImageView setImage:image];
    //self.imageUrl=url;
    self.asset = url;
    
    
    return self;
}


- (IBAction)buttonPressed:(id)sender {
[self.delegate addImageUrl:self.asset andImage:self.previewImageView.image];
    
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
