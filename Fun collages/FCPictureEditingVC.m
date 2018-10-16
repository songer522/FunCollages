//
//  FCPictureEditingVC.m
//  Fun collages
//
//  Created by Song on 1/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCPictureEditingVC.h"
#import "MainMenu.h"
@interface FCPictureEditingVC ()

@end

@implementation FCPictureEditingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithPictures:(NSArray*)pictures
{
    self=[super init];
    self.view=[[[NSBundle mainBundle] loadNibNamed:@"FCPictureEditingVC_iPhone" owner:self options:nil] objectAtIndex:0];
    self.pictureArray = pictures;
    [self setupCollageView:pictures];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [self setupCollageView:nil];
        
        
    }
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
       [self.collageView setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 100)];
    }
    else
    {
        if(!self.popOverVC)
        {
        MainMenu *mainMenu=[[MainMenu alloc] initWithNibName:@"MainMenu_iPad" bundle:nil];
        mainMenu.pictureEditingVC=self;
        self.popOverVC=[[UIPopoverController alloc] initWithContentViewController:mainMenu];
        self.popOverVC.popoverContentSize=CGSizeMake(320, 924);
        self.popOverVC.delegate=self;
        [self.popOverVC presentPopoverFromRect:CGRectMake(-320, 0, 320, 944) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:TRUE];
        }
        
    }
}


-(void)updateCollageViewPictures:(NSArray *)array withAdditionalPictures:(NSArray*)addtionalArray
{
    
    [self.collageView loadPictures:addtionalArray];
    self.collageView.pictures=[NSMutableArray arrayWithArray:array];
    [self.collageView removeDeletedPictures];
    
}
-(void)updateStripViewPictures:(NSArray *)array
{
   // self.pictureArray=array;
    [self.stripView loadPictures:array];
}


-(void)setupStripView:(NSArray*)pictureArray
{
    
    self.stripView=[[StripView alloc] initWithImage:pictureArray];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [self.stripView setFrame:CGRectMake(25, 0, self.view.frame.size.width - 50, self.stripView.frame.size.height)];

    }
    else
    {
        [self.stripView setFrame:CGRectMake(25, 0, self.stripView.frame.size.width, self.stripView.frame.size.height)];
    }
    [self.stripView setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.stripView.center.y)];
    [self.view insertSubview:self.stripView atIndex:0];
}

-(void)setupCollageView:(NSArray*)pictureArray
{
    self.collageView=[[FCCollageView alloc] init];
    self.collageView.parentVC=self;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        
        [self.collageView setFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 100)];
        
    }
    else
    {
        [self.collageView setFrame:CGRectMake(30, 10, self.collageView.frame.size.width, self.collageView.frame.size.height)];
    }
    
    [self.collageView loadPictures:pictureArray];
    [self.view insertSubview:self.collageView atIndex:0];
    
    
}

-(void)setupBackgroundPicker
{
    self.backgroundPicker=[[FCItemPicker alloc] initWithBackground];
    self.backgroundPicker.delegate=self;
    [self.view addSubview:self.backgroundPicker];
}

-(void)setupColorPicker
{
    self.colorPicker=[[FCItemPicker alloc] initWithColor];
    self.colorPicker.delegate=self;
    [self.view addSubview:self.colorPicker];
}
-(void)setupFontPicker
{
    self.fontPicker=[[FCItemPicker alloc] initWithFont];
    self.fontPicker.delegate=self;
    [self.view addSubview:self.fontPicker];
}

-(void)setupSideMenu
{
    self.sideMenu=[[FCSideMenu alloc] init];
    [self.sideMenu setFrame:CGRectMake([UIScreen mainScreen].bounds.size.height, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    __weak typeof(self) weakSelf=self;
    self.sideMenu.closeSideMenu=^(void)
    {
        [weakSelf clickSideMenu];
    };
    self.sideMenu.gotoPhotos=^(void)
    {
        [weakSelf clickSideMenu];
        [weakSelf dismiss];
    };
    self.sideMenu.saveCollage=^(void)
    {
        [weakSelf showLoadingAnimation];
        [weakSelf clickSideMenu];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:weakSelf selector:@selector(saveToPhotoAlbums) userInfo:nil repeats:NO];
        //[weakSelf saveToPhotoAlbums];
    };
    self.sideMenu.addText=^(void)
    {
        [weakSelf.collageView addText];
        [weakSelf clickSideMenu];
    };
    self.sideMenu.changeBackground=^(void)
    {
        [weakSelf clickSideMenu];
        [weakSelf backgroundPickButtonPressed];
    };
    self.sideMenu.openShareMenu=^(void)
    {
        [weakSelf showLoadingAnimation];
        [weakSelf clickSideMenu];
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:weakSelf selector:@selector(openShareMenu) userInfo:nil repeats:NO];
        //[weakSelf openShareMenu];
    };
    [self.view addSubview:self.sideMenu];
}



-(void)backgroundPickButtonPressed
{
    if(!self.backgroundPicker)
    {
        [self setupBackgroundPicker];
    }
    if(!self.backgroundPicker.isDropped)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.backgroundPicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.backgroundPicker.frame.size.height, self.backgroundPicker.frame.size.width, self.backgroundPicker.frame.size.height)];
            
        }
                         completion:^ (BOOL finished)
         {
             self.backgroundPicker.isDropped=YES;
         }];
    }
    
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.backgroundPicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.backgroundPicker.frame.size.width, self.backgroundPicker.frame.size.height)];
            
        }
                         completion:^ (BOOL finished)
         {
             self.backgroundPicker.isDropped=NO;
         }];
    }
}


-(void)colorPickerButtonPressed
{
    if(!self.colorPicker)
    {
        [self setupColorPicker];
    }
    [self.view endEditing:YES];
    if(!self.colorPicker.isDropped)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.colorPicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.colorPicker.frame.size.height, self.colorPicker.frame.size.width, self.colorPicker.frame.size.height)];
            
        }
                         completion:^ (BOOL finished)
         {
             self.colorPicker.isDropped=YES;
         }];
    }
    
    else
    {
        //[self.selectedText.backgroundLayerView setHidden:YES];
        [self.backgroundLayerView setHidden:YES];
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.colorPicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.colorPicker.frame.size.width, self.colorPicker.frame.size.height)];
            
        }
                         completion:^ (BOOL finished)
         {
             self.colorPicker.isDropped=NO;
             [self.textEditor.editView becomeFirstResponder];
             
         }];
    }
}

-(void)fontPickerButtonPressed
{
    if(!self.fontPicker)
    {
        [self setupFontPicker];
    }
    [self.view endEditing:YES];
    if(!self.fontPicker.isDropped)
    {
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.fontPicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.fontPicker.frame.size.height, self.fontPicker.frame.size.width, self.fontPicker.frame.size.height)];
            
        }
                         completion:^ (BOOL finished)
         {
             self.fontPicker.isDropped=YES;
         }];
    }
    
    else
    {
        //[self.selectedText.backgroundLayerView setHidden:YES];
        [self.backgroundLayerView setHidden:YES];
        [UIView animateWithDuration:0.25 animations:^{
            
            [self.fontPicker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.fontPicker.frame.size.width, self.fontPicker.frame.size.height)];
            
        }
                         completion:^ (BOOL finished)
         {
             self.fontPicker.isDropped=NO;
             [self.textEditor.editView becomeFirstResponder];
             
         }];
    }
    
}
-(void)openColorPicker:(FCText*)text
{
    //self.selectedText=text;
    [self colorPickerButtonPressed];
}
-(void)openFontPicker:(FCText*)text
{
    //self.selectedText=text;
    [self fontPickerButtonPressed];
}

-(void)backgroundImagePicked:(UIImage *)image
{
    if(!self.collageView.hidden)
    {
        [self.collageView.backgroundImage setImage:image];
    }
    else if(!self.stripView.hidden)
    {
        [self.stripView.backgroundView setImage:image];
        self.stripView.backgroundView.contentMode=UIViewContentModeScaleAspectFill;
    }
}
-(void)colorPicked:(UIColor*)color
{
    //set color and hide text editing background
 
    [self.selectedText.textView setTextColor:color];
    [self.textEditor.editView setTextColor:color];
    [self.collageView addGestureRecognizers:self.selectedText];

}
-(void)fontPicked:(NSString *)font
{
    //set font and hide text editing background
   
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
       [self.selectedText.textView setFont:[UIFont fontWithName:font size:30]];
        [self.textEditor.editView setFont:[UIFont fontWithName:font size:30]];
    }
    else
    {
       [self.selectedText.textView setFont:[UIFont fontWithName:font size:45]];
        [self.textEditor.editView setFont:[UIFont fontWithName:font size:45]];
    }
    [self.collageView addGestureRecognizers:self.selectedText];
     //[self.textEditor setHidden:YES];
     //[self.selectedText setHidden:NO];

//    //remove text if it's empty
//    if([self.textEditor.editView.text isEqualToString:@""])
//    {
//        [self.selectedText removeFromSuperview];
//    }
    
}

-(void)customImagePick
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:^{
         [UIApplication sharedApplication].statusBarHidden=YES;  
        }];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)editingInfo{
    
    UIImage *pickedImage=[editingInfo objectForKey:UIImagePickerControllerOriginalImage];
    
    if(!self.collageView.hidden)
    {
        [self.collageView.backgroundImage setImage:pickedImage];
    }
    else if(!self.stripView.hidden)
    {
        [self.stripView.backgroundView setImage:pickedImage];
        self.stripView.backgroundView.contentMode=UIViewContentModeScaleAspectFill;
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self backgroundPickButtonPressed];
         [UIApplication sharedApplication].statusBarHidden=YES;
    }];
    
    
}

-(IBAction)dismiss //dismiss current page
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [(MainMenu *)self.presentingViewController setPictureEditingVC:self];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
       [self.popOverVC presentPopoverFromRect:CGRectMake(-320, 0, 320, 944) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:TRUE];
    }
}

-(IBAction)bottomButtonPressed:(id)sender
{
    //NSLog(@"%@",self.view.subviews);
    if( [(UIButton *)sender tag]==1)
    {
        if(self.collageView.hidden)
        {
            [self.collageView setHidden:NO];
            [self.stripView setHidden:YES];
            self.collageButtonBottomSpace.constant = 0;
            self.stripeButtonBottomSpace.constant = -15;
            [self.view layoutIfNeeded];
            if(self.pictureArray.count==0||!self.pictureArray)
            {
                 [self.popOverVC presentPopoverFromRect:CGRectMake(-320, 0, 320, 944) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:TRUE];
            }
        }
        else
        {
            //show side menu
            
            [self clickSideMenu];
            
        }
    }
    else if( [(UIButton *)sender tag]==2)
    {
        if(self.collageView.hidden)
        {
            [self clickSideMenu];
        }
        else
        {
            if(!self.stripView)
            {
                [self setupStripView:self.pictureArray];
            }
            [self.stripView setHidden:NO];
            [self.collageView setHidden:YES];
            //[self.sideMenu setFrame:CGRectMake(-self.sideMenu.frame.size.width, 0, self.sideMenu.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
            self.collageButtonBottomSpace.constant = -15;
            self.stripeButtonBottomSpace.constant = 0;
            [self.view layoutIfNeeded];
            if(self.pictureArray.count==0||!self.pictureArray)
            {
                [self.popOverVC presentPopoverFromRect:CGRectMake(-320, 0, 320, 944) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:TRUE];
            }
            
            
            
        }
    }
}

-(IBAction)clickSideMenu
{
    
    if(!self.sideMenu)
    {
        [self setupSideMenu];
    }
    
    if(!self.sideMenu.isOpen)
    {
        
        if(self.backgroundPicker.isDropped)
        {
            [self backgroundPickButtonPressed];
        }
        
        if(self.colorPicker.isDropped)
        {
            [self colorPickerButtonPressed];
        }
        
        [self.view endEditing:YES];
        
        if(self.stripView&&!self.stripView.isHidden)
        {
            [self.sideMenu.textButton setHidden:YES];
        }
        else
        {
            [self.sideMenu.textButton setHidden:NO];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
            //[self.sideMenu setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            [self.sideMenu setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2)];
            self.sideButtonTraillingSpace.constant = -30;
            [self.view layoutIfNeeded];
            [self.sideButton setAlpha:0];
            
        }
                         completion:^ (BOOL finished)
         
         {
             self.sideMenu.isOpen=YES;
         }];
        
    }
    else
    {
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.sideButton setAlpha:1];
            float width=[UIScreen mainScreen].bounds.size.width;
            [self.sideMenu setFrame:CGRectMake([UIScreen mainScreen].bounds.size.height, 0, width, [UIScreen mainScreen].bounds.size.height)];
            self.sideButtonTraillingSpace.constant = 0;
            [self.view layoutIfNeeded];
        }
                         completion:^ (BOOL finished)
         {
             self.sideMenu.isOpen=NO;
             
         }];
        
    }
}


-(void)showLoadingAnimation
{
    if(!self.indicatorView)
    {
        self.indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicatorView.hidesWhenStopped=YES;
        [self.indicatorView startAnimating];
        [self.indicatorView setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2) ];
        [self.view addSubview:self.indicatorView];
    }
    else
    {
        [self.indicatorView startAnimating];
    }
}
-(void)saveToPhotoAlbums
{
    
    if(!self.collageView.hidden)
    {
        [self saveCollageView];
        
    }
    else if(!self.stripView.hidden)
    {
        [self saveStripView];
        
    }
    
}

-(void)saveCollageView
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    UIGraphicsBeginImageContextWithOptions(self.collageView.frame.size, NO, 6.0);
    }
    else
    {
     UIGraphicsBeginImageContextWithOptions(self.collageView.frame.size, NO, 3.0);
    }
    [self.collageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
-(void)saveStripView
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    UIGraphicsBeginImageContextWithOptions(self.stripView.contentSize, NO, 6.0);
    }
    else
    {
     UIGraphicsBeginImageContextWithOptions(self.stripView.contentSize, NO, 1.0);
    }
    [self.stripView.layer renderInContext:UIGraphicsGetCurrentContext()];
    CGFloat curY=10;
    CGFloat height;
    for (height=self.stripView.contentSize.height; height>0; height=height-250) {
        
        CGRect tmp=CGRectMake(0	,curY,320,250);
        [self.stripView scrollRectToVisible:tmp animated:NO];
        [self.stripView.layer renderInContext:UIGraphicsGetCurrentContext()];
        curY+=250;
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}




- (void)image: (UIImage *) image
didFinishSavingWithError: (NSError *) error
  contextInfo: (void *) contextInfo
{
    [self.indicatorView stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SAVED TO CAMERA ROLL", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"CONTINUE", nil) otherButtonTitles:NSLocalizedString(@"NEW", nil), nil];
    
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        
        [self dismiss];
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
        [(FCPictureRoll *)[(MainMenu *)self.presentingViewController pictureRoll] resetPhotos];
        }
        else
        {
            [(FCPictureRoll*)[(MainMenu *)self.popOverVC.contentViewController pictureRoll] resetPhotos];
        }
        for(id obj in self.collageView.subviews)
        {
            if([obj isKindOfClass:[FCPicture class]]||[obj isKindOfClass:[FCText class]])
            {
                [obj removeFromSuperview];
            }
        }
       //  [self.collageView.subviews  makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}

-(void)openShareMenu
{
    
    
    if(!self.collageView.hidden)
    {
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
        UIGraphicsBeginImageContextWithOptions(self.collageView.frame.size, NO, 6.0);
        }
        else
        {
         UIGraphicsBeginImageContextWithOptions(self.collageView.frame.size, NO, 1.0);
        }
        [self.collageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        //[self.collageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    else
    {
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
        UIGraphicsBeginImageContextWithOptions(self.stripView.contentSize, NO, 6.0);
        }
        else
        {
        UIGraphicsBeginImageContextWithOptions(self.stripView.contentSize, NO, 1.0);
        }
        [self.stripView.layer renderInContext:UIGraphicsGetCurrentContext()];
        CGFloat curY=10;
        CGFloat height;
        for (height=self.stripView.contentSize.height; height>0; height=height-250) {
            
            CGRect tmp=CGRectMake(0	,curY,320,250);
            [self.stripView scrollRectToVisible:tmp animated:NO];
            [self.stripView.layer renderInContext:UIGraphicsGetCurrentContext()];
            curY+=250;
        }
        
    }
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    NSArray *Items   = [NSArray arrayWithObjects:
                        image, nil];
    UIActivityViewController *ActivityView = [[UIActivityViewController alloc]
                                              initWithActivityItems:Items
                                              applicationActivities:nil] ;
    [ActivityView setExcludedActivityTypes:
     @[UIActivityTypeAssignToContact,
       UIActivityTypeSaveToCameraRoll]];
    
    [self presentViewController:ActivityView animated:YES completion:^{
        [self.indicatorView stopAnimating];
    }];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)beginTextEditing:(FCText*)text
{
  
    //disable gesture recognizer
    self.selectedText=text;
    [self.selectedText setHidden:YES];
    
    if(!self.textEditor)
    {
        self.textEditor=[[FCTextEditor alloc] initWithFrame:CGRectMake(0, 0, self.collageView.frame.size.width, self.collageView.frame.size.height)];
        self.textEditor.editView.delegate=self;
        [self.collageView addSubview:self.textEditor];
        [self.textEditor.editView becomeFirstResponder];
        
    }
    else
    {
        [self.textEditor updateText:self.selectedText.textView.text];
        [self.textEditor setHidden:NO];
        [self.collageView bringSubviewToFront:self.textEditor];
        [self.textEditor.editView becomeFirstResponder];
    }
    //[self.textEditor.editView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.1];
}



- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    [self.selectedText.textView setText:textView.text];
    
    if ([text isEqualToString:@"\n"])
    {
        //hide keyboard
        [self.view endEditing:YES];

        [self.selectedText.textView sizeToFit];
        [self.selectedText setFrame:CGRectMake(self.selectedText.frame.origin.x, self.selectedText.frame.origin.y, self.selectedText.textView.frame.size.width, self.selectedText.textView.frame.size.height)];

        [self.textEditor setHidden:YES];
        [self.selectedText setHidden:NO];
        //remove text if it's empty
        if([textView.text isEqualToString:@""])
        {
            //[textView.superview removeFromSuperview];
            [self.selectedText removeFromSuperview];
        }
        
    }
    
    return YES;
}


@end
