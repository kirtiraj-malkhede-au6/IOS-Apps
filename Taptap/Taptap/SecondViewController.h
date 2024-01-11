//
//  SecondViewController.h
//  Taptap
//
//  Created by IB Mac on 09/01/24.
//


#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) NSMutableArray *todos;
- (void)renderCardsForTodos;

@end
