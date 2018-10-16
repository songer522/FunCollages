//
//  PictureRoll.h
//  Fun collages
//
//  Created by Song on 1/17/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCThumbPicture.h"
#import <Photos/Photos.h>

typedef void (^RemovePicture)(PHAsset *imageUrl);
@interface FCPictureRoll : UIView<FCThumbPictureDelegate>

@property(nonatomic,strong)IBOutlet UIImageView *     topBarBackground;
@property(nonatomic,strong)IBOutlet UIScrollView *    pictureScrollView;
@property(nonatomic,strong)IBOutlet UILabel *         labelPictureIndicator;
@property(nonatomic,strong)IBOutlet UIButton *        buttonSubmit;
@property(nonatomic,copy)RemovePicture               removePicture;
@property(nonatomic,assign)int                        pictureCount;
@property(nonatomic,strong)NSMutableArray *                  imageStack;
+(id)pictureRoll;
-(void)addPicture:(UIImage *)image andUrl:(PHAsset*)url;
-(void)resetPhotos;
@end
