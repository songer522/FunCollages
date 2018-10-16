//
//  BackgroundPicker.m
//  Fun collages
//
//  Created by Song on 1/26/13.
//  Copyright (c) 2013 songer. All rights reserved.
//

#import "FCItemPicker.h"
#import "ItemCollectionViewCell.h"
@implementation FCItemPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // Initialization code
    }
    return self;
}
-(id)initWithBackground
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    self=[[[NSBundle mainBundle] loadNibNamed:@"BackgroundPicker_iPhone" owner:self options:nil] objectAtIndex:0];
    }
    else
    {
     self=[[[NSBundle mainBundle] loadNibNamed:@"BackgroundPicker_iPad" owner:self options:nil] objectAtIndex:0];   
    }
    [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    [self.collectionView registerNib: [UINib nibWithNibName:@"BackgroundCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"backgroundCell"];
 self.itemArray=@[@"background17.JPG",@"background18.JPG",@"background19.JPG",@"Background23",@"background20.JPG",@"background21.JPG",@"background22.JPG",@"background1.JPG",@"background2.JPG",@"background3.JPG",@"background4.JPG",@"background5.JPG",@"background6.JPG",@"background7.JPG",@"background9.JPG",@"background10.JPG",@"background12.JPG",@"background13.JPG",@"texture1.png",@"texture9.JPG",@"background14.JPG",@"background15.JPG",@"background16.JPG",@"background8.JPG",@"background11.JPG",@"beach2.png",@"colorful.jpg",@"leaves.png",@"billborad1.png",@"scroll.jpg",@"texture4.JPG"];
    self.pickerType=BACKGROUND;
    return self;
}
-(id)initWithColor
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    self=[[[NSBundle mainBundle] loadNibNamed:@"ColorPicker_iPhone" owner:self options:nil] objectAtIndex:0];
    }
    else
    {
     self=[[[NSBundle mainBundle] loadNibNamed:@"ColorPicker_iPad" owner:self options:nil] objectAtIndex:0];
    }
    [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    [self.collectionView registerNib: [UINib nibWithNibName:@"BackgroundCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"backgroundCell"];
 self.itemArray=@[[UIColor whiteColor],[UIColor blackColor],[UIColor purpleColor],[UIColor redColor],[UIColor colorWithRed:73.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:1.0],[UIColor colorWithRed:48.0/255.0 green:85.0/255.0 blue:43.0/255.0 alpha:1.0],[UIColor colorWithRed:36.0/255.0 green:52.0/255.0 blue:106.0/255.0 alpha:1.0],[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:83.0/255.0 alpha:1.0],[UIColor colorWithRed:155.0/255.0 green:84.0/255.0 blue:157.0/255.0 alpha:1.0],[UIColor colorWithRed:234.0/255.0 green:36.0/255.0 blue:124.0/255.0 alpha:1.0],[UIColor colorWithRed:234.0/255.0 green:34.0/255.0 blue:44.0/255.0 alpha:1.0],[UIColor colorWithRed:174.0/255.0 green:207.0/255.0 blue:81.0/255.0 alpha:1.0],[UIColor colorWithRed:97.0/255.0 green:140.0/255.0 blue:197.0/255.0 alpha:1.0],[UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0],[UIColor colorWithRed:175.0/255.0 green:145.0/255.0 blue:193.0/255.0 alpha:1.0],[UIColor colorWithRed:245.0/255.0 green:175.0/255.0 blue:193.0/255.0 alpha:1.0],[UIColor colorWithRed:244.0/255.0 green:143.0/255.0 blue:58.0/255.0 alpha:1.0],[UIColor colorWithRed:252.0/255.0 green:232.0/255.0 blue:52.0/255.0 alpha:1.0],[UIColor colorWithRed:63.0/255.0 green:170.0/255.0 blue:222.0/255.0 alpha:1.0],[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:220.0/255.0 alpha:1.0],[UIColor colorWithRed:218.0/255.0 green:198.0/255.0 blue:205.0/255.0 alpha:1.0],[UIColor colorWithRed:250.0/255.0 green:213.0/255.0 blue:221.0/255.0 alpha:1.0],[UIColor colorWithRed:273.0/255.0 green:187.0/255.0 blue:148.0/255.0 alpha:1.0],[UIColor colorWithRed:248.0/255.0 green:241.0/255.0 blue:194.0/255.0 alpha:1.0],[UIColor colorWithRed:199.0/255.0 green:226.0/255.0 blue:245.0/255.0 alpha:1.0]];
    self.pickerType=COLOR;
    return self;
}

-(id)initWithFont
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
    self=[[[NSBundle mainBundle] loadNibNamed:@"FontPicker_iPhone" owner:self options:nil] objectAtIndex:0];
    }
    else
    {
    self=[[[NSBundle mainBundle] loadNibNamed:@"FontPicker_iPad" owner:self options:nil] objectAtIndex:0];    
    }
    [self setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
    [self.collectionView registerNib: [UINib nibWithNibName:@"BackgroundCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"backgroundCell"];
    //self.itemArray=[UIFont familyNames];
    self.itemArray=@[@"Academy Engraved LET",
                     @"Al Nile",
                     @"American Typewriter",
                     @"Apple Color Emoji",
                     @"Apple SD Gothic Neo",
                     @"Arial",
                     @"Arial Hebrew",
                     @"Arial Rounded MT Bold",
                     @"Avenir",
                     @"Avenir Next",
                     @"Avenir Next Condensed",
                     @"Bangla Sangam MN",
                     @"Baskerville",
                     @"Bodoni 72",
                     @"Bodoni 72 Smallcaps"
                     @"Bodoni 72 Oldstyle",
                     @"Bodoni Ornaments",
                     @"Bradley Hand",
                     @"Chalkboard SE",
                     @"Chalkduster",
                     @"Cochin",
                     @"Copperplate",
                     @"Courier",
                     @"Courier New",
                     @"DIN Alternate",
                     @"DIN Condensed",
                     @"Damascus",
                     @"Devanagari Sangam MN",
                     @"Didot",
                     @"Euphemia UCAS",
                     @"Farah",
                     @"Futura",
                     @"Geeza Pro",
                     @"Georgia",
                     @"Gill Sans",
                     @"Gujarati Sangam MN",
                     @"Gurmukhi MN",
                     @"Heiti SC",
                     @"Heiti TC",
                     @"Helvetica",
                     @"Helvetica Neue",
                     @"Hiragino Kaku Gothic ProN",
                     @"Hiragino Mincho ProN",
                     @"Hoefler Text",
                     @"Iowan Old Style",
                     @"Kailasa",
                     @"Kannada Sangam MN",
                     @"Malayalam Sangam MN",
                     @"Marker Felt",
                     @"Marion",
                     @"Menlo",
                     @"Mishafi",
                     @"Noteworthy",
                     @"Optima",
                     @"Oriya Sangam MN",
                     @"Palatino",
                     @"Papyrus",
                     @"Party LET",
                     @"Savoye LET",
                     @"Sinhala Sangam MN",
                     @"Snell Roundhand",
                     @"Superclarendon",
                     @"Symbol",
                     @"Thonburi",
                     @"Tamil Sangam MN",
                     @"Telugu Sangam MN",
                     @"Times New Roman",
                     @"Trebuchet MS",
                     @"Verdana",
                     @"Zapf Dingbats",
                     @"Zapfino"
                     ];
    
    
    self.pickerType=FONT;
    return self;
}
- (IBAction)customButtonPressed:(id)sender {
    
    [self.delegate customImagePick];
    
}

-(IBAction)doneButtonPressed
{
    if(self.pickerType==BACKGROUND)
    {
    [self.delegate backgroundPickButtonPressed];
    }
    else if(self.pickerType==COLOR)
    {
        [self.delegate colorPickerButtonPressed];
    }
    else if(self.pickerType==FONT)
    {
        [self.delegate fontPickerButtonPressed];
    }
}
- (IBAction)boldButtonPressed:(UIButton*)sender {
    sender.selected=!sender.isSelected;
    self.isBold=sender.isSelected;
    [self.collectionView reloadData];
    
    
}
- (IBAction)italicButtonPressed:(UIButton*)sender {
    sender.selected=!sender.isSelected;
    self.isitalic=sender.isSelected;
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"backgroundCell" forIndexPath:indexPath];
    
    if(self.pickerType==BACKGROUND)
    {
    cell.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.itemArray objectAtIndex:indexPath.row]]];
    }
    else if(self.pickerType==COLOR)
    {
        cell.backgroundColor=[self.itemArray objectAtIndex:indexPath.row];
    }
    else if(self.pickerType==FONT)
    {
        if(!cell.titleLabel)
        {
            cell.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
             [cell.titleLabel setTextColor:[UIColor whiteColor]];
            [cell.titleLabel setBackgroundColor:[UIColor clearColor]];
            cell.titleLabel.textAlignment=NSTextAlignmentCenter;
            cell.titleLabel.adjustsFontSizeToFitWidth=YES;
            [cell addSubview:cell.titleLabel];
        }
        
        NSString *fontName=[self.itemArray objectAtIndex:indexPath.row];
        if(self.isBold&&self.isitalic&&[UIFont fontWithName:[NSString stringWithFormat:@"%@-BoldItalic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:30])
        {
             [cell.titleLabel setFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@-BoldItalic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:20]];
        }
        else if(self.isBold&&!self.isitalic&&[UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:30])
        {
            [cell.titleLabel setFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:20]];
        }
        else if(!self.isBold&&self.isitalic&&[UIFont fontWithName:[NSString stringWithFormat:@"%@-Italic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:30])
        {
            [cell.titleLabel setFont:[UIFont fontWithName:[NSString stringWithFormat:@"%@-Italic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:20]];
        }
        else
        {
            [cell.titleLabel setFont:[UIFont fontWithName:fontName size:20]];
        }
        
        //[cell.titleLabel setFont:[UIFont fontWithName:fontName size:20]];
        [cell.titleLabel setText:fontName];
       
        
    }
    //[cell setBackgroundColor:[UIColor orangeColor]];

    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
    {
        return self.itemArray.count;
    }
    else
    {
        return 0;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.pickerType==BACKGROUND)
    {
    [self.delegate backgroundImagePicked: [UIImage imageNamed: [self.itemArray objectAtIndex:indexPath.row]]];
    //[self.delegate backgroundPickButtonPressed];
    }
    else if(self.pickerType==COLOR)
    
    {
      [self.delegate colorPicked:[self.itemArray objectAtIndex:indexPath.row]];
    //  [self.delegate colorPickerButtonPressed];
    }
    else if(self.pickerType==FONT)
    {
        NSString *fontName=[self.itemArray objectAtIndex:indexPath.row];
        if(self.isBold&&self.isitalic&&[UIFont fontWithName:[NSString stringWithFormat:@"%@-BoldItalic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:30])
        {
           [self.delegate fontPicked:[NSString stringWithFormat:@"%@-BoldItalic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
        }
        else if(self.isBold&&!self.isitalic&&[UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:30])
        {
           [self.delegate fontPicked:[NSString stringWithFormat:@"%@-Bold", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
        }
        else if(!self.isBold&&self.isitalic&&[UIFont fontWithName:[NSString stringWithFormat:@"%@-Italic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]] size:30])
        {
            [self.delegate fontPicked:[NSString stringWithFormat:@"%@-Italic", [fontName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
        }
        else
        {
            [self.delegate fontPicked:fontName];
        }

       // [self.delegate fontPickerButtonPressed];
    }
}



@end
