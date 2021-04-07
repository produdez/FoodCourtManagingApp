# foodcourtmanagerapp

Sotfware Engineering Project

Report: [GroupReport.pdf](GroupReport.pdf)

## Motivation:


The university is currently has one food court located in its Ly Thuong Kiet campus and is going to build another one in Di An campus. All food courts consist of a number of vendors at food vendors or service counters. Meals are ordered at one of the vendors and then carried to a common area for consumption. The food may also be ordered to take-away. All food are self serviced and there's no food delivering system (maybe in the future).

In 2020, the university wish to build a smart food court system (SFCS) to make the university more smart. The system is for customers to order foods from the tip of their fingers - their mobile device.

The mobile app allows users to order food anywhere, before they come to the food court. Notification will be pushed to the app to notify order ready to be picked up.

Payment can be made on-site or through other online methods like Pay-pal, Momo,...

Of course, the application have other features and interfaces for the managers and staffs of the store:

* For employees: Order queueing, stock management,..
* For vendor: Menu editor, employee management, discount plans,..
* For foodcourt manager: Authentication, Overall management and statistics,..

## Features:
We'll go in detail about the features in this document.
## 1. Interactive: 
* View list: After login customer can see a list of available vendors in the Food Court. The customer can also click on a vendor in the list to see the menu of that vendor.
*  Searching: User can search for items in their current working tag, like searching food for customer, staffs for manager,... User can also choose a filter category to narrow down the search result.
* Place order: while browsing through dishes gallery, customer can pick items to add to their shopping cart.
They also can choose item quantity and remove items from cart,... before proceeding to payment.
* Payment: After confirming their order choice, customer can choose their payment method, either by online payment through third-parties like Momo, Paypal,.. or directly pay at the vendor cashier. (In our project, online payment is not implemented).
* Manage orders: The vendor staff can view a dynamic queue of waiting order, notify the customer when the order is ready and finish the order when payment is finished.
* User profile: Every user must access the system through an authentication system, the account types include: Customer, staff, technician, vendor owner and food court manager. Each actor can also view and edit their profile. (In our project, profile page is not implemented)
* Manipulate data: Include the methods for managing and manipulate data base for each actor. Such as view and modify vendors, vendor menu, staffs,...
* View Report: Food court manager and vendor manager can view reports and statistics for their respective business.
* Generate Report: Generate reports for vendors and food court. Depend on types of reports, the ways to generate them are different.

## 2. Non-interactive:

* The data for each order of each food court is automatically stored in data base for analysis.
* Every operating day, at a specific pre-defined time, report of statistics of stalls and the whole food court is auto-generated for future view.
* When system is put into maintenance, all processes are saved for for when the system comes back online.

