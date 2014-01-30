//
//  ViewController.h
//  BancoSqlite
//
//  Created by Area 51 on 28/01/14.
//  Copyright (c) 2014 Cranioex Capture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Person.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *ageField;


@property (weak, nonatomic) IBOutlet UITableView *myTableView;


- (IBAction)addPersonButton:(id)sender;


- (IBAction)displayPersonButton:(id)sender;

- (IBAction)deletePersonButton:(id)sender;


@end
