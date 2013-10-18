//
//  SJSceneViewController.m
//  SJRolePlaying
//
//  Created by Tatsuya Tobioka on 2013/10/16.
//  Copyright (c) 2013年 tnantoka. All rights reserved.
//

#import "SJSceneViewController.h"

#import <SpriteKit/SpriteKit.h>

//static const CGFloat AD_HEIGHT = 50.0f;
static const CGFloat AD_HEIGHT = 64.0f;

@interface SJSceneViewController ()

@end

@implementation SJSceneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = _scene;
    
    // SKView
    CGRect frame = self.view.bounds;
    frame.origin.y = AD_HEIGHT;
    frame.size.height -= AD_HEIGHT;
    SKView *skView = [[SKView alloc] initWithFrame:frame];

#ifdef DEBUG
    skView.showsDrawCount = YES;
    skView.showsNodeCount = YES;
    skView.showsFPS = YES;
#endif

    [self.view addSubview:skView];

    // Scene
    Class sceneClass = NSClassFromString([NSString stringWithFormat:@"SJ%@Scene", _scene]);
    CGSize size = self.view.bounds.size;
    size.height -= AD_HEIGHT;
    SKScene *scene = [sceneClass sceneWithSize:size];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    [skView presentScene:scene];
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
*/

@end
