//
//  TileScrollView.m
//  Resultly
//
//  Created by Yang Song on 4/25/13.
//  Copyright (c) 2013 Resultly. All rights reserved.
//

#import "TileScrollView.h"


@implementation TileScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(id)scrollViewWithFrame:(CGRect)frame
                tileSize:(CGSize)size
              itemsArray:(NSArray*)array
            tileNumber:(int)number
{
    return [[self alloc] initWithFrame:frame tileSize:size itemsArray:array tileNumber:number];
}

-(id)initWithFrame:(CGRect)frame
          tileSize:(CGSize)size
        itemsArray:(NSArray*)array
        tileNumber:(int)number
{
    
    self = [super initWithFrame:frame];
    
   // [self setFrame:frame];
   // self.pagingEnabled=YES;
    self.tileSize=size;
    self.itemArray=[NSMutableArray arrayWithArray:array];
    self.itemNumbers=number;
    self.insetX=10;
    self.insetY=5;
    self.minimumMarginLine=5;
    self.minimumMarginRow=4;
    [self calculateItemsPerLineAndRow];
    [self calculateContentSize];
    return self;
}


-(void)setInsetX:(int)insetX andInsetY:(int)insetY andMinimumMarginLine:(int)marginLine andMinimumMarginRow:(int)marginRow
{
    
    self.insetX=insetX;
    self.insetY=insetY;
    self.minimumMarginLine=marginLine;
    self.minimumMarginRow=marginRow;
    
    [self calculateItemsPerLineAndRow];
    [self calculateContentSize];
    
}


-(void)calculateItemsPerLineAndRow
{
    float mainContentwidth=self.frame.size.width-self.insetX*2;
    float tileWidth=self.tileSize.width;
    
    float mainContentHeight=self.frame.size.height-self.insetY*2;
    float tileHeight=self.tileSize.height;
    
    int n=mainContentwidth/tileWidth;
    while (n*tileWidth+(n-1)*self.minimumMarginLine>mainContentwidth) {
        n--;
    }
    int m=mainContentHeight/tileHeight;
    while (m*tileHeight+(m-1)*self.minimumMarginRow>mainContentHeight) {
        
        m--;
    }
    
    self.itemsPerLine=n;
    if(n==1)
    {
        self.marginLine=0;
    }
    else
    {
    self.marginLine=(mainContentwidth-n*tileWidth)/(n-1);
     }
    self.itemsPerRow=m;
    if(m==1)
    {
        self.marginRow=0;
    }
    else
    {
    self.marginRow=(mainContentHeight-m*tileHeight)/(m-1);
    }
}

-(void)calculateContentSize
{
    
    int remain=self.itemNumbers/(self.itemsPerLine*self.itemsPerRow);
    if(!self.itemNumbers%(self.itemsPerLine*self.itemsPerRow)==0)
    {
        remain++;
    }
    [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height*remain)];
}

-(void)loadItem:(UIView*)view atAtIndex:(int)index
{
    //figure out page, linw, row index of the item
    int itemsPerPage=self.itemsPerRow*self.itemsPerLine;
    int indexOnPage=index%itemsPerPage;
    int pageIndex=index/itemsPerPage;
    int lineIndex=indexOnPage%self.itemsPerLine;
    int rowIndex=indexOnPage/self.itemsPerLine;
    
    //figure out position of the item
    
    int x=self.insetX+lineIndex*(self.tileSize.width+self.marginLine);
    int y=self.frame.size.height*pageIndex+self.insetY+rowIndex*(self.tileSize.height+self.marginRow);
    
    [view setFrame:CGRectMake(x, y, view.frame.size.width, view.frame.size.height)];
    [self addSubview:view];
    
    
}
-(void)clearView
{
    for(id obj in self.subviews)
    {
        [obj removeFromSuperview];
    }
}
-(void)loadItemsFromArray
{
    [self clearView];
//     ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
//    
//    [self.itemArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
//    {
//        NSURL *url=[NSURL URLWithString:(NSString*)obj];
//        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//            UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
//            
//            FCPreviewPicture *previewPicture=[[FCPreviewPicture alloc] initWithImage:image andImageUrl:(NSString*)obj];
//            [previewPicture setFrame:CGRectMake(0, 0, 100, 100)];
//            previewPicture.delegate=self;
//            //previewPicture.clipsToBounds=YES;
//            [self loadItem: previewPicture atAtIndex:(self.itemNumbers-idx-1)];
//            /*
//             UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 107)];
//             [imageView setImage:image];
//             [self loadItem: imageView atAtIndex:(self.itemArray.count-i-1)];
//             */
//            if(idx==self.itemNumbers-1)
//            {
//                NSLog(@"End loading");
//                [self.tileScrollViewdelegate completeLoading];
//            }
//            if(stop)
//            {
//               // [self.tileScrollViewdelegate completeLoading];
//            }
//            
//            
//        }failureBlock:^(NSError *error) {
//            NSLog(@"error=%@",error);
//        }
//         ];
//
//    }];
    for(int i=0;i<self.itemNumbers;i++)
    {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, 75)];
       // [view setBackgroundColor:[UIColor redColor]];
        [self loadItem:view atAtIndex:i];
        
        
    }
        
    }

 
-(void)addImageUrl:(NSString*)imageUrl andImage:(UIImage *)image
{
    if(!self.selectedArray)
    {
        self.selectedArray=[[NSMutableArray alloc] init];
    }
    [self.selectedArray addObject:imageUrl];
    [self.tileScrollViewdelegate imageClicked:image andImageUrl:imageUrl];
}
-(void)deleteImage:(NSString*)imageUrl
{
    if(!self.selectedArray)
    {
        self.selectedArray=[[NSMutableArray alloc] init];
    }
    for(int i=0;i<self.selectedArray.count;i++)
    {
        if([imageUrl isEqualToString:[self.selectedArray objectAtIndex:i]])
        {
            [self.selectedArray removeObjectAtIndex:i];
            break;
        }
    }

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
