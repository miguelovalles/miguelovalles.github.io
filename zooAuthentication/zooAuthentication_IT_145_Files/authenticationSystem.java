import java.io.File;
import java.util.Scanner;
import java.security.MessageDigest;

class userInputs{
    
        String userName;                           //Initializing username input
        String userPassword;			 //Initializing user password input

        /* assigning file path and file names */
        
        String filesPath;
        String credentialsFile;     
        
        /* created strings to use for accessing files when printing user roles */
        
		String zookeeper;
                String admin;
		String veterinarian;
		
		int loginAttempts;    
                
}

class prompts{

		void loginPrompt() {
		
		System.out.println("Welcome to the zoo administrative system.");           //Welcome screen message
                System.out.println("Please login.");						//Prompt user to log incorrect
                System.out.println("To exit login, please enter 'quit'.");
                System.out.println(" ");									//Printing spacing row.
		
		
	}
	
		void loginSuccessPrompt() {
		
                System.out.println(" ");                       				 						 //Printing for spacing row.
                System.out.println("What would you like to do?");									//Prompt the user to confirm if they want to log out or stay logged in.
                System.out.println("To log out enter 'quit' otherwise you will stay logged in.");
                System.out.println("If you wish to stay logged in enter 'no'.");
                System.out.println(" ");                                                                                             //Printing for spacing row.
                System.out.println("Enter response:  ");
		
	}
                
        void loginAttemptsPrompts() {
                
                System.out.println("You have reached the maximum attempts allowed.");            
                System.out.println("Please exit the login area and start the program over.");
                System.out.println("Thank You!");
	
    }
                
        void tryAgain() {
                    
                System.out.println("Please try entering your credentials again.");                  //Prompting user to try logging in again.
                System.out.println(" ");                                                            //Prompting user to try logging in again.
                                   
    }
            
}

public class zooAuthentication 
        
        {
    
            public static void main(String[] args) throws Exception {
		
		Scanner userInput = new Scanner(System.in);      //Scanner for user input of username and password.
		Scanner userExit = new Scanner(System.in);	 //Scanner for user exit of program prompt input
				
                inputText uIn = new inputText();
                prompts prompts = new prompts();
                
                uIn.filesPath = ("C:\\Users\\migue\\OneDrive\\SNHU\\IT-145\\Authentication Project\\");
                uIn.credentialsFile = ("credentials.txt");
                
                uIn.loginAttempts = 3;
                boolean loginSuccess = false;				  //setting boolean as false for loginSuccess default
                
                                    
                prompts.loginPrompt();                          //Calling login prompts
                    
		while(true) 
                {

                    System.out.println("Enter username: ");       														//Prompting the user to enter their username.
                    uIn.userName = userInput.nextLine().toLowerCase();

                if(uIn.userName.contentEquals("quit")){                    												//If user enters quit,print following two lines and break process.
			       
                    System.out.println("You have selected to exit the login process.");
                    System.out.println("If you wish to login please exit and start the program again.");
                                         
                        break;}
			
                if(!(uIn.userName.contentEquals("quit")))  { 															//If username not equal to quit, then continue program.
                    
                    System.out.println(" ");
                    System.out.println("Enter password: ");       																//Prompting the user to enter their password.
                    uIn.userPassword = userInput.nextLine();
                            
                    System.out.println(" ");                        												//Printing blank row in between print outs.
			
			/*MD5 Hash Section Message Digest */
			
			MessageDigest md = MessageDigest.getInstance("MD5");
                            md.update(uIn.userPassword.getBytes());
				byte[] digest = md.digest();
				 
				StringBuffer sb = new StringBuffer();
						
                    for (byte b : digest){
                        
			sb.append(String.format("%02x", b & 0xff));
                        
                            }

                    loginSuccess = false;
                    
                Scanner credentialCheck = new Scanner(new File(uIn.filesPath + uIn.credentialsFile));	//Scanner to read file path and crendentials file for user login info.		
				
                    while(credentialCheck.hasNextLine()){
                                
                        String credReview = credentialCheck.nextLine();
                        String colLocation[] = credReview.split("\t");
                                
                            if(colLocation[0].trim().equals(uIn.userName)){
                                    
                                if(colLocation[1].trim().equals(sb.toString())){
                                            
                                    loginSuccess = true;
                                            
                        Scanner userRole = new Scanner(new File(uIn.filesPath + colLocation[3].trim() + ".txt"));           //Scanner to go to file path and read credentials file, index 3 for user role.
						
                            while(userRole.hasNextLine()){
							
                                System.out.println(userRole.nextLine());                   								//Printing out the content of the role file.
                                    
                                    }
                                        break;
                        
            }
	}
    }

                        if(loginSuccess) {
                            
                    prompts.loginSuccessPrompt();                             //Calling after log in user prompts. 
                            
                    String exitInput = userExit.nextLine().toLowerCase();             //Accepting user input after successful login.
						
				if(exitInput.contentEquals("quit")){
                                    
                                    System.out.println(" ");                									 //Printing for spacing row.
                                    System.out.println("You have successfully logged out. Thank you!");			//Notify user that they have successfully logged out of the system.
						
                                        break;
                                                }
                                if(exitInput.contentEquals("no")){
                                    
                                    System.out.println(" ");                									//Printing for spacing row.	
                                    System.out.println("You are still logged in to the system.");               //Notify user that they are still logged in.
						
                                        break;
                                                }
					
			else 
                                {
                                    loginSuccess = false;						//If login attempt is unsuccessful
					}
				
                                    }
                               
                    else
                            {
					
                                uIn.loginAttempts --;										   //If user enters incorrect credentials, subtract 1 attempt until 0 attempts are left.
							
				System.out.println("Incorrect username or password.");     								  //Letting user know that incorrect username and password were input.
				System.out.println("You have " + uIn.loginAttempts + " attempts left.");                      //Letting user know of login attempts left before end.
                                System.out.println(" ");                                                  //Printing for spacing row.
                                
                    if(uIn.loginAttempts == 0)																  //If 0 attempts are left print the following information and end the program using break.
                            {
						
                            prompts.loginAttemptsPrompts();
                                
                                break;
                                    }
                    
                    else 
                            {
                        
                            prompts.tryAgain();
                    }   
				}
			}
		}
    }
}
        
