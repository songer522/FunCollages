//
//  FCSideMenu.h
//  Fun collages
//
//  Created by Yang Song on 8/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CloseSideMenu)(void);
typedef void (^GotoPhotos)(void);
typedef void (^AddText)(void);
typedef void (^SaveCollage)(void);
typedef void (^ChangeBackground)(void);
typedef void (^OpenShareMenu)(void);
@interface FCSideMenu : UIView

@property(nonatomic,strong)IBOutlet UIView * buttonsView;
@property(nonatomic,strong)IBOutlet UIButton *dismissButton;
@property(nonatomic,assign)BOOL        isOpen;
@property(nonatomic,strong)IBOutlet UIButton *textButton;
@property(nonatomic,copy)CloseSideMenu closeSideMenu;
@property(nonatomic,copy)GotoPhotos    gotoPhotos;
@property(nonatomic,copy)AddText       addText;
@property(nonatomic,copy)SaveCollage   saveCollage;
@property(nonatomic,copy)ChangeBackground changeBackground;
@property(nonatomic,copy)OpenShareMenu openShareMenu;
- (IBAction)GotoPhotos:(id)sender;
- (IBAction)MenuClose:(id)sender;
- (IBAction)SaveToAlbum:(id)sender;
-(IBAction)GotBackGround:(id)sender;
- (IBAction)OpenShareMenu:(id)sender;
- (IBAction)AddText:(id)sender;
@end
