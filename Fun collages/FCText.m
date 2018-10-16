//
//  FCText.m
//  Fun collages
//
//  Created by Yang Song on 12/16/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCText.h"
#import "FCCollageView.h"
#import "FCPictureEditingVC.h"
@implementation FCText

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithText:(NSString*)text frame:(CGRect)frame atPoint:(CGPoint)point
{
    self=[super initWithFrame:frame];
    self.textView=[[UITextView alloc] init];
    self.textView.autocorrectionType=UITextAutocorrectionTypeNo;
    self.textView.spellCheckingType=UITextSpellCheckingTypeNo;
    self.textView.keyboardAppearance=UIKeyboardAppearanceDark;
    self.textView.returnKeyType=UIReturnKeyDone;
    self.textView.scrollEnabled=NO;
    //self.textView.tintColor=[UIColor whiteColor];
    self.textView.inputAccessoryView=[[[NSBundle mainBundle] loadNibNamed:@"FCKeyboardAccessoryView" owner:self options:nil] objectAtIndex:0];
    [self.textView setText:text];
   if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
   {
    [self.textView setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:30]];
   }
   else
   {
     [self.textView setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:45]];
   }
   
    [self.textView setTextColor:[UIColor whiteColor]];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    self.textView.frame=CGRectMake(2, 2, frame.size.width-4, frame.size.height-4);
    
    //[self.textView sizeToFit];
    //[self sizeToFit];
     //[self.textView setTextAlignment:NSTextAlignmentCenter];
    [self setFrame:frame];
    [self addSubview:self.textView];
    [self setCenter:point];
    self.textView.editable=NO;
    self.textView.selectable=NO;
    
    
//    self.backgroundLayerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height+220)];
//    self.backgroundLayerView.backgroundColor=[UIColor blackColor];
//    self.backgroundLayerView.alpha=0.8;
//    [self insertSubview:self.backgroundLayerView atIndex:0];
//    [self.backgroundLayerView setHidden:YES];
    
    
    //self.clipsToBounds=YES;
//    UILabel *textLabel=[[UILabel alloc] init];
//    [textLabel setText:text];
//    [textLabel setTextAlignment:NSTextAlignmentCenter];
//    //[textLabel setBackgroundColor:[UIColor blackColor]];
//    [textLabel setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:60]];
//    [textLabel setTextColor:[UIColor whiteColor]];
//    textLabel.frame=CGRectMake(2, 2, frame.size.width-4, frame.size.height-4);
//    textLabel.numberOfLines=5;
//    [textLabel sizeToFit];
//    [self setFrame:frame];
//    self.backgroundColor=[UIColor clearColor];
//    [self addSubview:textLabel];
    
    
//    CGAffineTransform currentTransform =[self transform];
//    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.0, 1.0);
//    [self setTransform:newTransform];
    
    
    
    return self;
    
}

-(void)doubleTapped
{
    [self.superview bringSubviewToFront:self];
    
    [(FCPictureEditingVC*)[(FCCollageView*)self.superview parentVC] beginTextEditing:self];
}

- (IBAction)colorButtonClicked:(id)sender {
    
    [(FCPictureEditingVC*)[(FCCollageView*)self.superview parentVC] openColorPicker:self];
}
- (IBAction)fontButtonClicked:(id)sender {
    [(FCPictureEditingVC*)[(FCCollageView*)self.superview parentVC] openFontPicker:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
