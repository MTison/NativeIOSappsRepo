# NativeIOSappsRepo
# IOS_Project_Matthias Tison - 3B2 HoGent

# Usage of the application

There is a kitura server called “CarServer”, this project must be run together with the main project “MTNativeIOSappsProject3B2”. For the CarServer project, just open the file “CarServer.xcodeproj”, but for the main project open the workspace file “MTNativeIOSappsProject3B2.xcworkspace”. 

When both projects are opened, first run the CarServer project, when it is running there should be “Listening on port 8080” in the output window. Now you are ready to also run the main project, the iPhone simulator should open automatically. 

		----------------------------------------------------------------------------------		

# Application summary:	

It is an application for car people to keep track of all the cars that they have driven in the past. Where they can add, edit and delete cars they have driven in in their collection. 

# Functionalities:

-	Login system, keeps user that logged in stored in userDefaults (local storage)

The user gives his email address and password that is linked to the given email. There are 2 buttons on the page. First one is the “Login” button for the actual login, next is the “Register” button if the user is new to the app. When the user makes an error, there is a notification at the top of the page, which notifies the user.

-	Registration page for new users

On the registration page, there are several fields the user must fill in. When there occur errors the user will be notified through the page itself, which responds to erroneous inputs. When the user is finished filling in the fields, they can simply tap the “Register” button which, if successful, leads to the login page.

-	Welcome view

After successful login, the user is directed to a brief welcome screen, which greets the user, by addressing him with the name the user chose at registration. There is an image shown of a car and a link to the next page, saying “Go to your car collection >”.

-	A list overview of the cars that the user has driven with

Here the user can see all the cars he has added to his collection, all cars which he has driven with. Each list item consists of an image of the car logo, the brand name and type of the car. A car can be added by tapping on the “+” icon in the top right corner. A car can be edited with a long press gesture on the item. Deleting the item can be done by swiping left or right. Finally, the user can log out by tapping the “Logout” button in the top right corner.

-	Page for adding a car to the user it’s collection

On this page, the user creates a new car to ad to his/her collection of driven cars. First, he/she can choose a brand through scrolling and picking one in the picker view. Second, a text input for the type of car. Last, a text area for the experience that the user had driving the car, there is always a text provide as default, saying “Good experience.”.

# Extra info and usages:

The application uses userdefaults to keep data of the user that just logged into the application. It runs with a kitura backend, where the cars are stored, as also all the users. For each user cars are saved separately, through the cars having the userId of the user that created them. The cars to get an id, so they can be separated from each other, and updated separately. 
