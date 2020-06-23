//
//  ViewController.m
//  1-GCD
//
//  Created by Victor  on 23/01/18.
//  Copyright © 2018 Victor . All rights reserved.
//
// https://livebook.manning.com/book/objective-c-fundamentals/chapter-13/24
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// (iFirstParameter : Int, iSecondParameter : String) -> (Int) Declaring block

// usind the block
//instance.block = {}

// invoke the block   instance.block(int)


- (IBAction)btnMainThread:(UIButton *)sender {
    
    // Creamos la URL para nuestra imagen
    NSURL *URL = [NSURL URLWithString:@"https://wallpaperclicker.com/storage/wallpaper/High-Definition-Ultra-HD-Wallpaper-96262544.jpg"];
    
    // Obtenemos los datos de la imagen
    NSData *dataImage = [NSData dataWithContentsOfURL:URL];
    
    // Creamos una imagen con los datos obtenidos
    UIImage *image = [[UIImage alloc] initWithData:dataImage];
    
    //Asignamos al UIImage de nuestra vista dicho UIImage
    _imgView.image = image;
    
  [self exampleBlockBlock];
  [self CaptureVariableFrozen];
}

-(void)exampleBlockBlock{
  
  // 1. Declaring the block  returnType (variableName) (ArgumentType,ArgumentType)
  int(^myBlock) (int, int);
  
  // Using the block
  myBlock = ^int (int a, int b){
    return a * b;
  };
  
  // 3. Invoke the block
  NSLog(@"%d this is the outcome",  myBlock(2,4));
}

-(void)multipleBlocks{
  // The name in the parentheses is treated as a type name
  // treated a block variable
  typedef int (^MyBlock)(int);  //typedef returnType (^nameBlock)(intArgment);
  
  MyBlock isntanceOne = ^(int a){ return a * 2;};
  MyBlock instanceSecond = ^(int b){return b * 3;};
  MyBlock instanceThird = ^(int c){return c * 4;};
}

-(void)BlockWithoutArgument{
  
  
  void(^voidBlock)(void);
  
  int year = 2525;
  
  voidBlock = ^{
    NSLog(@"In this year %i", year);
  };
  
  voidBlock();
}

-(void)CaptureVariableFrozen{
  
  void (^myBlock) (void);
  int year = 2525;
  
  myBlock = ^{
    NSLog(@"In this year %i", year); // capture the first year
  };
  
  myBlock(); // 2525
  
  year = 4545;
  
  myBlock();  //2525
  
}


- (IBAction)btnBackground:(UIButton *)sender {
    // Creamos la URL para nuestra imagen
//    NSURL *URL = [NSURL URLWithString:@&amp;quot;http://www.kennethprimrose.co.uk/wp-content/uploads/2011/06/Scottish-landscape.jpg&amp;quot;];
    
     // Obtenemos la cola de segundo plano
     dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

                  // Invocamos en modo asíncrono un bloque en la cola que hemos recuperado
     dispatch_async(backgroundQueue, ^{
        
        // Obtenemos los datos de la imagen (esto tardara un poco al
        // tratarse de una imagen de alta resolución)
//        NSData *dataImagen = [NSData dataWithContentsOfURL:URL];
        
        // Creamos un UIImage con los datos obtenidos
//        UIImage *imagen = [[UIImage alloc] initWithData:dataImagen];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // Asignamos al UIImageView de nuestra vista dicho UIImage
//            _imgView.image = imagen;
            
        });
        
    });
    
}


@end
