//
//  ViewController.m
//  BubbleDemo
//
//  Created by lvpw on 14-4-1.
//  Copyright (c) 2014年 pengwei.lv. All rights reserved.
//

#import "ViewController.h"
#import "LVBubbleView.h"

#define SendPhotosViewControllerCamera 0
#define SendPhotosViewControllerPickPhoto 1

@interface ViewController () <UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) LVBubbleView *bubbleView;
@property (nonatomic, strong) LVBubbleView *bubbleView1;
@property (nonatomic, strong) NSMutableArray *bubbleViews;
//@property (nonatomic, strong) TextBubbleView *textBubbleView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == SendPhotosViewControllerCamera) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePickerConroller = [[UIImagePickerController alloc] init];
            imagePickerConroller.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerConroller.allowsEditing = NO;
            imagePickerConroller.showsCameraControls = YES;
            imagePickerConroller.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            imagePickerConroller.delegate = self;
            [self presentViewController:imagePickerConroller animated:YES completion:nil];
        } else {
            NSLog(@"相机不可用");
        }
    } else if (buttonIndex == SendPhotosViewControllerPickPhoto) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.allowsEditing = NO;
            imagePickerController.delegate = self;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        } else {
            NSLog(@"相册不可用");
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    TextBubbleView *bubbleView = [[TextBubbleView alloc] initWithFrame:CGRectMake(20, 20, 100, 50)];
//    bubbleView.backgroundColor = [UIColor clearColor];
//    bubbleView.maxWidth = 100;
//    bubbleView.bubbleType = BubbleTypeEllipse;
//    [self.view addSubview:bubbleView];
//    self.textBubbleView = bubbleView;
    
    LVBubbleView *bubbleView = [[LVBubbleView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    bubbleView.backgroundColor = [UIColor clearColor];
    bubbleView.textBubbleView.bubbleType = LVBubbleTypeEllipse;
    bubbleView.textBubbleView.maxWidth = 100;
    [self.view addSubview:bubbleView];
    [self.bubbleViews addObject:bubbleView];
//    self.bubbleView = bubbleView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - override

- (NSMutableArray *)bubbleViews
{
    if (_bubbleViews == nil) {
        _bubbleViews = [NSMutableArray array];
    }
    return _bubbleViews;
}

- (LVBubbleView *)bubbleView
{
    return self.bubbleViews[self.bubbleViews.count-1];
}

#pragma mark - Handle Action

- (IBAction)segmentControlAction:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:{
            self.bubbleView.bubbleType = LVBubbleTypeEllipse;
            [self.bubbleView setNeedsDisplay];
        }
            break;
        case 1:{
            self.bubbleView.bubbleType = LVBubbleTypeThought;
            [self.bubbleView setNeedsDisplay];
        }
            break;
        case 2:{
            self.bubbleView.bubbleType = LVBubbleTypeShout;
            [self.bubbleView setNeedsDisplay];
        }
        default:
            break;
    }
}

- (IBAction)pickPhoto:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)addBubbleView:(id)sender
{
    LVBubbleView *bubbleView = [[LVBubbleView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    bubbleView.backgroundColor = [UIColor clearColor];
    bubbleView.textBubbleView.bubbleType = LVBubbleTypeEllipse;
    bubbleView.textBubbleView.maxWidth = 100;
    [self.view addSubview:bubbleView];
    [self.bubbleViews addObject:bubbleView];
}

- (IBAction)cutBubbleView:(id)sender
{
    LVBubbleView *bubbleView = self.bubbleViews[self.bubbleViews.count-1];
    [bubbleView removeFromSuperview];
    [self.bubbleViews removeObject:bubbleView];
}

@end
