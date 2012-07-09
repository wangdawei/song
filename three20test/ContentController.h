#import "Three20UI/Three20UI+Additions.h"

typedef enum {
  ContentTypeNone,
  ContentTypeFood,
  ContentTypeNutrition,
  ContentTypeAbout,
  ContentType10,  
  ContentTypeOrder,
} ContentType;

@interface ContentController : TTViewController {
  ContentType _contentType;
  NSString* _content;
  NSString* _text;
}

@property(nonatomic,copy) NSString* content;
@property(nonatomic,copy) NSString* text;

@end
