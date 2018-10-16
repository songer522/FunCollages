//
//  TileScrollView.h
//  Resultly
//
//  Created by Yang Song on 4/25/13.
//  Copyright (c) 2013 Resultly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "FCPreviewPicture.h"
@protocol TileScrollViewDelegate <NSObject>

-(void)imageClicked:(UIImage*)image andImageUrl:(NSString *)url;
-(void)completeLoading;


@end
@interface TileScrollView : UIScrollView<FCPreviewPictureDelegate>
@property(nonatomic,strong)NSMutableArray *itemArray;
@property(nonatomic,strong)NSMutableArray *selectedArray;
@property(nonatomic,assign)CGSize          tileSize;
@property(nonatomic,assign)int             itemNumbers;
@property(nonatomic,assign)int             itemsPerLine;
@property(nonatomic,assign)int             itemsPerRow;
@property(nonatomic,assign)int             insetX;
@property(nonatomic,assign)int             insetY;
@property(nonatomic,assign)int             minimumMarginLine;
@property(nonatomic,assign)int             minimumMarginRow;
@property(nonatomic,assign)float           marginLine;
@property(nonatomic,assign)float           marginRow;
@property (nonatomic,assign)id<TileScrollViewDelegate> tileScrollViewdelegate;
+(id)scrollViewWithFrame:(CGRect)frame
                tileSize:(CGSize)size
              itemsArray:(NSArray*)array
              tileNumber:(int)number;
-(void)setInsetX:(int)insetX andInsetY:(int)insetY andMinimumMarginLine:(int)marginLine andMinimumMarginRow:(int)marginRow;
-(void)loadItem:(UIView*)view atAtIndex:(int)index;
-(void)loadItemsFromArray;
@end
