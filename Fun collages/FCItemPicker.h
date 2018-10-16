//
//  BackgroundPicker.h
//  Fun collages
//
//  Created by Song on 1/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileScrollView.h"

typedef enum {
    BACKGROUND,
    COLOR,
    FONT
}PickerType;

@protocol FCBackgroundPickerDelegate <NSObject>
-(void)backgroundImagePicked:(UIImage*)image;
-(void)colorPicked:(UIColor*)color;
-(void)fontPicked:(NSString*)font;
-(void)backgroundPickButtonPressed;
-(void)colorPickerButtonPressed;
-(void)fontPickerButtonPressed;
-(void)customImagePick;

@end



@interface FCItemPicker : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,assign)BOOL    isDropped;
@property(nonatomic,assign)PickerType pickerType;
@property(nonatomic,assign)BOOL    isBackgroundPicker;
@property(nonatomic,assign)BOOL    isBold;
@property(nonatomic,assign)BOOL    isitalic;
@property(nonatomic,strong)IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)IBOutlet TileScrollView *tileScrollView;
@property(nonatomic,strong)NSArray    *itemArray;
@property (nonatomic,strong)id<FCBackgroundPickerDelegate> delegate;
-(IBAction)doneButtonPressed;

-(id)initWithBackground;
-(id)initWithColor;
-(id)initWithFont;
@end
