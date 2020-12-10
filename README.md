
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

  

****If you would like to review the code changes and the project up to this point checkout the git branch** `splash-screen`**.****

  

## Navigation