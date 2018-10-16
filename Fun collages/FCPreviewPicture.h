//
//  FBProfileImage.h
//  Resultly
//
//  Created by Yang Song on 4/1/13.
//  Copyright (c) 2013 Resultly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@protocol FCPreviewPictureDelegate <NSObject>
-(void)addImageUrl:(PHAsset*)imageUrl andImage:(UIImage*)image;

@end

@interface FCPreviewPicture : UIView
@property (nonatomic,strong)IBOutlet UIImageView  *previewImageView;
@property (nonatomic,strong) NSString      *imageUrl;
@property (nonatomic,strong) PHAsset      *asset;
@property(nonatomic,strong)IBOutlet UIButton       *checkButton;
@property(nonatomic,strong) NSObject<FCPreviewPictureDelegate> *delegate;

-(id)initWithImage:(UIImage *)image andImageUrl:(PHAsset*)url;
@end
