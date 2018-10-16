//
//  StripViewBlock.h
//  Fun collages
//
//  Created by Yang Song on 11/19/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StripViewBlock : UIScrollView
@property (nonatomic,strong)IBOutlet UIImageView *imageBlock;
-(id)initWithImage:(NSString*)imageURL;
@end
