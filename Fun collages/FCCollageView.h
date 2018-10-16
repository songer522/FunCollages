//
//  FCCollageView.h
//  Fun collages
//
//  Created by Yang Song on 3/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCThumbPicture.h"
#import "FCPicture.h"
#import "FCText.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface FCCollageView : UIView <UIGestureRecognizerDelegate>
{
    CGFloat _lastScale;
	CGFloat _lastRotation;
	CGFloat _firstX;
	CGFloat _firstY;
}
@property (nonatomic, weak) UIViewController* parentVC;
@property (nonatomic, strong) IBOutlet UIView *canvas;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, strong)NSMutableArray *pictures;
@property (nonatomic, strong)NSArray *backgroundPictures;
@property(nonatomic,strong)ALAssetsLibrary *assetsLibrary;
//@property (nonatomic, strong) IBOutlet UIButton *rightButton;
//@property (nonatomic, strong) IBOutlet UIButton *leftButton;
-(void)addText;
-(void)loadPictures:(NSArray*)pictureArray;
-(void)removeDeletedPictures;
-(void)addGestureRecognizers:(UIView *)aView;
@end
