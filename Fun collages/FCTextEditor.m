//
//  FCTextEditor.m
//  Fun collages
//
//  Created by Yang Song on 12/23/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCTextEditor.h"
#import "FCCollageView.h"
#import "FCPictureEditingVC.h"
@implementation FCTextEditor

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
        self.backgroundLayer=[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.backgroundLayer setBackgroundColor:[UIColor blackColor]];
        [self.backgroundLayer setAlpha:0.8];
        [self addSubview:self.backgroundLayer];
        self.editView=[[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.editView.autocorrectionType=UITextAutocorrectionTypeNo;
        self.editView.spellCheckingType=UITextSpellCheckingTypeNo;
        self.editView.keyboardAppearance=UIKeyboardAppearanceDark;
        self.editView.returnKeyType=UIReturnKeyDone;
        self.editView.scrollEnabled=NO;
        [self.editView setBackgroundColor:[UIColor clearColor]];
        [self.editView setTextColor:[UIColor whiteColor]];
        //self.textView.tintColor=[UIColor whiteColor];
        self.editView.inputAccessoryView=[[[NSBundle mainBundle] loadNibNamed:@"FCKeyboardAccessoryView" owner:self options:nil] objectAtIndex:0];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self.editView setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:30]];
        }
        else
        {
            [self.editView setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:45]];
        }

        
        [self addSubview:self.editView];
    }
    return self;
}


-(void)updateText:(NSString*)text
{
    [self.editView setText:text];
}
- (IBAction)colorButtonClicked:(id)sender {
    
    [(FCPictureEditingVC*)[(FCCollageView*)self.superview parentVC] openColorPicker:nil];
}
- (IBAction)fontButtonClicked:(id)sender {
    [(FCPictureEditingVC*)[(FCCollageView*)self.superview parentVC] openFontPicker:nil];
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
