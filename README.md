# Creating and Releasing a Flutter Application

Flutter is a cross platform development kit. It can be used to create Android, iOS, Web, Linux, Mac, Windows applications and more from one code base. In this tutorial, we will be focusing on creating and releasing an application for iOS and Android. 

The application we will be building here will highlight some of the basics of Flutter as well as creating a user interactive photo reveal feature. Once the application is complete, we will cover the steps needed to release the application to both the Apple App Store and The Google Play Store.
	
 - *As always in technology things are always changing so please refer to [Flutter](https://flutter.dev/docs), for any questions or clarifications.*


# Getting Started

- *First install or upgrade to the latest version of Flutter. Follow these installation [guides ](https://flutter.dev/docs/get-started/install)*

In this tutorial, we will be using Android Studio as our code editor, which can be downloaded [here](https://developer.android.com/studio/?gclid=CjwKCAjwq_D7BRADEiwAVMDdHjI_Lu5xR1whSMHH-WDMO3x6WDQVbBcZxbhN9h6m9SsT6b_wjmuKkhoCbSwQAvD_BwE&gclsrc=aw.ds). To complete the iOS deployment steps you will also need to have [Xcode](https://developer.apple.com/xcode/) installed. The last piece we need to set up before beginning this project is the set up of an [iOS simulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-ios-simulator) as well as an [Android emulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-android-emulator). Once these sets have been completed we are ready to start working with the Flutter Framework!

## Creating the Project

Here are two of the simplest ways to create a Flutter project:

- Use the command line to create your project by running the command `flutter create <my_project_name>` inside the directory you want your project to be created in.
- The second option is to open **Android Studio**, on the start up screen there is an option `Start a new Flutter project` This will bring up a prompt allowing you to select **Flutter Application** and your new project will be created in the directory you specify in the project set up.

## Understanding your new Project Structure

Flutter applications start from the **main** function. this can be found in `lib/main.dart`
When you first create your flutter project this file will contain a main function which calls `runApp(MyApp())`

Within the **MyApp** class there is a function `build(BuildContext context)` This returns a *Material App* which can be configured with themes, title, a home page and more.

The next most important file to become familiar with is `pubspec.yaml`, this is where you will be able to include third party libraries, declare assets, and your Flutter version.

While this new Flutter app includes many other files, these do not need to be altered to create this application.

## Adding Assets ([Flutter Documentation](https://flutter.dev/docs/development/ui/assets-and-images))

When adding assets to your application bundle, you will want to first create an assets directory at the same level as your lib directory. Inside the assets directory, add an images directory.

Copy the images you intend to include into this directory, and register the image assets folder in the `pubspec.yaml` file.  
  
To register the assets in the `pubspec.yaml` file include the lines  

    flutter:
	    assets:
	    - assets/images/
    

Adding the `/` at the end of images registers all the assets inside that directory. If needed it is possible to use the direct path to the image assets, but for this project we will just register the images directory as a whole.

If you have already run your app on the emulator/simulator or a device, you will not be able to use the hot reload feature to quickly rerun your app. To see newly added images you will need to stop running the app and restart it from your IDE.

## Creating a Splash/Launch Screen
The first bit of code we will be working with will build a splash screen for  the launch of our application.This is a fairly simple layout, but it will allow us to explore some of the basic elements of Flutter.

First, we will create a new directory called widgets inside our `lib` directory. Inside the widgets directory create a dart file named `splash_screen.dart`

Inside this file we will first import material, core, and async packages with lines:

    import 'package:flutter/material.dart';
    import 'dart:core';
    import 'dart:async';
Next we will make a class called `SplashScreen` which extends StatefulWidget. This class will include properties seconds, title, navigateAfterSeconds, and image. These properties will be used to create and display our splash screen.

    class SplashScreen extends StatefulWidget {
	    final int seconds;
	    final Text title;
	    final dynamic navigateAfterSeconds;
	    final Image image;
	    
	    SplashScreen(
		    {
			    @required this.seconds,
				this.navigateAfterSeconds,
				this.title = const Text(''),
				this.image
			}
		);
		
		@override
		_SplashScreenState createState() => _SplashScreenState();
	}
Now that we have our `SplashScreen` class we need to create the `_SplashScreenState` class which will help manage the status, building and display of our splash screen. 

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
			    );}} );}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: new Stack(
				fit: StackFit.expand,
				children: <Widget>[
					new Container( //sets background color
						decoration: new BoxDecoration(
						color: Colors.green[300],),),
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
												padding: const EdgeInsets.only(top: 5.0),
												),
											widget.title
										],
								)),
	),],),],),);}}

In the `initState` method of this class we create a **Timer** to manage the length of time our splash screen is displayed. This takes the `seconds` property form `SplashScreen` and displays the splash screen for that amount of time before moving the user into the interactive elements of the application.  
  
The `build(BuildContext context)` method sets up the layout for our screen. We start with a Scaffold to manage each element on the screen. In this case we have a stack inside the scaffold that contains our image, title, background, and out padding widgets to help with the layout.

Now that we have created our `SplashScreen` class we need to go to `main.dart` to tell the application to display it.

## Displaying The Splash Screen

In `main.dart` we will be replacing the `home:` widget with an instance of our `splashscreen` class.

First, import the `splashscreen` file into main.dart by. adding 
`import 'package:tutorial/widgets/splash_screen.dart';`

Now replace the home widget of the `Material App` with this code

    SplashScreen(  
        seconds: 1,  
        navigateAfterSeconds: MyHomePage(title: "Reveal Tutorial"),  
		title: new Text('Reveal Tutorial'),  
	    image: new Image.asset('assets/images/watering_can.png'),  
    ),

In this code we are not only creating our splash screen we are also declaring how many `seconds` to display the `Splashscreen`, what the app will present once it finishes displaying `navigateAfterSeconds`, the title test to display, as well as our first use of an asset with the reference to the image we display on the splash screen.

**If you would like to review the code changes and the project up to this point checkout the git branch `splash-screen`.**

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
Once more add a new file inside the widgets directory named `reveal_screen.dart`

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
										      image: new Image.asset('assets/images/plant3.jpeg'))));  
    }
This code calls on the `Navigator` Class to `push` our newly created route on to the view stack. 
Inside the `push` call we create an instance of `MaterialPageRoute` which will build an instance of our `RevealScreen` with the provided properties. 

Now run the program, you should see the new button on the home screen, once that is tapped you will be presented with the reveal screen. To return to the `HomeScreen` we could add a button that would call ` Navigator.pop(context);`, but instead of exploring that option we will create a Tab Navigation Bar to control the application's routing. 


## Creating a Tab Navigation Bar
To create our tab bar, we first need to create a list of screens to represent each tab inside our `_MyHomePageState`

    final List<Widget> _tabChildren = [  
      RevealScreen(text: new Text('Palm'),  
	      image: new Image.asset('assets/images/plant1.jpeg')),  
      RevealScreen(text: new Text('Calathea'),  
	      image: new Image.asset('assets/images/plant2.jpeg')),  
      RevealScreen(text: new Text('Succulents'),  
	      image: new Image.asset('assets/images/plant3.jpeg')),  
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
		                  icon: Image.asset('assets/images/rake.png',  
					      width: 40,  
					      height: 40,),  
						  title: Text( "Plants",  
					      style: TextStyle(color: Colors.white),  
						  ),  
					    ),
					     BottomNavigationBarItem(  
		                  icon: Image.asset('assets/images/shovel.png',  
					      width: 40,  
					      height: 40,),  
						  title: Text( "Plants",  
					      style: TextStyle(color: Colors.white),  
						  ),  
					    ),
					     BottomNavigationBarItem(  
		                  icon: Image.asset('assets/images/can.png',  
					      width: 40,  
					      height: 40,),  
						  title: Text( "Plants",  
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

