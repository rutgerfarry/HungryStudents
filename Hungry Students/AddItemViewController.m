//
//  AddItemViewController.m
//  Hungry Students
//
//  Created by Rutger Farry on 11/15/14.
//  Copyright (c) 2014 Rutger Farry. All rights reserved.
//

#import "AddItemViewController.h"
#import <Parse/Parse.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface AddItemViewController ()

@property (strong, nonatomic) PFObject *foodObject;
@property (strong, nonatomic) IBOutlet UIImageView *topImage;
@property (strong, nonatomic) UITextField *bottomTextField;

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self takePicture];
    CGRect bottomTextFrame = CGRectMake(0,
                                        308,
                                        [UIScreen mainScreen].bounds.size.width,
                                        200);
    self.bottomTextField = [[UITextField alloc] initWithFrame:bottomTextFrame];
    self.bottomTextField.placeholder = @"Enter your description here...";
    [self.view addSubview:self.bottomTextField];
    self.bottomTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)takePicture
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    [self.imagePicker setDelegate:self];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.imagePicker setAllowsEditing:NO];
        [self presentViewController:self.imagePicker animated:NO completion:nil];
    }
}
- (IBAction)postButtonPushed {
    NSLog(@"1st level");
    UIImage *newImage = [self resizeImage:self.image toWidth:750 andHeight:1000];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            NSLog(@"2nd level no error");
            PFObject *newObject = [PFObject objectWithClassName:@"Announcement"];
            newObject[@"Description"] = self.bottomTextField.text;
            newObject[@"Location"] = geoPoint;
            newObject[@"Photo"] = imageFile;
            [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                        message:@"Uhh so an error occured. You probably done something wrong."
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:errorAlert
                                       animated:YES
                                     completion:nil];
                }
            }];
        }
        else
        {
            NSLog(@"2nd error");

            UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                message:@"Uhh so an error occured. You probably done something wrong."
                                                                         preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:errorAlert
                               animated:YES
                             completion:nil];
        }
    }];
    NSLog(@"3rd level");

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Image Picker Controller delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // A photo was taken
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // save the image
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    [self performSelector:@selector(setButtonImage:)withObject:(self.image)afterDelay:0.3];
}

- (void)setButtonImage:(UIImage *)image
{
    self.topImage.image = image;
}

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height
{
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRect];
    
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
