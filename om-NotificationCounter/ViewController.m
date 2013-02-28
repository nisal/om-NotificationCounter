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

// for NSNotification with dictionary
- (void)receiveEvent:(NSNotification *)notification;

// for orientation change notifications
- (void)postNotificationWithString:(NSString *)orientation;
- (void)useNotificationWithString:(NSNotification*)notification;

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
    
    // for NSNotification with dictionary
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveEvent:) name:@"UpDownEvent" object:nil];
    
    
    // for orientation change notifications
    NSString *notificationName = @"OCNotification";
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:notificationName
     object:nil];
    
    
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




// NSNotification with dictionary


- (void) send:(int) val {
    NSDictionary *valDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:val] forKey:@"countUpOrDown"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDownEvent" object:nil userInfo:valDict];
}


- (void)receiveEvent:(NSNotification *)notification {
    int pass = [[[notification userInfo] valueForKey:@"countUpOrDown"] intValue];

//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@" Notification Recieved" message:[NSString stringWithFormat:@" Pass value = %d",pass] delegate:nil cancelButtonTitle:@"Nice!" otherButtonTitles:nil, nil];
//    [av show];
    
    if(pass==-1)
    {
        if(count>=1)
        {
            --count;
        }
    }
    else if(pass==0)
    {
        count=0;
    }
    else
    {
        ++count;
    }
    
   
    
    self.counter.text = [NSString stringWithFormat:@" Count is %d",count];
}

- (IBAction)upBtn:(id)sender {
    [self send:1];
}

- (IBAction)dnBtn:(id)sender {
    [self send:-1];
}

- (IBAction)resetBtn:(id)sender {
    [self send:0];
}

// NSNotification with dictionary






// for orientation change notifications
- (void)postNotificationWithString:(NSString *)orientation //post notification method and logic
{
    NSString *notificationName = @"OCNotification";
    NSString *key = @"OrientationStringValue";
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:orientation forKey:key];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:dictionary];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        [self postNotificationWithString:@"Portrait"];
    }
    else {
        [self postNotificationWithString:@"Landscape"];
    }
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    NSString *key = @"OrientationStringValue";
    NSDictionary *dictionary = [notification userInfo];
    NSString *stringValueToUse = [dictionary valueForKey:key];
    NSLog(@"Device orientation --> %@",stringValueToUse);
    
    self.Orientation.text = [NSString stringWithFormat:@" Orientation: %@",stringValueToUse];
    
}









-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"up" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"down" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reset" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
