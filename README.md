
# Creating and Releasing a Flutter Application

  
Flutter is a cross platform development kit. It can be used to create Android, iOS, Web, Linux, Mac, Windows applications and more from one code base. This tutorial  will be focusing on creating and releasing an application for iOS and Android.

This application will highlight some of the basics of Flutter as well as the implementation of a user interactive photo reveal feature. Once the application is complete, you will learn the steps needed to release the application to both the Apple App Store and The Google Play Store.

 *_As always in technology things are always changing so please refer to_ [_Flutter_](https://flutter.dev/docs)_, for any questions or clarifications._*

  

  

# Getting Started

  

- *_First install or upgrade to the latest version of Flutter. Follow these installation_ [_guides_ ](https://flutter.dev/docs/get-started/install)*

  

In this tutorial, it is recommended to use Android Studio as you code editor, which can be downloaded [here](https://developer.android.com/studio/?gclid=CjwKCAjwq_D7BRADEiwAVMDdHjI_Lu5xR1whSMHH-WDMO3x6WDQVbBcZxbhN9h6m9SsT6b_wjmuKkhoCbSwQAvD_BwE&gclsrc=aw.ds). To complete the iOS deployment steps you will also need to have [Xcode](https://developer.apple.com/xcode/) installed. The last piece you will need to set up before beginning this project is the set up of an [iOS simulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-ios-simulator) as well as an [Android emulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-android-emulator). Once these sets have been completed you are ready to start working with the Flutter Framework!

  

## Creating the Project

  

Here are two of the simplest ways to create a Flutter project:

- Use the command line to create your project by running the command `flutter create <my_project_name>` inside the directory you want your project to be created in.

- The second option is to open ****Android Studio****, on the start up screen there is an option `Start a new Flutter project` This will bring up a prompt allowing you to select ****Flutter Application**** and your new project will be created in the directory you specify in the project set up.

  

## Understanding your new Project Structure


Flutter applications start from the ****main**** function. this can be found in `lib/main.dart`

When you first create your flutter project this file will contain a main function which calls `runApp(MyApp())`

  

Within the **MyApp** class there is a function `build(BuildContext context)` This returns a *_Material App_* which can be configured with themes, title, a home page and more.

  

The next most important file to become familiar with is `pubspec.yaml`, this is where you will be able to include third party libraries, declare assets, and your Flutter version.

  

While this new Flutter app includes many other files, these do not need to be altered to create this application.

  

## Adding Assets ([Flutter Documentation](https://flutter.dev/docs/development/ui/assets-and-images))

  

When adding assets to your application bundle, you will want to first create an assets directory at the same level as your lib directory. Inside the assets directory, add directories named 2.0x and 3.0x.

With these directories we will add images with the same name but if different sizes for the framework to pick up. In the assets directory, we will add our smallest images then add the larger files to 2.0x and 3.0x

Add the images you intend to include, and register the image assets folder in the `pubspec.yaml` file.

To register the assets in the `pubspec.yaml` file include the lines

  

```
flutter:    
  assets: 
    - assets/
```
  

Adding the `/` at the end of assets registers all the assets inside that directory. If needed it is possible to use the direct path to the image assets, but for this project you will just register the images directory as a whole.

  

If you have already run your app on the emulator/simulator or a device, you will not be able to use the hot reload feature to quickly rerun your app. To see newly added images you will need to stop running the app and restart it from your IDE.

  

## Creating a Splash/Launch Screen

The first bit of code you will be working with will build a splash screen for  the launch of your application.This is a fairly simple layout, but it will allow us to explore some of the basic elements of Flutter.

First, you will create a new directory called widgets inside your `lib` directory. Inside the widgets directory create a dart file named `splash_screen.dart`



Inside this file you will first import material, core, and async packages with lines:

  

```
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
```
Next, you will make a class called `SplashScreen` which extends StatefulWidget. This class will include properties seconds, title, navigateAfterSeconds, and image. These properties will be used to create and display your splash screen.

  
``` dart
class SplashScreen extends StatefulWidget {

    final int seconds;
    final Text title;
    final dynamic navigateAfterSeconds;
    final Image image;

    SplashScreen({
    @required this.seconds,
        this.navigateAfterSeconds,
        this.title = const Text(''),
        this.image
    });

    @override
    _SplashScreenState createState() => _SplashScreenState();
}
```
Now that you have your `SplashScreen` class you will need to create the `_SplashScreenState` class which will help manage the status, building and display of your splash screen.

  
```dart
class _SplashScreenState extends State<SplashScreen> {
    @override
    void initState() {
    super.initState();
      Timer(  
      Duration(seconds: widget.seconds),  
  () {  
        if (widget.navigateAfterSeconds is String) {  
          Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);  
  } else if (widget.navigateAfterSeconds is Widget) {  
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => widget.navigateAfterSeconds));  
  } else {  
          throw new ArgumentError(  
              'widget.navigateAfterSeconds must either be a String or Widget'  
  );  
  }  
      }  
  );  
}  
@override
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: new Stack(  
        fit: StackFit.expand,  
        children: <Widget>[  
          new Container(  
            decoration: new BoxDecoration(  
              color: Colors.white,),  
          ),  
         new Column(  
            mainAxisAlignment: MainAxisAlignment.start,  
            children: <Widget>[  
              new Expanded(  
                  flex: 2,  
                  child: new Container(  
                    child: new Column(  
                      mainAxisAlignment: MainAxisAlignment.center,  
                        children: <Widget>[  
                            new SizedBox(  
                                height:122.5,  
                                child: widget.image),  
                            new Padding(  
                                padding: const EdgeInsets.only(top: 5.0),),  
                            widget.title  
                        ],  
                      )
                    ),
                      ),
                  ],
                ),  
              ],
            ),
          );
      }  
}
```
  

In the `initState` method of this class you will create a **Timer** to manage the length of time your splash screen is displayed. This takes the `seconds` property form `SplashScreen` and displays the splash screen for that amount of time before moving the user into the interactive elements of the application.

The `build(BuildContext context)` method sets up the layout for your screen. You will start with a Scaffold to manage each element on the screen. In this case you will have a stack inside the scaffold that contains an image, title, background, and padding widgets to help with the layout.

  

Now that you have created a `SplashScreen` class you will need to go to `main.dart` to tell the application to display it.

  

## Displaying The Splash Screen

  

In `main.dart` you will be replacing the `home:` widget with an instance of your `splashscreen` class.

  

First, import the `splashscreen` file into main.dart by. adding

`import 'package:tutorial/widgets/splash_screen.dart';`

  

Now replace the home widget of the `Material App` with this code

  
```dart
SplashScreen(
    seconds: 1,
    navigateAfterSeconds: MyHomePage(title: "Reveal Tutorial"),
    title: new Text('Reveal Tutorial'),
    image: new Image.asset('assets/icon-eucalyptus.png'),
),
```
  

In this code you are not only creating a splash screen you are also declaring how many `seconds` to display the `Splashscreen`, what the app will present once it finishes displaying `navigateAfterSeconds`, the title test to display, as well as your first use of an asset with the reference to the image you will display on the splash screen.

  

****If you would like to review the code changes and the project up to this point checkout the git branch** `splash-screen`**.

  

## Navigation ([Flutter Documentation](https://api.flutter.dev/flutter/widgets/Navigator-class.html))

The Splash screen class has given us a peek into flutter navigation, but now we want to begin understand how navigation is used in flutter.

There are two major pieces to navigation in flutter:
-`Navigator` - This is a provided widget which manages and maintains a stack-based view history
-`Routes`- These are objects used by the navigator to know which screen or partial screen to display next along with the transition between screen.

With those important types in mind we will begin to update our application to include multiple screen navigations. 

## Navigation Set Up

To prepare for our navigation exploration, we will create a new file in our widgets folder named `home_screen.dart`

In this file we will move the code for `MyHomePage` class as well as `_MyHomePageState`, make sure to include `import 'package:flutter/material.dart';` at the top of `home_screen.dart` and we will need to add `import 'package:tutorial/widgets/home_screen.dart';` to the top of `main.dart` so it can successfully reference `MyHomePage`. 

Before we can explore navigation further we will need to create at least one more screen.
Once more, add a new file inside the widgets directory named `reveal_screen.dart`

We will revisit this class later, but for now we will create a simple screen with an image and text.
Add this code to `reveal_screen.dart`:

    class RevealScreen extends StatefulWidget {  
     final Text text;  
     final Image image;  
      
      RevealScreen(  
          {  
            @required this.text,  
		     this.image  
      });  
      
      @override  
      _RevealScreenState createState() => _RevealScreenState();  
    }  
      
    class _RevealScreenState extends State<RevealScreen> {  
      
      @override  
      Widget build(BuildContext context) {  
        return Scaffold(  
          body: Center(  
            child: Column(  
              mainAxisAlignment: MainAxisAlignment.center,  
		      children: <Widget>[  
	               widget.text,  
				   new SizedBox(  
                    height:120.0,  
				    child: widget.image  
			      ),  
		      ],  
	      ),  
	     ),  
      );  
      }  
    }

## Initial Navigation
We will need to add `import 'package:tutorial/widgets/reveal_screen.dart';` to `home_screen.dart` to reference our reveal screen.

Now that we have a screen to navigate to let's add a button to our homeScreen, that will navigate to our reveal screen when tapped by a user. 

To add a button to the home screen create a `FlatButton` under the counter text in the body:

    FlatButton(  
       shape: RoundedRectangleBorder(  
          borderRadius: BorderRadius.all(Radius.circular(50)),  
	      ),  
       color: Colors.green,  
       onPressed: () {},  
       child: Text("Next Screen",  
       style: TextStyle(  
            color: Colors.white  
		    )	  
	   )  
    )

This creates a green button with white text for us to add an action. To navigate to our revealScreen add the following code to `onPressed`

    () { Navigator.of(context).push(MaterialPageRoute(  
        builder: (context) => RevealScreen(text: new Text('Succulents'),  
										      image: new Image.asset('assets/cactus.png'))));  
    }
This code calls on the `Navigator` Class to `push` our newly created route on to the view stack. 
Inside the `push` call we create an instance of `MaterialPageRoute` which will build an instance of our `RevealScreen` with the provided properties. 

Now run the program, you should see the new button on the home screen, once that is tapped you will be presented with the reveal screen. To return to the `HomeScreen` we could add a button that would call ` Navigator.pop(context);`, but instead of exploring that option we will create a Tab Navigation Bar to control the application's routing. 


## Creating a Tab Navigation Bar
To create our tab bar, we first need to create a list of screens to represent each tab inside our `_MyHomePageState`

    final List<Widget> _tabChildren = [  
      RevealScreen(text: new Text('Fig Tree'),  
	      image: new Image.asset('assets/figTree.png')),  
      RevealScreen(text: new Text('Eucalyptus'),  
	      image: new Image.asset('assets/eucalyptus.png')),  
      RevealScreen(text: new Text('Cactus'),  
	      image: new Image.asset('assets/cactus.png')),  
    ];
Here we are creating a `RevealScreen` for the three tabs we will have. We also need to add a current tab variable.
`var _currentTab = 0;`
This needs to be updated when a tab is pressed so we will add a function to handle that as well

 

       void onTabTapped(int index) {  
          setState(() {  
            _currentTab = index;  
          });  
        }
  With that set up, we will now make some drastic changes to our home screen. Instead of showing our counter and buttons, we will just be displaying our **AppBar** , **BottomNavigationBar**, and the active **Reveal Screen**.
  
  To make these changes update the build function of the homePage with this code:
  

    @override  
    Widget build(BuildContext context) {  
      return Scaffold(  
        appBar: AppBar(  
          title: Text(widget.title),  
      ),  
      body: SafeArea(  
             child:  _tabChildren[_currentTab],  
      ),  
      bottomNavigationBar: Theme(  
          data: Theme.of(context).copyWith(  
          primaryColor: Colors.white,  
	      canvasColor: Colors.green[300],  
      ),  
      child: Container(  
            decoration: BoxDecoration(  
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)]),  
		    child: BottomNavigationBar(  
              type: BottomNavigationBarType.fixed,  
		      currentIndex: _currentTab,  
		      onTap: onTabTapped,  
		      items: [  
                  BottomNavigationBarItem(
                    icon: Image.asset(
                    'assets/icon-fig.png',
                    width: 40,
                    height: 40,
                    ),
                    title: Text( "Fig Tree",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset( 'assets/icon-eucalyptus.png',
                      width: 40,
                      height: 40,
                    ),
                    title: Text( "Eucalyptus",
                      style: TextStyle(color: Colors.white),
                    ),
                    ),
                  BottomNavigationBarItem(
                    icon: Image.asset( 'assets/icon-cactus.png',
                      width: 40,
                      height: 40,
                    ),
                    title: Text( "Cactus",
                      style: TextStyle(color: Colors.white),
                      ),
                    ),
				      ],  
				     ),  
				    )  
			      )  
			    );  
			  }
Now we have a bottom navigation bar with three items. When we run the code we can see the navigation items and that tapping them switches our current view without calling on the Navigator class.

##Reveal Feature

Now that we can navigate between screens, lets add some mystery for the user! Instead of instantly displaying the image to the user we will add a swipe to reveal overlay. 
This will allow us to explore using a third party library and create a more dynamic application.

First we need to declare the third party dependency in our pubspec.yaml file under dependencies.
```
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.3
  scratcher: "^1.4.0"
```
Now press 'Pub get' in the top right of Android Studios to pull in the library.

With the scratcher library imported into our project we can begin to build our reveal feature. First create a new file in the widgets directory named reveal_area.dart
in this file we will import the material and scratcher libraries.
```import 'package:flutter/material.dart';
   import 'package:scratcher/widgets.dart';
```

In this file we will create our RevealArea widget. This will take in a threshold function used once the user has revealed the threshold percentage of the area, and two images, one 
image to be revealed and one image to hide the image to be revealed.
 ``
```class RevealArea extends StatelessWidget {
     final Image image;
     final overlayImage;
   
     final scratchKey = GlobalKey<ScratcherState>();
   
     final Function onThreshold;
   
     RevealArea({
       this.onThreshold,
       this.overlayImage,
       this.image,
     });

    void reveal() {
        scratchKey.currentState.reveal();
    }
     @override
     Widget build(BuildContext context) {
   
      return Scratcher(
            key: scratchKey,
            brushSize: 40,
            threshold: 45,
            accuracy: ScratchAccuracy.medium,
            color: Colors.transparent,
            image: this.overlayImage,
            onThreshold: this.onThreshold != null
                ? this.onThreshold
                : () {
              reveal();
            },
            child: Container(
              child: Column(
                children: [
                  Container(),
                  IgnorePointer(child: this.image),
                ],
              ),
            ),
          );
        }
   }
```
 With this widget in place, we can now update our RevealScreen widget to allow for user interaction.
First we need to import our reveal_area widget into our reveal screen widget. 
```
import 'package:tutorial/widgets/reveal_area.dart';
```
Now that we have imported the RevealArea we can replace the child element of the RevealScreen padding object with 
```
child: RevealArea(onThreshold: this.onThreshold(), overlayImage: Image.asset( 'assets/blur-fig.png'), image: this.widget.image,))
```
Running this, we can not see the reveal area for each plant screen!

To avoid hard coding the overlay image and having the same blur image for each plant, lets add an overlay image to the Reveal Screen constructor.
Inside the RevealScreen class we will add ```bool _imageReavealed = false;``` This will allow the app to keep track of the image state. We will also add a _onReveal and a reset function when we create the reveal state object. 

```
class RevealScreen extends StatefulWidget {
     final Text text;
     final Image image;
     final Image overlayImage;
     bool _imageRevealed = false;

     RevealScreen(
         {
           @required this.text,
           this.overlayImage,
           this.image,
         });
```
and we will update the RevealArea creation 
```
RevealArea(onThreshold: this.onThreshold(), overlayImage: this.widget.overlayImage, image: this.widget.image,))
```

Now in the MyHomePage file we will need to update the Reveal Screen constructors to include an overlay image.

```  final List<Widget> _tabChildren = [
       RevealScreen(text: new Text('Fiddle Leaf Fig'),
         overlayImage: new Image.asset('assets/blur-fig.png'),
         image: new Image.asset('assets/figTree.png')),
       RevealScreen(text: new Text('Eucalyptus'),
           overlayImage: new Image.asset('assets/blur-eucalyptus.png'),
           image: new Image.asset('assets/eucalyptus.png')),
       RevealScreen(text: new Text('Cactus'),
           overlayImage: new Image.asset('assets/blur-cactus.png'),
           image: new Image.asset('assets/cactus.png')),
     ];
```

With the swipe to reveal feature now in place we will add a button to allow the user to reset the reveal feature and give them a bit of instruction.

```
 void _onReveal() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        widget._imageRevealed = true;
      });
    });
  }

  reset() {
    setState(() {
      widget._imageRevealed = false;
    });
  }
```
The onReveal function will be passed into the revealArea widget and called onThreshold, the reset function will be called when the user presses the 'START AGAIN' button.
In the widget build function we will include some logic to display the 'START AGAIN' button once the image has been revealed as well as some logic to give the user instructional text.
```

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.text,
            if (!_imageRevealed) Text('Swipe to reveal this plant.'),
            if (_imageRevealed) OutlineButton(
                  onPressed: this.reset,
                  child: Text('START AGAIN')
              ),
            Padding(
              padding: EdgeInsets.all(26),
              child: _imageRevealed == true ? this.widget.image : RevealArea(onThreshold: _onReveal, overlayImage: this.widget.overlayImage, image: this.widget.image),
            )
          ],
        ),
      ),
    );
  }
```

Now we have a functioning reveal feature with the ability for the user to restart the process and navigate through the app. The styling of our app could use a bit of work though before we call it complete.

##Styling

While it is not normally wise to wait till the features are built in an application before styling, we have grouped many of the styling instructions together for this tutorial. 
First, we want to create a colors class. Our application will not have a large amount of colors to use across the app, but many projects will use multiple colors that will need to be organized.

We will add a directory named 'utility' and inside we will create a file 'colors.dart' 
This will contain our three main colors allowing us to import them when needed.
```
import 'package:flutter/cupertino.dart';
   
class AppColors {
  static const colorGrey = Color(0xFFD1DBD8);
  static const colorLightGrey = Color(0xFFDFE4E7);
  static const colorHighlightWhite = Color(0xFFFFFFFF);
}
```

Starting with the splash screen widget, use `import 'package:tutorial/utility/colors.dart';` to import the colors file, then in our build function replace color.green with 'AppColors.colorGrey'
This will set the background color of our splash screen.

On the reveal screen we will import the colors as well and update the background to 'AppColors.colorGrey' by adding `backgroundColor: AppColors.colorGrey,` within the Scaffold of our build function.

We also want to update the colors used for our tab bar. In the `home_screen.widget` we will set the canvasColor of the `bottomNavigationBar` to 'AppColors.colorLightGrey'

Also on the home page we will be removing the App Bar, while this is a useful widget it does not fix with our designs. This means we can remove the title property from our home screen class as well as from its constructor.

Now that we have our widgets set to the colors of our designs lets focus on the spacing of our text and their styles.
For the title of the RevealScreen, we will construct the text widget with a style as we build each screen
```
title: new Text('Fiddle Leaf Fig', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
```
In the style property of `Text` we can create a `TextStyle` to set the font color, weight, family and more.

We will also update our instruction text in the reveal screen widget.
```Text('Swipe to reveal this plant.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal))```

Now that we have updated our font sizes we can see that we need a bit of space between the lines of font. so we can add ```SizedBox(height: 16),``` in the list of children for the column.

##Release

Now the we have a solid application its time to explore the process needed to submit the application to both the Apple store and the Google Play store.
There are often updates and adjustments made to the building and uploading steps with these stores so it is best to reference the official Flutter documentation for specific details.

[Apple Store instructions from the Flutter Team](https://flutter.dev/docs/deployment/ios)
[Google Play instructions from the Flutter Team](https://flutter.dev/docs/deployment/android)
