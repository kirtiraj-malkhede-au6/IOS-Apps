//
//  SecondViewController.m
//  Taptap
//
//  Created by IB Mac on 09/01/24.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
NSString *enteredTask = @"";



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Initailize the array
    self.todos = [NSMutableArray array];
}
- (void)renderCardsForTodos {
    
    
    CGFloat cardY = 400.0; // Initial Y position for the first label
    CGFloat cardX = 25.0;
    
    for (NSDictionary *todoItem in self.todos) {
        
        // Create a container view for each todo item
        UIView *newCardView = [[UIView alloc] initWithFrame:CGRectMake(cardX, cardY, self.view.frame.size.width - 40.0, 70.0)];
        newCardView.backgroundColor = [UIColor colorWithRed:251/255.0 green:246/255.0 blue:238/255.0 alpha:1.0]; // Set card background color
        newCardView.layer.cornerRadius = 8.0; // Optional: Add corner radius for a rounded appearance
        [self.view addSubview:newCardView];
        
        // Remember to set a unique tag or identifier for each card if needed
        newCardView.tag = [self.todos indexOfObject:todoItem];
        
        // Create a delete button on the left side of the card
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        deleteButton.frame = CGRectMake(0, 0, 50, newCardView.frame.size.height);
        [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [newCardView addSubview:deleteButton];
        
        // Create a UILabel for the title within the card
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 10.0, newCardView.frame.size.width - 80.0, 30.0)];
        titleLabel.text = todoItem[@"title"];
        titleLabel.minimumScaleFactor = 20.0;
        titleLabel.textColor = [UIColor blackColor]; // Set title text color
        [newCardView addSubview:titleLabel];
        
        // Create a UILabel for the status within the card
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0, 40.0, newCardView.frame.size.width - 80.0, 20.0)];
        statusLabel.text = todoItem[@"status"];
        
        if ([todoItem[@"status"] isEqualToString:@"Not completed"]) {
            statusLabel.textColor = [UIColor blackColor];
        } else {
            statusLabel.textColor = [UIColor greenColor]; // Set status text color
        }
        
        [newCardView addSubview:statusLabel];
        
        // Update Y position for the next card
        cardY += newCardView.frame.size.height + 10.0; // You can adjust the vertical spacing as needed
    }
}

- (void)deleteButtonPressed:(UIButton *)sender {
    // Handle the delete button press here
    UIView *cardView = sender.superview;
    
    // Access the tag or identifier to determine which card was pressed
    NSInteger cardIndex = cardView.tag;
    
    if (cardIndex >= 0 && cardIndex < self.todos.count) {
        // Remove the card from the array and UI
        [self.todos removeObjectAtIndex:cardIndex];
        [cardView removeFromSuperview];
        // You may need to reposition the remaining cards or adjust the layout as needed
    } else {
        NSLog(@"Invalid index or empty array. Unable to delete.");
    }
}
- (IBAction)enterTaskHandler:(UITextField *)sender {
    enteredTask = sender.text;
    sender.text = @"";
}
- (IBAction)addTaskHandler:(UIButton *)sender {
    [self.view endEditing:YES];
    
    UIAlertController *alertController = nil;
    
    if (![enteredTask isEqualToString:@""]) {
        
        if (self.todos.count == 1) {
            alertController = [UIAlertController alertControllerWithTitle:@"One Item Only" message:@"Special message for one item" preferredStyle:UIAlertControllerStyleAlert];
        }else{
            NSDictionary *todoItem = @{
                @"id":@(self.todos.count + 1),
                @"title":enteredTask,
                @"status": @"Not completed",
            };
            
            // Add the todo item to the array
            [self.todos addObject:todoItem];
            
            // Call the method to render the updated todos in the scroll view
            [self renderCardsForTodos];
            
            NSLog(@"OK Button Tapped %@",todoItem);
            
        }
    }else{
        
        alertController = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Please entered valid text!" preferredStyle:UIAlertControllerStyleAlert];
        
    }
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    // Present the alert controller if needed
    if (alertController) {
        [self presentViewController:alertController animated:YES completion:nil];
    }
    enteredTask = @"";
}

- (void)handlePress:(UITapGestureRecognizer *)recognizer {
    // Handle the press event here
    NSLog(@"%@", recognizer);
    
    // You can access the UIView that was pressed using recognizer.view
    UIView *pressedView = recognizer.view;
    
    NSLog(@"View Pressed!");
    
    // Perform any additional actions based on the press event
    // Call the method to render the updated todos in the scroll view
    [self renderCardsForTodos];
}



@end
