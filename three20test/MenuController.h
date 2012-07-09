#import <Three20/Three20.h>

typedef enum {
  MenuPageNone,
  MenuPage1,
  MenuPage8,
  MenuPage9,
  MenuPage10,
  MenuPage11,
} MenuPage;

@interface MenuController : TTTableViewController {
  MenuPage _page;
}

@property(nonatomic) MenuPage page;
@property(nonatomic)NSArray *list;

@end
