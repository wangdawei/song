#import "MenuController.h"
#import <sqlite3.h>

@implementation MenuController

@synthesize page = _page;
@synthesize list;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)nameForMenuPage:(MenuPage)page {
  switch (page) {
    case MenuPage1:
      return @"选集";
    case MenuPage8:
      return @"八册";
    case MenuPage9:
      return @"九册";
    case MenuPage10:
      return @"十册";
    case MenuPage11:
      return @"十一册";
    default:
      return @"";
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithMenu:(MenuPage)page {
    if (self = [super init]) {
        self.page = page;
        
        
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"song.sqlite"];
//        
//        sqlite3 *database;
//        if (sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
//            sqlite3_close(database);
//            NSLog(@"Failed to open database");
//        }
//        
//        NSString *query = @"SELECT number, name, content FROM song_info";
//        sqlite3_stmt *statement;
//        if (sqlite3_prepare_v2(database, [query UTF8String],
//                               -1, &statement, nil) == SQLITE_OK) {
//            while (sqlite3_step(statement) == SQLITE_ROW) {
//                char *number = (char *)sqlite3_column_text(statement, 0);
//                char *name = (char *)sqlite3_column_text(statement, 1);
//                char *content = (char *)sqlite3_column_text(statement, 2);
//                
//                
//                NSString *numberStr = [[NSString alloc] initWithUTF8String:number];
//                NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
//                NSString *contentStr = [[NSString alloc] initWithUTF8String:content];
//                
//                NSLog(numberStr);
//                NSLog(nameStr);
//                NSLog(contentStr);
//
//            }
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(database);
        
    }
    
    
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController

- (void)setPage:(MenuPage)page {
  _page = page;

  self.title = [self nameForMenuPage:page];

  UIImage* image = [UIImage imageNamed:@"tab.png"];
  self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:image tag:0];

//  self.navigationItem.rightBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStyleBordered
//                              target:@"tt://order?waitress=Betty&ref=toolbar"
//                              action:@selector(openURLFromButton:)];

  if (_page == MenuPage1) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Food",
      [TTTableTextItem itemWithText:@"Porridge" URL:@"tt://food/porridge"],
      [TTTableTextItem itemWithText:@"Bacon & Eggs" URL:@"tt://food/baconeggs"],
      [TTTableTextItem itemWithText:@"French Toast" URL:@"tt://food/frenchtoast"],
      @"Drinks",
      [TTTableTextItem itemWithText:@"Coffee" URL:@"tt://food/coffee"],
      [TTTableTextItem itemWithText:@"Orange Juice" URL:@"tt://food/oj"],
      @"Other",
      [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
      [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPage8) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Menu",
      [TTTableTextItem itemWithText:@"Mac & Cheese" URL:@"tt://food/macncheese"],
      [TTTableTextItem itemWithText:@"Ham Sandwich" URL:@"tt://food/hamsam"],
      [TTTableTextItem itemWithText:@"Salad" URL:@"tt://food/salad"],
      @"Drinks",
      [TTTableTextItem itemWithText:@"Coke" URL:@"tt://food/coke"],
      [TTTableTextItem itemWithText:@"Sprite" URL:@"tt://food/sprite"],
      @"Other",
      [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
      [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPage9) {
    self.dataSource = [TTSectionedDataSource dataSourceWithObjects:
      @"Appetizers",
      [TTTableTextItem itemWithText:@"Potstickers" URL:@"tt://food/potstickers"],
      [TTTableTextItem itemWithText:@"Egg Rolls" URL:@"tt://food/eggrolls"],
      [TTTableTextItem itemWithText:@"Buffalo Wings" URL:@"tt://food/wings"],
      @"Entrees",
      [TTTableTextItem itemWithText:@"Steak" URL:@"tt://food/steak"],
      [TTTableTextItem itemWithText:@"Chicken Marsala" URL:@"tt://food/marsala"],
      [TTTableTextItem itemWithText:@"Cobb Salad" URL:@"tt://food/cobbsalad"],
      [TTTableTextItem itemWithText:@"Green Salad" URL:@"tt://food/greensalad"],
      @"Drinks",
      [TTTableTextItem itemWithText:@"Red Wine" URL:@"tt://food/redwine"],
      [TTTableTextItem itemWithText:@"White Wine" URL:@"tt://food/whitewhine"],
      [TTTableTextItem itemWithText:@"Beer" URL:@"tt://food/beer"],
      [TTTableTextItem itemWithText:@"Coke" URL:@"tt://food/coke"],
      [TTTableTextItem itemWithText:@"Sparkling Water" URL:@"tt://food/coke"],
      @"Other",
      [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
      [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
      nil];
  } else if (_page == MenuPage10) {

      
//      [[DataModel alloc] initWithData:@""];
      
      
      
      TTListDataSource* dataSource = [[TTListDataSource alloc] init];
      
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *documentsDirectory = [paths objectAtIndex:0];
      NSString *path = [documentsDirectory stringByAppendingPathComponent:@"song.sqlite"];
      
      sqlite3 *database;
      if (sqlite3_open([path UTF8String], &database) != SQLITE_OK) {
          sqlite3_close(database);
          NSLog(@"Failed to open database");
      }
      
      NSString *query = @"SELECT id,number, name, content FROM song_info";
      sqlite3_stmt *statement;
      if (sqlite3_prepare_v2(database, [query UTF8String],
                             -1, &statement, nil) == SQLITE_OK) {
          while (sqlite3_step(statement) == SQLITE_ROW) {
              int id = sqlite3_column_int(statement, 0);
              char *number = (char *)sqlite3_column_text(statement, 1);
              char *name = (char *)sqlite3_column_text(statement, 2);
              char *content = (char *)sqlite3_column_text(statement, 3);
              
              NSString *numberStr = [[NSString alloc] initWithUTF8String:number];
              NSString *nameStr = [[NSString alloc] initWithUTF8String:name];
              NSString *contentStr = [[NSString alloc] initWithUTF8String:content];
              
              NSString *text = [numberStr stringByAppendingString:@"   "];
              text = [text stringByAppendingString:nameStr];
              
              NSString *url = [NSString stringWithFormat:@"tt://10/%d",id];
              [dataSource.items addObject:[TTTableTextItem itemWithText:text URL:url]];
              
          }
          sqlite3_finalize(statement);
      }
      sqlite3_close(database);
      
      self.dataSource = dataSource;
      
  } else if (_page == MenuPage11) {
    self.dataSource = [TTListDataSource dataSourceWithObjects:
      [TTTableTextItem itemWithText:@"Our Story" URL:@"tt://about/story"],
      [TTTableTextItem itemWithText:@"Call Us" URL:@"tel:5555555"],
      [TTTableTextItem itemWithText:@"Text Us" URL:@"sms:5555555"],
      [TTTableTextItem itemWithText:@"Website" URL:@"http://www.melsdrive-in.com"],
      [TTTableTextItem itemWithText:@"Complaints Dept." URL:@"tt://about/complaints"],
      nil];
  }
}

@end
