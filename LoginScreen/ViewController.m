//
//  ViewController.m
//  LoginScreen
//
//  Created by Artyom Gurbovich on 4.07.21.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;
@property (weak, nonatomic) IBOutlet UIView *secureView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *secureButtons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.loginTextField.layer.cornerRadius = 5.0;
    self.loginTextField.layer.borderWidth = 1.5;
    self.loginTextField.layer.borderColor = [UIColor colorNamed:@"Black Coral"].CGColor;
    self.loginTextField.delegate = self;
    
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.borderColor = [UIColor colorNamed:@"Black Coral"].CGColor;
    self.passwordTextField.delegate = self;
    
    self.authorizeButton.layer.cornerRadius = 10.0;
    self.authorizeButton.layer.borderWidth = 2.0;
    self.authorizeButton.layer.borderColor = [UIColor colorNamed:@"Little Boy Blue"].CGColor;
    [self.authorizeButton addTarget:self action:@selector(authorizeButtonTapped) forControlEvents:UIControlEventTouchDown];
    [self.authorizeButton addTarget:self action:@selector(authorizeButtonReleased) forControlEvents:UIControlEventTouchUpInside];
    
    self.secureView.layer.cornerRadius = 10.0;
    self.secureView.layer.borderWidth = 2.0;
    self.secureView.layer.borderColor = [UIColor colorNamed:@"White"].CGColor;
    [self.secureView setHidden:true];
    
    for (UIButton *secureButton in self.secureButtons) {
        secureButton.layer.cornerRadius = 25.0;
        secureButton.layer.borderWidth = 1.5;
        secureButton.layer.borderColor = [UIColor colorNamed:@"Little Boy Blue"].CGColor;
        [secureButton addTarget:self action:@selector(secureButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [secureButton addTarget:self action:@selector(secureButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = [UIColor colorNamed:@"Black Coral"].CGColor;
}

-(void)dismissKeyboard {
    [self.loginTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)authorizeButtonTapped {
    self.authorizeButton.backgroundColor = [[UIColor colorNamed:@"Little Boy Blue"] colorWithAlphaComponent:0.2];
}

- (void)authorizeButtonReleased {
    self.authorizeButton.backgroundColor = [UIColor colorNamed:@"White"];
    if ([self.loginTextField.text isEqual:@"username"] && [self.passwordTextField.text isEqual:@"password"]) {
        [self.loginTextField setEnabled:false];
        [self.loginTextField setAlpha:0.5];
        [self.passwordTextField setEnabled:false];
        [self.passwordTextField setAlpha:0.5];
        [self.authorizeButton setEnabled:false];
        [self.authorizeButton setAlpha:0.5];
        self.loginTextField.layer.borderColor = [UIColor colorNamed:@"Torquoise Green"].CGColor;
        self.passwordTextField.layer.borderColor = [UIColor colorNamed:@"Torquoise Green"].CGColor;
        [self.secureView setHidden:false];
    } else {
        self.loginTextField.layer.borderColor = [UIColor colorNamed:@"Venetian Red"].CGColor;
        self.passwordTextField.layer.borderColor = [UIColor colorNamed:@"Venetian Red"].CGColor;
    }
}

- (void)secureButtonTapped:(UIButton*)button {
    button.backgroundColor = [[UIColor colorNamed:@"Little Boy Blue"] colorWithAlphaComponent:0.2];
}

- (void)secureButtonReleased:(UIButton*)button {
    NSString *value = button.titleLabel.text;
    NSString *updatedText = [self.resultLabel.text stringByAppendingString:[@" " stringByAppendingString: value]];
    if ([self.resultLabel.text isEqual:@"_"]) {
        self.resultLabel.text = value;
        self.secureView.layer.borderColor = [UIColor colorNamed:@"White"].CGColor;
    } else if (self.resultLabel.text.length < 3) {
        self.resultLabel.text = updatedText;
    } else if ([updatedText isEqual: @"1 3 2"]) {
        self.resultLabel.text = updatedText;
        self.secureView.layer.borderColor = [UIColor colorNamed:@"Torquoise Green"].CGColor;
        [self presentRefreshAlert];
    } else {
        self.resultLabel.text = @"_";
        self.secureView.layer.borderColor = [UIColor colorNamed:@"Venetian Red"].CGColor;
    }
    button.backgroundColor = [UIColor colorNamed:@"White"];
}

- (void)presentRefreshAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome"
                                                  message:@"You are successfuly authorized!"
                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *refreshButton = [UIAlertAction actionWithTitle:@"Refresh"
                                                  style:UIAlertActionStyleDestructive
                                                  handler:^(UIAlertAction *action) {
                                                      [self restartAppState];
                                                  }];
    [alert addAction:refreshButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)restartAppState {
    self.resultLabel.text = @"_";
    self.secureView.layer.borderColor = [UIColor colorNamed:@"White"].CGColor;
    [self.secureView setHidden:true];
    [self.loginTextField setEnabled:true];
    self.loginTextField.text = @"";
    [self.loginTextField setAlpha:1.0];
    [self.passwordTextField setEnabled:true];
    self.passwordTextField.text = @"";
    [self.passwordTextField setAlpha:1.0];
    [self.authorizeButton setEnabled:true];
    [self.authorizeButton setAlpha:1.0];
    self.loginTextField.layer.borderColor = [UIColor colorNamed:@"Black Coral"].CGColor;
    self.passwordTextField.layer.borderColor = [UIColor colorNamed:@"Black Coral"].CGColor;
}

@end
