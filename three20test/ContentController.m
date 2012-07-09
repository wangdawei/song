#import "ContentController.h"
#import <sqlite3.h>

@implementation ContentController

@synthesize content = _content, text = _text;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)dismiss {
  [self dismissModalViewControllerAnimated:YES];
}

- (void)showNutrition {
  TTOpenURL([NSString stringWithFormat:@"tt://food/%@/nutrition", self.content]);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithWaitress:(NSString*)waitress query:(NSDictionary*)query {
  if (self = [super init]) {
    _contentType = ContentTypeOrder;
    self.content = waitress;
    self.text = [NSString stringWithFormat:@"Hi, I'm %@, your imaginary waitress.", waitress];

    self.title = @"Place Your Order";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
        initWithTitle:@"Order" style:UIBarButtonItemStyleDone
        target:@"tt://order/confirm" action:@selector(openURL)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
        initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
        target:self action:@selector(dismiss)];

  }
  return self;
}

- (id)initWithFood:(NSString*)food {
  if (self = [super init]) {
    _contentType = ContentTypeFood;
    self.content = food;
    self.text = [NSString stringWithFormat:@"<b>%@</b> is just food, ya know?", food];

    self.title = food;
    self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Nutrition" style:UIBarButtonItemStyleBordered
                                target:self action:@selector(showNutrition)];
  }
  return self;
}

- (id)initWithNutrition:(NSString*)food {
  if (self = [super init]) {
    _contentType = ContentTypeNutrition;
    self.content = food;
    self.text = [NSString stringWithFormat:@"<b>%@</b> is healthy.  Trust us.", food];

    self.title = @"Nutritional Info";
  }
  return self;
}

- (id)initWithAbout:(NSString*)about {
  if (self = [super init]) {
    _contentType = ContentTypeAbout;
    self.content = about;
    self.text = [NSString stringWithFormat:@"<b>%@</b> is the name of this page.  Exciting.aboutttttttttt", about];

    if ([about isEqualToString:@"story"]) {
      self.title = @"Our Story";
    } else if ([about isEqualToString:@"complaints"]) {
      self.title = @"Complaints Dept.";
    }
  }
  return self;
}

//set text for 10
- (id)initWith10:(NSString*)s10 {
    if (self = [super init]) {
        
        _contentType = ContentType10;
        self.content = s10;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"song.sqlite"];
        
        sqlite3 *database;
        if (sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
            sqlite3_close(database);
            NSLog(@"Failed to open database");
        }
        
        NSString *query = @"SELECT id,number, name, content FROM song_info where id=?";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, [query UTF8String],
                               -1, &statement, nil) == SQLITE_OK) {
            
            sqlite3_bind_int(statement, 1, [s10 intValue]);
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
//                int id = sqlite3_column_int(statement, 0);
                char *number = (char *)sqlite3_column_text(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 2);
                char *content = (char *)sqlite3_column_text(statement, 3);
                
                
                NSString *numberStr = [[NSString alloc] initWithUTF8String:number];
                NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
                NSString *contentStr = [[NSString alloc] initWithUTF8String:content];
                
                //set title
                NSString *title = [numberStr stringByAppendingString:@"  "];
                title = [title stringByAppendingString:nameStr];
                self.title = title;
                //set text
                self.text = contentStr;
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    return self;
}


- (id)init {
    if (self = [super init]) {
        _contentType = ContentTypeNone;
        _content = nil;
        _text = nil;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)loadView {
  [super loadView];

  CGRect frame = CGRectMake(0, 0, self.view.width, self.view.height);
  TTStyledTextLabel* label = [[TTStyledTextLabel alloc] initWithFrame:frame];
  label.tag = 42;
  label.font = [UIFont systemFontOfSize:22];
  [self.view addSubview:label];

  if (_contentType == ContentTypeNutrition) {
    self.view.backgroundColor = [UIColor grayColor];
    label.backgroundColor = self.view.backgroundColor;
    self.hidesBottomBarWhenPushed = YES;
  } else if (_contentType == ContentTypeAbout) {
	  self.view.backgroundColor = [UIColor grayColor];
	  label.backgroundColor = self.view.backgroundColor;
  } else if (_contentType == ContentTypeOrder) {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"What do you want to eat?" forState:UIControlStateNormal];
    [button addTarget:@"tt://order/food" action:@selector(openURLFromButton:)
            forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.top = label.bottom + 20;
    button.left = floor(self.view.width/2 - button.width/2);
    [self.view addSubview:button];
  } else if (_contentType == ContentType10) {
      self.view.backgroundColor = [UIColor whiteColor];
      label.backgroundColor = self.view.backgroundColor;
  }
    
    
    
    
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
  TTStyledTextLabel* label = (TTStyledTextLabel*)[self.view viewWithTag:42];
  label.html = _text;
}

@end
