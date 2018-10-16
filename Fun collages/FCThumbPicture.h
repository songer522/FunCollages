//
//  FCThumbPicture.h
//  Fun collages
//
//  Created by Song on 1/18/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Photos/Photos.h>
@protocol FCThumbPictureDelegate <NSObject>

-(void)thumbPictureRemovedWithImageUrl:(NSString*)url;


@end

@interface FCThumbPicture : UIView

@property (nonatomic,strong)IBOutlet UIImageView *   pictureView;
@property (nonatomic,strong)IBOutlet UIButton *      buttonClose;
@property (nonatomic,assign)NSString *               imageUrl;
@property (nonatomic,assign)PHAsset *               asset;
@property (nonatomic,assign)id<FCThumbPictureDelegate> delegate;
+(id)thumbPicture:(UIImage *)image andUrl:(PHAsset*)url;
-(IBAction)closeButtonPressed;
@end
