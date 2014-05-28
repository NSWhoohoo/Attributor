//
//  HWTextStatsViewController.m
//  Attributor
//
//  Created by tarena on 14-5-28.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "HWTextStatsViewController.h"

@interface HWTextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharacterLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharacterLabel;
@end

@implementation HWTextStatsViewController

- (void)setTextToAnalyse:(NSAttributedString *)textToAnalyse
{
    _textToAnalyse = textToAnalyse;
    if(self.view.window) [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString*)charactersWithAttribute:(NSString*)attributeName
{
    NSMutableAttributedString* characters = [[NSMutableAttributedString alloc]init];
    for (int i = 0; i < self.textToAnalyse.length; i++) {
        NSRange range;
        id value = [self.textToAnalyse attribute:attributeName atIndex:i effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyse attributedSubstringFromRange:range]];
            i = (int)(range.location + range.length-1);
        }
    }
    return characters;
}

- (void)updateUI
{
    self.colorfulCharacterLabel.text = [NSString stringWithFormat:@"%ld colorful characters", [[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlineCharacterLabel.text = [NSString stringWithFormat:@"%ld outlined characters", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

@end
