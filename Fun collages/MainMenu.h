//
//  MainMenu.h
//  Fun collages
//
//  Created by Song on 1/16/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FCImagePicker.h"
#import "TileScrollView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FCPreviewPicture.h"
#import "FCPictureRoll.h"
#import "FCPictureEditingVC.h"
#import <Photos/Photos.h>

//#import "PhotoLibaryViewController.h"

@interface MainMenu : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSXMLParserDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TileScrollViewDelegate,FCPreviewPictureDelegate, NSURLSessionDelegate>
{
}
@property(nonatomic,strong)IBOutlet UIButton *   buttonPhotoLibary;
@property(nonatomic,strong)IBOutlet UIButton *   buttonCamera;
@property(nonatomic,strong)IBOutlet UIView   *   menuView;
@property(nonatomic,strong)IBOutlet UIImageView *lauchScreen;
@property(nonatomic,strong)IBOutlet UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray *      imagesArray;
@property(nonatomic,strong)NSMutableArray *      additionalImageArray;
@property(nonatomic,strong)ALAssetsLibrary *assetsLibrary;
@property(nonatomic,strong)FCPictureRoll * pictureRoll;
@property(nonatomic,strong)FCPictureEditingVC *  pictureEditingVC;
@property(nonatomic,strong)PHImageManager *imageManager;
-(IBAction)cameraButtonPressed;


@end
