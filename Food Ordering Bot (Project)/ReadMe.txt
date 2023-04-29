- It is food ordering program which displays a Menu having a few options
- It takes a bunch of order from user until user exits the program
- It displays a total bill and asks for confirmation if user still wants to continue or not.
- Rectifies if user entered correct input according to the option number, else throws an error.
- Further more user can also reset his whole order cart.

In detail this program consists of 3 MACROs & 8 Procedures.
There is no room for errors related to 'relative jumps out of range'

MACRO:
1. printMsg => Prints the String.
2. printOutput => Prints the single or double digit Outputs.
3. Input => Takes a single digit input.

Procedures:
1. Main => Displays whole menu, takes input, check if it is correct and jump to that repective procedure according to the entered input value.
2. option1 => Stores the amount value in count variable, prints confirm message to the console & jump back to main procedure.
3. option2 => Stores the amount value in count variable, prints confirm message to the console & jump back to main procedure.
4. option3 => Stores the amount value in count variable, prints confirm message to the console & jump back to main procedure.
5. option4 => Stores the amount value in count variable, prints confirm message to the console & jump back to main procedure.
6. resetCart => Sets the value of all variable to default i.e 0, prints confirm message to the console & jump back to main procedure.
7. bill => Displays total quantity for each item, total bill & asks if user wants to continue or not.
8. supporting => It helps in minimizing the distance between (main procedure & mainLoop) & other procedure, which helps in handling the error of relative jump.