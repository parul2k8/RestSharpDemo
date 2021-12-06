Feature: Login

Login->MovieSelection->SeatSelection->Payment->printTickets->SMS

@Registarion_Successfull
Scenario: Valid User registration for ticket booking
	Given The user has provided correct details
	When Login Registration page is presented
	Then Display successful registration message 


@Registarion_Unsuccessfull
Scenario: Invalid data entered in User registration for ticket booking
	Given The user has provided invalid details
	When Login Registration page is presented
	Then Display Error Message on the Registration Page

	Examples: 
 | name             | username | password | Msg                                                    |
 | Blank Username   |          | password | ERROR: The username field is empty.                    |
 | Blank Password   | test2    |          | ERROR: The password field is empty.                    |
 | invalid Password | test2    | $&*(^%   | ERROR: Password doesnt follow the password policy.     |
 | invalid username | test     | password | ERROR: Username already exists.                        |
 | valid credentials| test1    | password | SUCCESS: User registration succesful.                  |

 @Login_Successfull
Scenario: Valid User login for ticket booking
	Given The user has provided correct details
	When Login page is presented
	Then Display successful Login message 

@Login_Unsuccessfull
Scenario: Invalid credentials entered in login for ticket booking
	Given The user has provided invalid details
	When Login page is presented
	Then Display Error Message on the Login Page

	Examples: 
 | name             | username | password | Msg                                                    |
 | Blank Username   |          | password | ERROR: The username field is empty.                    |
 | Blank Password   | admin    |          | ERROR: The password field is empty.                    |
 | invalid Password | admin    | $%*GH    | ERROR: Wrong password. Forgot passowrd?                |
 | invalid username | test     | password | ERROR: User does not exists.                           |
 | valid credentials| test1    | password | SUCCESS: login succesful.                              |


  @BookTickets_WithoutLogin
Scenario: User wants to book tikcet without login
	Given The user has selected continue without login
	When Login page is presented
	Then Navigate to Movie Information Page


  @MovieSelection_Succesful
Scenario: Valid inputs in movie selection
	Given Movie information page is diplayed
	When Movie, Date and Time are selected
	Then Display Success message and Enable button for seat selection

   @MovieSelection_Unsuccesful
Scenario: Invalid input during movie selection
	Given Movie information page is diplayed
	When invalid inputs are selected
	Then Display error message and keep seat selection button disabled

	   @MovieSelection_Unsuccesful
Scenario: No show is available
	Given Movie information page is diplayed
	When No shows are available for selected date and time and movie
	Then Display error message and keep seat selection button disabled

	Examples: 
	Assumption : Shows having seats avilable shall only be displayed for selection.
 | name              | Show   | Date  | Time    | Msg                                                                   |
 | Blank             |        |       |         | ERROR: Please select a movie.                                         |
 | Blank Date        | Movie1 |       |         | ERROR: Please select a date.                                          |
 | Blank Time        | Movie1 | 12Dec |         | ERROR: Please select a time.                                          |
 | Valid inputs      | Movie1 | 12Dec | 2:00 AM | SUCCESS: Show selected, proceeding to seat selection.                 |



  @Display_SeatSelection
Scenario: Allow Select selection
	Given Seats are selected
	When Selected seats are less than Eleven
	Then Confirm seat selection

	Examples: 
 | name                   | Seat Count | Msg                                                  |
 | No seats               | 0          | ERROR: Please select a seat.                         |
 | Invalid seat selection | 12         | ERROR: Max 10 seats allowed to book.                 |
 | Valid number of seats  | 4          | SUCCESS: Seat selection Done, proceeding to payment. |

   @Display_PaymentPage
Scenario: Payment page
	Given Payment page is displayed
	When Payment details are correct
	Then Confirm payment.

   @Payment_Calculations
Scenario: Payment discount for Ted Card 
	Given Payment page is displayed
	When User has TedCard
	And booking count is not completely divisible by five
	Then apply ten percentage discount

	@Payment_Calculations
Scenario: Payment full discount for Ted Card 
   Given Payment page is displayed
	When booking count is completely divisible by five
	Then apply hundrerd percentage discount

	@Payment_Calculations
Scenario: Payment discount for Super Tuesdays 
	When booking day is tuesday
	Then apply fifty percentage discount

	@Payment_Calculations
Scenario: No Payment discount 
	When booking day is not tuesday
	And user has no ted card
	Then apply no discount

	
	Examples: 
	Assumptions: 
	* Either Super tuesday or Ted discounts shall be applied. 
	* User will have an option to enter their ted card number before providing credit card details
	  Thus, allowing system to calculate discount before proceessing credit card information.
 | name                     | Booking day | Booking Count | Valid ted card number provided | discount |
 | No ted membership        | Monday      | 0             | no                             | 0        |
 | No ted membership        | Tuesday     | 0             | no                             | 50       |
 | Ted membership           | Monday      | 1             | yes                            | 10       |
 | Booking on Tuesday       | Tuesday     | 1             | yes                            | 50       |
 | Fifth booking            | Monday      | 5             | yes                            | 100      |
 | Fifth booking on Tuesday | Tuesday     | 5             | yes                            | 100      |


 
   @Display_PaymentConfirmation
Scenario: Payment confirmation
	Given Payment has confirmed
	Then Display Payment confirmation and Print ticket button


  @Send_SMS_Successful
Scenario: Send booking details via SMS
	Given Print Ticket button is pressed
	When Valid phone number is provided
	And Send button is pressed
	Then Success message is shown and SMS is sent to the phone number.

	@Send_SMS_Unsuccessful
Scenario: When invalid phone number is provided.
	Given Print Ticket button is pressed
	When Invalid phone number is provided
	And Send button is pressed
	Then Error message shall be shown.

		Examples: 
 | name          | Valid Phone number | Msg                                            |
 | Invalid phone | N                  | ERROR: Please provide a correct phone number.  |
 | Valid phone   | Y                  | SUCCESS: Booking details sent to given number. |

