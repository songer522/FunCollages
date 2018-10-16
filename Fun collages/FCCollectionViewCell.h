//
//  FCCollectionViewCell.h
//  Fun collages
//
//  Created by Yang Song on 6/24/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoadImage)(NSString *imageUrl);
@interface FCCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIView       *cellContentView;
@property (nonatomic,strong)IBOutlet UIImageView  *previewImageView;
@property (nonatomic,strong)IBOutlet NSString      *imageUrl;
@property(nonatomic,strong)IBOutlet UIButton       *checkButton;
@property(nonatomic,copy)LoadImage               loadImage;
-(id)initWithImage:(UIImage *)image andImageUrl:(NSString*)url;
-(void)showImage;
@end
