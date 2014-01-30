//
//  ViewController.m
//  BancoSqlite
//
//  Created by Area 51 on 28/01/14.
//  Copyright (c) 2014 Cranioex Capture. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

{
    
    NSMutableArray *arrayOfPerson;
    sqlite3 *personDB;
    NSString *dbPathString;
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    arrayOfPerson = [[NSMutableArray alloc]init];
	
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    [self createOrOpenDB];
    
}

-(void)createOrOpenDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"persons.db"];
                    
    char *error;
                    
      NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        // Criando o banco
        
        
        if (sqlite3_open(dbPath, &personDB)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSONS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
             sqlite3_exec(personDB, sql_stmt, NULL, NULL, &error);
              sqlite3_close(personDB);
            
            NSLog(@"funfa");
            
        }
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrayOfPerson count];
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIndetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndetifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndetifier];
        
        
    }
    
    Person *aPerson = [ arrayOfPerson objectAtIndex:indexPath.row];


cell.textLabel.text = aPerson.name;
cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",aPerson.age];

return cell;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPersonButton:(id)sender {
    
 
    
    
    char *error;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)== SQLITE_OK) {
       
        NSString *inserStmt = [NSString stringWithFormat:@"INSERT INTO PERSONS(NAME,AGE) values ('%s', '%d')", [self.nameField.text UTF8String], [self.ageField.text intValue]];
           
          const char *insert_stmt = [inserStmt UTF8String];
         
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)== SQLITE_OK){
            
            NSLog(@"Person added");
            
            Person *person = [[Person alloc]init];
            
            [person setName:self.nameField.text];
            [person setAge:[self.ageField.text intValue]];
            
            [arrayOfPerson addObject:person];
            
              
    
        }
    
        
         sqlite3_close(personDB);
    }
}


- (IBAction)displayPersonButton:(id)sender {
}

- (IBAction)deletePersonButton:(id)sender {
}
@end
