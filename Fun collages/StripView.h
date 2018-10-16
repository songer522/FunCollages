//
//  StripView.h
//  Fun collages
//
//  Created by Yang Song on 11/19/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
@interface StripView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)ALAssetsLibrary *assetsLibrary;
@property(nonatomic,strong)UIImageView          *backgroundView;
@property(nonatomic, strong)UIActivityIndicatorView *indicator;

-(id)initWithImage:(NSArray*)imageArray;
-(void)loadPictures:(NSArray*)pictureArray;
@end
