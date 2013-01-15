//
//  WineCell.m
//  Projet
//
//  Created by Élèves on 15/01/13.
//
//

#import "WineCell.h"

@implementation WineCell
@synthesize myLabel = _myLabel;
@synthesize nombre = _nombre;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _myLabel = [[UILabel alloc] initWithFrame:self.frame];
        _myLabel.backgroundColor = [UIColor clearColor];
        _myLabel.font = [UIFont fontWithName:@"zapfino" size:12.0];
        _myLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_myLabel];
        
        _nombre = [[UILabel alloc] initWithFrame:self.frame];
        _nombre.backgroundColor = [UIColor clearColor];
        _nombre.font = [UIFont fontWithName:@"zapfino" size:12.0];
        _nombre.textAlignment = UITextAlignmentRight;
        [self addSubview:_nombre];
     
    }
    return self;

    
     
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  //  [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
 
 

 