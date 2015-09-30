# smali-code-injector
Script to perform code injection in Android apps. 

The code injection is performed on the assembly level of an app. Therefore an user needs first to de-assembly an app in order to get its .smali assembly files. For this task, I highly recommand to use **smali/baksmali** which are respectively an Android assembler/de-assembler natively present in the **Santoku Linux distribution**. 

The basic purpose of this script is to add a trace to all the methods of a given Android app, to help to debug or reverse engineer it. However, the power of this script resides on its high customizable possibilities. Indeed a user can use smali-code-injector to inject its own custom code. Smali-code-injector deals with the register dependancies and properties to make the code injection easy and automatic.

To inject its custom code a user has to follow this procedure:
* Copy the smali method inside of the **/files/MyCustomClass.smali** file. 
* Modify the **inject_code** methods parameters inside of the **inject.py** file.
	
Futur improvements:
* The possibility to inject the code to a specific method.
* A user basic interface to make the injection of custom code more friendly.
* Code optimization.

For all the details regarding reverse engineering of Android apps refers to this link:

	http://www.n00blinuxhacker.com/android-pentesting-reverse-engineering-android-app.html

## Requirements
Running the script on smali files using the local registers directive.
You need to install the progressbar package available here or you can just comment the lines using this library in the **process** file. You will loose the processing time indications: 
	
	http://code.google.com/p/python-progressbar/

## Usage
### Examples:
To use a debugging tag (for the add_trace feature) and the folder from where all the smali files enclosed will be treated:

		$ ./smali-code-injector -t tag -f root_folder

To use the default tag which is my_tag and the default root folder which is ./:

		$ ./smali-code-injector
		
To display the help menu:

		$ ./smali-code-injector -h
		
## Project information
This script was developed in the context of my master thesis work in July 2015.	
