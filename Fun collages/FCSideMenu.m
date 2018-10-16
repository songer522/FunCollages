//
//  FCSideMenu.m
//  Fun collages
//
//  Created by Yang Song on 8/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCSideMenu.h"

@implementation FCSideMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"FCSideMenu_iPad" owner:self options:nil] objectAtIndex:0];
        // self=[[[NSBundle mainBundle] loadNibNamed:@"FCSideMenu_iPad" owner:self options:nil] objectAtIndex:0];
    }
    else
    {
       self=[[[NSBundle mainBundle] loadNibNamed:@"FCSideMenu" owner:self options:nil] objectAtIndex:0];
    }
   
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)GotoPhotos:(id)sender {
    self.gotoPhotos();
}

- (IBAction)MenuClose:(id)sender {
    self.closeSideMenu();
}

- (IBAction)SaveToAlbum:(id)sender {
    self.saveCollage();
}

-(IBAction)GotBackGround:(id)sender
{
    self.changeBackground();
}

- (IBAction)OpenShareMenu:(id)sender {
    self.openShareMenu();
}
- (IBAction)AddText:(id)sender {
    self.addText();
}



@end
