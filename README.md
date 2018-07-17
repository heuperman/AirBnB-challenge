# AirBnB Challenge

*flavour text here*

description here

## User Stories  

1. Any signed-up user can list a new space.  

        As a New User
        So I can list my flat
        I would like to sign up to Makers BnB  

        As a Signed up User
        So I can list my flat
        I want to login to Makers BnB  

        As a Signed up User
        So nobody else can use my account
        I would like to log out  

        As a Logged in User
        So I can make some money
        I would like to list my space  

----------------

2. Users can list multiple spaces.   

        As a Logged in User
        I want to make more money
        I would like to list multiple spaces   

________________

3. Users should be able to name their space, provide a short description of the space, and a price per night.  

        As a User
        So people can find my space
        I want to be able give my space a name  

        As a User
        So people can know how much they are paying
        I want to be able show the price per day of my space  

        As a User
        So people know what they are booking
        I want to be able give my space some description ( Location, Rooms, Size)  

__________________

4. Users should be able to offer a range of dates where their space is available.

        As a User
        So people know when they can stay at my space
        I would like to select the dates that my space is available  
5. Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.  

        As a User
        So I can rent a place for one night
        I would like to make a request  

___________________

6. Nights for which a space has already been booked should not be available for users to book that space  

        As a User
        So I don’t book a place that is already booked
        I want to book places that available  

        As an Owner
        So I can avoid double bookings
        I would like to the ability to automatically
        update when I confirm the booking  

7. Until a user has confirmed a booking request, that space can still be booked for that night.  


        As an Owner
        So I can confirm the booking
        I would like to approve the request  

## Getting started
Enter the following commands in your terminal:

Clone the repository:
`git clone https://github.com/heuperman/AirBnB-challenge.git`

Install the required gems:
`bundle install`

## Usage
Enter the following commands in your terminal:

Change into the main directory:
`cd AirBnB-challenge.git`

Run the app:
`rackup config.ru`

*add example images here*

Then open your browser, head to http://localhost:9292/ where you should find the page shown above. Then simply follow the instructions on the page.

## Running tests
This app comes with a full feature test and unit tests with 100% coverage (determined using the simplecov and istanbul).
To run all available tests enter `rspec` in your terminal.

## Built with
Sinatra -- as the web framework  
Jasmine -- as the JavaScript testing framework
etc

## Authors
The good people at [Makers Academy](https://makers.tech/) -- instructions  

Team teamname:
Our names and links to github
