//
//  CustomCell.m
//  TableView
//
//  Created by wgarbaya  
//  
//
#import "CustomCell.h"
@implementation CustomCell
@synthesize myLabel = _myLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
    {
        _myLabel = [[UILabel alloc] initWithFrame:self.frame];
        _myLabel.backgroundColor = [UIColor clearColor];
        _myLabel.font = [UIFont fontWithName:@"zapfino" size:12.0];
        _myLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_myLabel];
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated 
{
    [super setSelected:selected animated:animated];
}

@end

