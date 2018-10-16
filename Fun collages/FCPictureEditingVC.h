//
//  FCPictureEditingVC.h
//  Fun collages
//
//  Created by Song on 1/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCItemPicker.h"
#import "FCCollageView.h"
#import "StripView.h"
#import "FCSideMenu.h"
#import "FCTextEditor.h"
@interface FCPictureEditingVC : UIViewController<FCBackgroundPickerDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIPopoverControllerDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)IBOutlet  FCCollageView*    collageView;
@property(nonatomic,strong)StripView*    stripView;
@property(nonatomic,strong)FCItemPicker *    backgroundPicker;
@property(nonatomic,strong)FCItemPicker *    colorPicker;
@property(nonatomic,strong)FCItemPicker *    fontPicker;
@property(nonatomic,strong)IBOutlet UIView *    header;
@property(nonatomic,strong)IBOutlet UITabBar *  tabBar;
@property(nonatomic,strong)IBOutlet UIButton * sideButton;
@property(nonatomic,strong)IBOutlet UIButton * collageButton;
@property(nonatomic,strong)IBOutlet UIButton * stripeButton;
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;
@property(nonatomic,strong)NSArray *pictureArray;
@property(nonatomic,strong)FCSideMenu        * sideMenu;
@property(nonatomic,assign)CGPoint           textViewPosition;
@property(nonatomic,strong)FCText            *selectedText;
@property(nonatomic,strong)UIView  *backgroundLayerView;
@property(nonatomic,strong)FCTextEditor *textEditor;
@property(nonatomic,strong)UIView  *picturePicker;
@property(nonatomic,strong)UIPopoverController *popOverVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collageButtonBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stripeButtonBottomSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sideButtonTraillingSpace;

-(id)initWithPictures:(NSArray*)pictures;
-(IBAction)clickSideMenu;
-(IBAction)dismiss;
-(IBAction)backgroundPickButtonPressed;
-(IBAction)bottomButtonPressed:(id)sender;
-(void)setupCollageView:(NSArray*)pictureArray;
-(void)openColorPicker:(FCText*)text;
-(void)openFontPicker:(FCText*)text;
-(void)beginTextEditing:(FCText*)text;
-(void)updateCollageViewPictures:(NSArray*)array withAdditionalPictures:(NSArray*)addtionalArray;
-(void)updateStripViewPictures:(NSArray *)array;
@end
