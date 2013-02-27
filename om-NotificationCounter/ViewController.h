//
//  ViewController.h
//  om-NotificationCounter
//
//  Created by Omkar on 27/02/13.
//  Copyright (c) 2013 Omkar Nisal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *counter;
- (IBAction)resetButton:(id)sender;
- (IBAction)upButton:(id)sender;
- (IBAction)downButton:(id)sender;
- (IBAction)upBtn:(id)sender;
- (IBAction)dnBtn:(id)sender;
- (IBAction)resetBtn:(id)sender;
 
 
@end
