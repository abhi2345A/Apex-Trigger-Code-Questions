# Apex-Trigger-Code-Questions

```
Q1) Pre-Reqs:
Create a field on Account called “Only_Default_Contact”, checkbox, default off

Assignment:
When a new Account is created, create a new Contact that has the following data points:

First Name = “Info”
Last Name = “Default”
Email = “info@websitedomain.tld”
Only_Default_Contact = TRUE
When the Account has more than 1 Contact, update Only_Default_Contact to FALSE.
```

```
Q2) Create Account record whenever new contact is created without an account.
```

```
Q3) Pre-Reqs:
Create a field on Account called “ Contact_Created__c ”, checkbox, default off

Assignment:
Create an apex trigger on the contact object and every time a new contact will be created and an account will be 
selected in the creation of that contact object then on that account object a checkbox filed ( Contact_Created__c ) 
will be checked true, which represent that this account has a contact.
```

```
Q4) Pre-Reqs:
Create a field on Account called “Out_of_Zip”, checkbox, default off

Assignment:
When a Billing Address is modified, get the new Postal Code. Then check which Contacts on the Account are outside
that Postal Code. If 1 or more Contacts are outside of the Postal Code, mark Out_of_Zip as TRUE.
```

```
Q5) Pre-Reqs:
Create a field on Contact called Profile, text, 255

Assignment:
When an Account is updated and the Website is filled in, update all the Profile field on all Contacts to:

Profile = Website + ‘/’ + First Letter of First Name + Last Name

```

```
Q6) Pre-Reqs:
Create a field on Account called “is_gold”, checkbox, default off

Assignment:
When an Opportunity amount is greater than $20k, mark is_gold to TRUE
```

```
Q7) Pre-Reqs:
Create a field on Account called “need_intel”, checkbox, default off

Create a field on Contact called “Dead”, checkbox, default off

Assignment:
If 70% or more of the Contacts on an Account are Dead, mark the need_intel field to TRUE
```
```
Q8) Enforce Single Primary Contact on Account - Primary_Contact__c custom field on the Contact
//Acc1 - con1, con2p
//Acc2 - con3, con4p
```
```
Q9) Write a trigger on contact to prevent duplicate records based on Contact Email & Contact Phone.
```
