//
//  MainMenu.m
//  Fun collages
//
//  Created by Song on 1/16/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "MainMenu.h"
@interface MainMenu ()

@end

@implementation MainMenu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.imageManager = [PHImageManager defaultManager];
    //if(self.imagesArray)
    //{
    [self getImgs:nil];
    //}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.assetsLibrary=[[ALAssetsLibrary alloc] init];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];
    self.pictureRoll=[FCPictureRoll pictureRoll];
    [self.pictureRoll setFrame:CGRectMake(0, self.menuView.frame.size.height-100, self.view.frame.size.width, self.pictureRoll.frame.size.height)];
    [self.pictureRoll.pictureScrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.pictureRoll.frame.size.height)];
    __weak typeof(self) weakSelf=self;
    self.pictureRoll.removePicture=^(PHAsset *url)
    {
        
        if(weakSelf.pictureRoll.imageStack.count==0)
        {
            //[self.menuView setFrame:CGRectMake(0, self.view.frame.size.height-60, self.menuView.frame.size.width, self.menuView.frame.size.height)];
            [weakSelf.menuView setFrame:CGRectMake(0, weakSelf.view.frame.size.height-60, weakSelf.view.frame.size.width, weakSelf.menuView.frame.size.height)];
            if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
            {
             weakSelf.pictureEditingVC=nil;
            }
           else
           {
               
    
           }
        }
        if(weakSelf.additionalImageArray)
        {
            [weakSelf.additionalImageArray removeObject:url];
        }
    };
    [self.menuView addSubview:self.pictureRoll];
    //[self getImgs:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Initial loading methods

-(void)loadImage

{
    [self.collectionView reloadData];
    [self completeLoading];
}
-(void)completeLoading
{
    [self.lauchScreen setHidden:YES];
}
-(void)getImgs:(UIImage*)image
{
    if(!self.imagesArray)
    {
        self.imagesArray=[[NSMutableArray alloc] init];
    }
     [self.imagesArray removeAllObjects];
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    //option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)];
    option.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:false]];
    option.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"mediaType = %ld", (long)PHAssetMediaTypeImage]];
    
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:option];
    
    [result enumerateObjectsUsingBlock:^(PHAsset*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.imagesArray addObject:obj];
    }];
    
    
//    
//    
//  
//    int count=self.imagesArray.count;
//   
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        
//        
//        ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
//            NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
//            if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
//                NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
//            }else{
//                NSLog(@"相册访问失败.");
//            }
//        };
//        
//        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result,NSUInteger index, BOOL *stop){
//            if (result!=NULL) {
//                
//                if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
//                    
//                    NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
//                    [self.imagesArray addObject:urlstr];
//                }
//            }
//            
//        };
//        ALAssetsLibraryGroupsEnumerationResultsBlock
//        libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop){
//            
//            if (group == nil)
//            {
//                if(self.imagesArray.count>0)
//                {
//                    if(image)
//                    {
//                        
//                        [self imageClicked:image andImageUrl:[self.imagesArray lastObject]];
//                    }
//                    else
//                    {
//                        if(self.imagesArray.count!=count)
//                        {
//                        [self loadImage];
//                        }
//                    }
//                }
//            }
//            if(stop)
//            {
//                
//                
//            }
//            if (group!=nil) {
//                
//                NSLog(@"type:%@",[group valueForProperty:ALAssetsGroupPropertyName]);
//                //[group enumerateAssetsUsingBlock:groupEnumerAtion];
//                if([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"All Photos"])
//                {
//                  [group enumerateAssetsUsingBlock:groupEnumerAtion];
//                }
//            }
//            
//        };
//        
//        
//        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
//                                          usingBlock:libraryGroupsEnumeration
//                                        failureBlock:failureblock];
//        
//        
//        
//    });
    
}


#pragma mark IBAction methods

-(IBAction)cameraButtonPressed
{
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *cameraController=[[UIImagePickerController alloc] init];
        cameraController.sourceType=UIImagePickerControllerSourceTypeCamera;
        cameraController.showsCameraControls=YES;
        cameraController.delegate=self;
        [self presentViewController:cameraController animated:YES completion:nil];
    }
    
}
-(IBAction)continueButtonPressed
{

    if(self.pictureRoll.imageStack.count<2)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"MINIMUM PHOTOS PROMT", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OKAY", nil) otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    
    
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        
        //[self.pictureEditingVC updateCollageViewPictures:self.additionalImageArray];
        self.pictureEditingVC.pictureArray=self.pictureRoll.imageStack;
        [self.pictureEditingVC updateCollageViewPictures:self.pictureRoll.imageStack withAdditionalPictures:self.additionalImageArray];
        [self.pictureEditingVC updateStripViewPictures:self.pictureRoll.imageStack];
        [self.additionalImageArray removeAllObjects];
        [self.pictureEditingVC.popOverVC dismissPopoverAnimated:YES];
        
    }
    else
    {
        if(!self.pictureEditingVC)
        {
            FCPictureEditingVC *peVC=[[FCPictureEditingVC alloc] initWithPictures:self.pictureRoll.imageStack];
            peVC.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:peVC animated:YES completion:nil];
        }
        else
        {
            //[self.pictureEditingVC updateCollageViewPictures:self.additionalImageArray];
            [self.pictureEditingVC updateCollageViewPictures:self.pictureRoll.imageStack withAdditionalPictures:self.additionalImageArray];
            [self.pictureEditingVC updateStripViewPictures:self.pictureRoll.imageStack];
            [self presentViewController:self.pictureEditingVC animated:YES completion:nil];
            
        }
        [self.additionalImageArray removeAllObjects];
    }
}

-(void)imageClicked:(UIImage*)image andImageUrl:(PHAsset *)url
{
    if(self.pictureRoll.imageStack.count==0)
    {
        [self.menuView setFrame:CGRectMake(0, self.view.frame.size.height-160, self.menuView.frame.size.width, self.menuView.frame.size.height)];
    }
    [self.pictureRoll addPicture:image andUrl:url];
    if(self.pictureEditingVC)
    {
        if(!self.additionalImageArray)
        {
            self.additionalImageArray=[[NSMutableArray alloc] init];
        }
        [self.additionalImageArray addObject:url];
    }
}
#pragma mark UIimagePicker Camera delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)editingInfo
{
    //self.imagePicker.pictureRoll.hidden=NO;
    UIImage *image=[editingInfo objectForKey:UIImagePickerControllerOriginalImage];
     ALAssetsLibrary * library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error )
     {
         NSLog(@"IMAGE SAVED TO PHOTO ALBUM");
         [library assetForURL:assetURL resultBlock:^(ALAsset *asset )
          {
             
              [self uploadImage:assetURL];
             
              NSString *urlString=[assetURL absoluteString];
               //NSLog(@"we have our ALAsset:%@",urlString);
               [self imageClicked:image andImageUrl:urlString];
               [self dismissViewControllerAnimated:YES completion:nil];
          }
                 failureBlock:^(NSError *error )
          {
              NSLog(@"Error loading asset");
          }];
     }];
  
    
}
-(void)uploadImage:(NSURL *)url
{
    const NSString *boundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    const NSString *fileParamConstant = @"photo";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryConstant];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    NSString *filename = @"imageFile";
    [library assetForURL:url resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        
        // get byte size of image
        long long size = [representation size];
        unsigned char *bytes = malloc(size);
        
        // read image data into bytes array
        [representation getBytes:bytes fromOffset:0 length:size error:nil];
        
        NSData *imageData = [NSData dataWithBytesNoCopy:bytes length:size freeWhenDone:YES];
        
        if (imageData) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileParamConstant, filename] dataUsingEncoding:NSUTF8StringEncoding]];
//            [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",[SWNetworkController contentTypeForImageData:imageData]] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSString *postLength = [NSString stringWithFormat:@"%zu", [body length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [request setHTTPBody:body];
        
        NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"STRING %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSLog(@"%@", response);
            NSLog(@"%@", error);
        }];
        [uploadTask resume];
    } failureBlock:^(NSError *error) {
        
        NSLog(@"Image error:\n%@",error);
    }];
}
     


- (void) image: (UIImage *) image
didFinishSavingWithError: (NSError *) error
   contextInfo: (void *) contextInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self getImgs:image];
    
}
#pragma mark UICollectionView delegate methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    FCPreviewPicture *previewPicture=[[FCPreviewPicture alloc] initWithImage:nil andImageUrl:[self.imagesArray objectAtIndex:indexPath.row]];
    [previewPicture setFrame:CGRectMake(0, 0, 100, 100)];
    
    
    PHAsset *asset = [self.imagesArray objectAtIndex:indexPath.row];
    
    CGSize targetSize = CGSizeMake(200, 200);
    
    
    [self.imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        [previewPicture.previewImageView setImage:result];
        previewPicture.delegate = self;
        for(UIView *obj in cell.subviews)
        {
            if ([obj isKindOfClass:[FCPreviewPicture class]]) {
                [obj removeFromSuperview];
            }
        }
        [cell addSubview: previewPicture];
    }];
    
//NSURL *url=[NSURL URLWithString:[self.imagesArray objectAtIndex:self.imagesArray.count-indexPath.row-1]];
//    [self.assetsLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
//        UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
//        [previewPicture.previewImageView setImage:image];
//        previewPicture.delegate=self;
//        for(UIView *obj in cell.subviews)
//        {
//            if ([obj isKindOfClass:[FCPreviewPicture class]]) {
//                [obj removeFromSuperview];
//            }
//        }
//        [cell addSubview: previewPicture];
//    }failureBlock:^(NSError *error) {
//        NSLog(@"error=%@",error);
//    }
//     ];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
    {
        return self.imagesArray.count;
    }
    else
    {
        return 0;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float width = ([[UIScreen mainScreen] bounds].size.width - 8)/4;
    CGSize cellSize;
    
    cellSize = CGSizeMake(width, width);
    
    return cellSize;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 2; // This is the minimum inter item spacing, can be more
//}
#pragma mark FCPreviewPicture delegate method
-(void)addImageUrl:(PHAsset*)imageUrl andImage:(UIImage *)image
{
    [self imageClicked:image andImageUrl:imageUrl];
}


@end
