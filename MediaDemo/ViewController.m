//
//  ViewController.m
//  MediaDemo
//
//  Created by GBGYP-7 on 4.03.2016.
//  Copyright © 2016 GBGYP-7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) AVPlayerViewController *moviePlayer;
@property (strong,nonatomic) AVPlayerItem *playerItem;

@end

AVPlayerViewController *moviePlayer;
AVPlayerLayer *playerItem;

@implementation ViewController


-(AVPlayerViewController*) moviePlayer{

    if(!_moviePlayer){
        _moviePlayer=[[AVPlayerViewController alloc] init];
    
    }
    return _moviePlayer;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Media Contents";//başlık kısmı burada belirtiliyor
    
    NSString *path;
    
    path=[[NSBundle mainBundle] pathForResource:@"4.7inch" ofType:@"mp4"];//basitçe video yolu göstermek
    
    NSURL *url=[NSURL fileURLWithPath:path];
    
    [self.moviePlayer setShowsPlaybackControls:YES];
    self.moviePlayer.view.frame=self.view.frame;
    
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    self.moviePlayer.player=[AVPlayer playerWithPlayerItem:self.playerItem];
    
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer.player play];
     // basit natification kullanımı
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                                                object:nil];// her yerde kullanabiliriz singleton instance. selector içine yazılan metod bu işlem bittiğinde gerçekleşir. oddObserver dinleyici moduna geçirmekte yardımcı olur.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(customMethod:)
                                                 name:@"CustomName"
                                               object:nil];
    
    
    
}

-(void) customMethod: (NSNotification*) notif{
    NSDictionary *dic=notif.userInfo;
    if([notif.name isEqualToString:@"CustomName"]){
    
        NSLog(@"%@",dic);
    
    }
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) playerItemDidReachEnd:(NSNotification*) notif{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CustomName" object:nil userInfo:@{@"userInf":@"String"}];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addMediaSource:(id)sender {
}
@end
