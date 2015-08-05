//
//  ViewController.m
//  iSpinningIndicator
//
//  Created by Rajesh on 8/5/15.
//  Copyright © 2015 Org. All rights reserved.
//

#import "ViewController.h"


#define TAG_INDICATOR 999
@interface ViewController ()
{
    UIView *vwIndicator;
    NSTimer *timerIndicator;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTapped:(id)sender
{
    [self hideIndicator:[sender tag]];
    [self.view bringSubviewToFront:sender];
    [sender setTag:![sender tag]];
    if ([sender tag])
    {
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else
    {
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
 }

- (void)hideIndicator:(BOOL)shouldHide
{
    if (shouldHide)
    {
        [vwIndicator setHidden:YES];
        [timerIndicator invalidate];
    }
    else
    {
        if (!vwIndicator)
        {
            vwIndicator = [[UIView alloc] initWithFrame:self.view.frame];
            [vwIndicator setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            [self.view addSubview:vwIndicator];
            [vwIndicator setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.2]];
            
            UIImageView *imgVw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            [imgVw setImage:[UIImage imageNamed:@"activity_indicator"]];
            [imgVw setCenter:vwIndicator.center];
            [vwIndicator addSubview:imgVw];
            [imgVw setTag:TAG_INDICATOR];
            [imgVw setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
        }
        [vwIndicator setHidden:NO];
        timerIndicator = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(animateImage:) userInfo:[vwIndicator viewWithTag:TAG_INDICATOR] repeats:YES];
    }
}

- (void)animateImage:(NSTimer *)timer
{
    UIImageView *imageView = timer.userInfo;
    [imageView setTransform:CGAffineTransformRotate(imageView.transform, M_PI/50)];
}

@end
