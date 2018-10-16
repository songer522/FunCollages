//
//  FCCollageView.m
//  Fun collages
//
//  Created by Yang Song on 3/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCCollageView.h"
#include <stdlib.h>
#import "FCPictureEditingVC.h"
#define ARC4RANDOM_MAX      0x100000000
@implementation FCCollageView

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
    self=[super init];
    if(self)
    {
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            self=[[[NSBundle mainBundle] loadNibNamed:@"FCCollageView_iPhone" owner:self options:nil] objectAtIndex:0];
        }
        else
        {
            self=[[[NSBundle mainBundle] loadNibNamed:@"FCCollageView_iPad" owner:self options:nil] objectAtIndex:0];
        }
        self.clipsToBounds=YES;
    }
    
    return self;
}


-(void)addText
{
    FCText *testText;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        testText=[[FCText alloc] initWithText:NSLocalizedString(@"TEXT EDITING PROMT", nil) frame:CGRectMake(100, 300, 300, 200) atPoint:CGPointMake(160, 200)];
    }
    else
    {
        testText=[[FCText alloc] initWithText:NSLocalizedString(@"TEXT EDITING PROMT", nil) frame:CGRectMake(350, 500, 600, 200) atPoint:CGPointMake(380, 500)];
    }
    
    testText.textView.delegate=(FCPictureEditingVC*)self.parentVC;
    [self addGestureRecognizers:testText];
    [self addSubview:testText];
}

-(void)loadPictures:(NSArray*)pictureArray
{
    if(!self.assetsLibrary)
    {
    self.assetsLibrary=[[ALAssetsLibrary alloc] init];
    }
    if(!self.pictures)
    {
        self.pictures=[[NSMutableArray alloc] init];
    }
    
    
    for(PHAsset *obj in pictureArray)
    {
        
        [self loadPicture:obj];
    }
    
    }

-(void)removeDeletedPictures
{
    for(id obj in self.subviews)
    {
        if([obj isKindOfClass:[FCPicture class]])
        {
            BOOL shouldDelete=YES;
            for(PHAsset *url in self.pictures)
            {
                
                if([url.localIdentifier isEqualToString:[[(FCPicture *)obj asset] localIdentifier]])
                {
                    shouldDelete=NO;
                }
            }
            if(shouldDelete)
            {
            [obj removeFromSuperview];
            }
        }
    }
}

-(void)loadPicture:(PHAsset*)urlString
{
//    if([self.pictures containsObject:urlString])
//    {
//        return;
//    }
//    let options = PHImageRequestOptions()
//    options.resizeMode = PHImageRequestOptionsResizeMode.Fast
//    options.deliveryMode = PHImageRequestOptionsDeliveryMode.Opportunistic
//    options.networkAccessAllowed = true
//    let targetSize = CGSize(width: 1000, height: asset.pixelHeight*1000/asset.pixelWidth)

    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    option.networkAccessAllowed = YES;
    
    
    CGSize targetSize = CGSizeMake(500, urlString.pixelHeight*500/urlString.pixelWidth);
    [[PHImageManager defaultManager] requestImageForAsset:urlString targetSize:targetSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
     
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           float ratioWidth=1.0;
                           float ratioHeight=1.0;
                           float s=image.size.height/image.size.width;
                           if (s>=1) {
                               ratioHeight=s;
                           }
                           else
                           {
                               ratioWidth=1/s;
                           }
                           if (image != nil && image.size.width > 300) {
                           FCPicture *picture;
                           if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                           {
                               picture=[[FCPicture alloc] initWithImage:image frame:CGRectMake(0, 0, 100*ratioWidth, 100*ratioHeight) withRotation:[self getRandomFloat] atPoint:CGPointMake([self getRandomNumberBetween:150 to:170], [self getRandomNumberBetween:200 to:220])];
                           }
                           else
                           {
                               picture=[[FCPicture alloc] initWithImage:image frame:CGRectMake(0, 0, 200*ratioWidth, 200*ratioHeight) withRotation:[self getRandomFloat] atPoint:CGPointMake([self getRandomNumberBetween:350 to:370], [self getRandomNumberBetween:500 to:520])];
                               
                           }
                           //picture.pictureURL=urlString;
                           picture.asset = urlString;
                           [self addGestureRecognizers:picture];
                           [self addSubview:picture];
                           }
                       });
        
      
        
    }];
    
    
//    
//    NSURL *url=[NSURL URLWithString:urlString];
//    [self.assetsLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//        //UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
//        UIImage *image=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//        float ratioWidth=1.0;
//        float ratioHeight=1.0;
//        float s=image.size.height/image.size.width;
//        if (s>=1) {
//            ratioHeight=s;
//        }
//        else
//        {
//            ratioWidth=1/s;
//        }
//        FCPicture *picture;
//        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//        picture=[[FCPicture alloc] initWithImage:image frame:CGRectMake(0, 0, 100*ratioWidth, 100*ratioHeight) withRotation:[self getRandomFloat] atPoint:CGPointMake([self getRandomNumberBetween:150 to:170], [self getRandomNumberBetween:200 to:220])];
//        }
//        else
//        {
//            picture=[[FCPicture alloc] initWithImage:image frame:CGRectMake(0, 0, 200*ratioWidth, 200*ratioHeight) withRotation:[self getRandomFloat] atPoint:CGPointMake([self getRandomNumberBetween:350 to:370], [self getRandomNumberBetween:500 to:520])];
//   
//        }
//        picture.pictureURL=urlString;
//        [self addGestureRecognizers:picture];
//        [self addSubview:picture];
//    }failureBlock:^(NSError *error) {
//        NSLog(@"error=%@",error);
//    }
//     ];

}
-(void)addGestureRecognizers:(UIView *)aView
{
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)] ;
    [rotationRecognizer setDelegate:self];
    [aView addGestureRecognizer:rotationRecognizer];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)] ;
    [pinchRecognizer setDelegate:self];
    [aView addGestureRecognizer:pinchRecognizer];
    
    
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)] ;
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [aView addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)] ;
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setDelegate:self];
    [aView addGestureRecognizer:tapRecognizer];
    
    
    
    if([aView isKindOfClass:[FCText class]])
    {
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:(FCText*)aView action:@selector(doubleTapped)];
    [doubleTapRecognizer setNumberOfTapsRequired:2];
    [doubleTapRecognizer setDelegate:self];
    [aView addGestureRecognizer:doubleTapRecognizer];
    [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        
        
        [(FCText*)aView setRotationGestureRecognizer:rotationRecognizer];
        [(FCText*)aView setPinchGestureRecongizer:pinchRecognizer];
        [(FCText*)aView setPanGestureRecognizer:panRecognizer];
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}
-(double)getRandomFloat{
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    
    return  val-0.5;
}

-(void)scale:(id)sender {
    [[(UIPinchGestureRecognizer*)sender view].superview bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform =[[(UIPinchGestureRecognizer*)sender view] transform];
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [[(UIPinchGestureRecognizer*)sender view] setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
    //[self showOverlayWithFrame:photoImage.frame];
}

-(void)rotate:(id)sender {
    [[(UIRotationGestureRecognizer*)sender view].superview bringSubviewToFront:[(UIRotationGestureRecognizer*)sender view]];
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    // NSLog(@"rotation is:%f",rotation);
    CGAffineTransform currentTransform = [[(UIRotationGestureRecognizer*)sender view] transform];
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [[(UIRotationGestureRecognizer*)sender view] setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
    //[self showOverlayWithFrame:photoImage.frame];
}


-(void)move:(id)sender {
    [[(UIPanGestureRecognizer*)sender view].superview bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:[(UIPanGestureRecognizer*)sender view].superview];
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        
        if([[(UIPanGestureRecognizer*)sender view] isKindOfClass:[FCPicture class]] || [[(UIPanGestureRecognizer*)sender view] isKindOfClass:[FCText class]] )
        {
            [(FCPicture*)[(UIPanGestureRecognizer*)sender view] setPointX: [[(UIPanGestureRecognizer*)sender view] center].x];
            [(FCPicture*)[(UIPanGestureRecognizer*)sender view] setPointY:[[(UIPanGestureRecognizer*)sender view] center].y];
        }
    }
     if([[(UIPanGestureRecognizer*)sender view] isKindOfClass:[FCPicture class]] || [[(UIPanGestureRecognizer*)sender view] isKindOfClass:[FCText class]] )
     {
    translatedPoint = CGPointMake([(FCPicture*)[(UIPanGestureRecognizer*)sender view] pointX]+translatedPoint.x, [(FCPicture*)[(UIPanGestureRecognizer*)sender view] pointY]+translatedPoint.y);
     }
    [[(UIPanGestureRecognizer*)sender view] setCenter:translatedPoint];
    //[self showOverlayWithFrame:photoImage.frame];
}

-(void)tapped:(id)sender {
    [[(UITapGestureRecognizer*)sender view].superview bringSubviewToFront:[(UITapGestureRecognizer*)sender view]];
    CGAffineTransform currentTransform =[[(UITapGestureRecognizer*)sender view] transform];
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.2, 1.2);
    CGAffineTransform newTransform2 = CGAffineTransformScale(currentTransform, 1.0, 1.0);
    [UIView animateWithDuration:0.25 animations:^{
        
       [[(UITapGestureRecognizer*)sender view] setTransform:newTransform];
        
    }
                     completion:^ (BOOL finished)
     
     {
         [UIView animateWithDuration:0.15 animations:^{
              [[(UITapGestureRecognizer*)sender view] setTransform:newTransform2];
             
         }
                          completion:^ (BOOL finished)
          
          {
              
          }];
     }];
    
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
