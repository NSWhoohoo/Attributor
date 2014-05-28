//
//  HWViewController.m
//  Attributor
//
//  Created by will hunting on 5/27/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "HWViewController.h"
#import "HWTextStatsViewController.h"

@interface HWViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSAttributedString* title = [[NSAttributedString alloc]initWithString:self.outlineButton.currentTitle attributes:@{NSStrokeWidthAttributeName: @3, NSStrokeColorAttributeName: self.outlineButton.tintColor}];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    [self usePreferredFont];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)preferredFontsChanged:(NSNotification*)notification
{
    [self usePreferredFont];
}

- (void)usePreferredFont
{
    [self.body setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [self.headline setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
}

- (IBAction)changeBodySelectionColorToBackgroundColorOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName: [UIColor blackColor]} range:self.body.selectedRange];
}


- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Analyse Text"]) {
        if ([segue.destinationViewController isKindOfClass:[HWTextStatsViewController class]]) {
            HWTextStatsViewController* vc = (HWTextStatsViewController*)segue.destinationViewController;
            vc.textToAnalyse = self.body.textStorage;
        }
    }
}
@end
