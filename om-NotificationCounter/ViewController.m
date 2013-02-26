//
//  ViewController.m
//  om-NotificationCounter
//
//  Created by Omkar on 27/02/13.
//  Copyright (c) 2013 Omkar Nisal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int count;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    count = 0 ;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(up) name:@"up" object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(down) name:@"down" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reset) name:@"reset" object:nil];
    
    
    
}

-(void)up
{
    
    ++count;
    self.counter.text = [NSString stringWithFormat:@" Count is %d",count];
}

-(void)down
{
  if(count>=1)
    --count;
    self.counter.text = [NSString stringWithFormat:@" Count is %d",count];
}

-(void)reset
{
    
    count=0;
    self.counter.text = [NSString stringWithFormat:@" Count is %d",count];
}

 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButton:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reset" object:nil];
}

- (IBAction)upButton:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"up" object:nil];
}

- (IBAction)downButton:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"down" object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"up" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"down" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reset" object:nil];
}
@end
