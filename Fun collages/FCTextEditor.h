//
//  FCTextEditor.h
//  Fun collages
//
//  Created by Yang Song on 12/23/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCTextEditor : UIView

@property(nonatomic,strong)UITextView *editView;
@property(nonatomic,strong)UIView     *backgroundLayer;
-(void)updateText:(NSString*)text;
@end
