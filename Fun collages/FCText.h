//
//  FCText.h
//  Fun collages
//
//  Created by Yang Song on 12/16/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCText : UIView
@property(nonatomic,assign)CGFloat pointX;
@property(nonatomic,assign)CGFloat pointY;
//@property(nonatomic,strong)UIView  *backgroundLayerView;
@property(nonatomic,strong)UITextView *textView;;
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGestureRecongizer;
@property(nonatomic,strong)UIRotationGestureRecognizer *rotationGestureRecognizer;
@property(nonatomic,strong)UIPanGestureRecognizer     *panGestureRecognizer;
-(id)initWithText:(NSString*)text frame:(CGRect)frame atPoint:(CGPoint)point;
@end
