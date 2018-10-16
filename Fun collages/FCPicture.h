//
//  FCPicture.h
//  Fun collages
//
//  Created by Yang Song on 6/27/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+Curled.h"
#import <Photos/Photos.h>
@interface FCPicture : UIView
@property(nonatomic,assign)CGFloat pointX;
@property(nonatomic,assign)CGFloat pointY;
@property(nonatomic,strong)NSString *pictureURL;
@property(nonatomic,strong)PHAsset *asset;
-(id)initWithImage:(UIImage*)image frame:(CGRect)frame withRotation:(CGFloat)rotation atPoint:(CGPoint)point;
@end
