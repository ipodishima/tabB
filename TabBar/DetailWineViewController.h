//
//  DetailWineViewController.h
//  Projet
//
//  Created by Garbaya walid on 12/31/12.
//
//

#import <UIKit/UIKit.h>
#import "Wine.h"

@interface DetailWineViewController : UIViewController
{
      UILabel *_label;
    UILabel *_labelage;
    Wine *wineAAfficher;
    UITextView *_textView;

}

@property (nonatomic, strong) NSString *texteAAfficher;
@property (nonatomic, strong) Wine *wineAAfficher;
@end

