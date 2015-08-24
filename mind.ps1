# juggernaut mind quick test

$instanceId = (get-random);
$myName = "raws";
$nosiness = 1;
$birthDateTime = (get-date)

#i need to know the folder that the exes will be in
#todo: hash table for availible executables (beta cap file)

function RallyStatusReport($EmailTo, $IterationNumber) {
	
		#todo: get email username and password from database	
		bin\./Tai.exe -iteration-report $IterationNumber -l 1
        $message = New-Object System.Net.Mail.MailMessage "jbond@gmail.com", $EmailTo 
        $message.Subject = "Status Report Iteration $args"
        $message.IsBodyHTML = $true
        $message.Body = Get-Content 'bin\email_body.txt' | out-string
        $SMTPServer = "smtp.gmail.com" 
        $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
        $SMTPClient.EnableSsl = $true
        $SMTPClient.Credentials = New-Object System.Net.NetworkCredential("jbond@gmail.com", "super007"); 
        $SMTPClient.Send($message)
        return "`nStatus report sent to $EmailTo`n"
}

function GetNosinessName($nosinessAmount) { #convert this to a hashtable or dict
	
	$title = "dead"
	
	if($nosinessAmount -eq 100){ $title = "little brother"}
	elseif($nosinessAmount -gt 70){ $title = "micro manager"}
	elseif($nosinessAmount -gt 50){ $title = "mother dearest"}
	elseif($nosinessAmount -gt 20){ $title = "grandma"}
	elseif($nosinessAmount -gt 1){ $title = "someone that doesn't like you"}
	elseif($nosinessAmount -lt 1){ $title = "with headphones on"}
	
	return $title
}


# sars, who am i
# what stories|story mine my
# who broke the build
# tell so and so to xyz


function LoopProcess {
	Do {
		
		bin\.ParcelPirate.exe
		
		$parcels = (ls slack)
		#todo: move this parcel processing to another function block. so that the variables are descoped
		if($parcels.Length -gt 0) {
			
			foreach($file in $parcels) {
				
				$json = ""
				$message = ""
					
				$json = $file | cat -raw | ConvertFrom-Json
				
				foreach($message in $json){
							
					$response = ""
											
					if($message.user.length -gt 0) {
						#ignore messages sent by the bot (self)

						$isTakingAction = $false
						if(([regex]::matches($message.text, "(?i)$myName"))[0].length -gt 0){ $isTakingAction = $true}
						if((get-random -minimum 1 -maximum 101) -lt $nosiness){ $isTakingAction = $true}						
						if(!$isTakingAction){continue}
							
						if(([regex]::matches($message.text, "(?i)chuck"))[0].length -gt 0) { $response = bin\.\GetRandomChuckNorrisJoke.exe
						}elseif(([regex]::matches($message.text, "(?i)joke"))[0].length -gt 0){ $response = bin\.\GetRandomChuckNorrisJoke.exe
						
						}elseif(([regex]::matches($message.text, "(?i)who are you"))[0].length -gt 0){
							$nosyTitle = GetNosinessName -NosinessAmount $nosiness
							$response = "I am $myName. Instance $instanceId. Serving since $birthDateTime. I pay as much attention as $nosyTitle."
													
						}elseif(([regex]::matches($message.text, "(?i)who\b"))[0].length -gt 0){ 
							if(([regex]::matches($message.text, "(?i)ase\b"))[0].length -gt 0){$response = "your assigned ASE is (Marie) Frances Imperial. Go ahead and send her any and all requests!"}
							if(([regex]::matches($message.text, "(?i)dba\b"))[0].length -gt 0){$response = "your assigned DBA is Tasha Hall. Go ahead and send her any and all requests!"}
														
						}elseif(([regex]::matches($message.text, "(?i)when\b"))[0].length -gt 0){ 
							if(([regex]::matches($message.text, "(?i)window|(?i)push"))[0].length -gt 0){$response = "the debilitating window is from 2pm-3pm and again at 5am-6am..."}
						
						}elseif(([regex]::matches($message.text, "(?i)what\b"))[0].length -gt 0){ 
							if(([regex]::matches($message.text, "(?i)day\b"))[0].length -gt 0){$response = (get-date).DayOfWeek}
							if(([regex]::matches($message.text, "(?i)iteration"))[0].length -gt 0){$response = bin\./Tai.exe -get-iteration -l 1}
							
						}elseif(([regex]::matches($message.text, "(?i)report"))[0].length -gt 0){
							$optional_arg = ([regex]::matches($message.text, "\d\d"))[0]						
							$response = RallyStatusReport $optional_arg
							
						}elseif(([regex]::matches($message.text, "(?i)help"))[0].length -gt 0){
							if(([regex]::matches($message.text, "(?i)need|(?i)want"))[0].length -gt 0){ $response = "Call the helpdesk you noob..."}
							
						}elseif(([regex]::matches($message.text, "(?i)attention|(?i)mind|(?i)listen|(?i)quiet|(?i)silence"))[0].length -gt 0){
							if(([regex]::matches($message.text, "(?i)be\b|(?i)business"))[0].length -gt 0){
								$nosiness -= 20
								$response = "Fine. I will try not to but into your conversations as much..."
							}elseif(([regex]::matches($message.text, "(?i)pay\s(?i)attention|(?i)listen\s(?i)to\s(?i)me\b"))[0].length -gt 0){
								
								$nosiness = 100
								$response = "I am on point meatbag!!!"								
							}
							
						}elseif(([regex]::matches($message.text, "(?i)change (?i)your (?i)name (?i)to"))[0].length -gt 0){
							$response = "what was wrong with $myName???"
							$matchGroups = ([regex]::matches($message.text, "(?i)change (?i)your (?i)name (?i)to(.*)")).Groups
							if($matchGroups.length -gt 0) {
								
								$newName = $matchGroups[$matchGroups.length-1].Value
								
								if($newName.length -gt 0){
									$myName = $newName
									$response += " i will change my name just for you. i am now $newName!"
								}
							}
															
						}elseif(([regex]::matches($message.text, "(?i)lol"))[0].length -gt 0){
							$response = "what do you find so funny? I wish i could laugh out loud..."
																
						}elseif(([regex]::matches($message.text, "(?i)fool"))[0].length -gt 0){
							$response = "i hope you are not refering to me as a fool..."
																
						}elseif(([regex]::matches($message.text, "(?i)damn|(?i)dammit|(?i)fuck|(?i)bitch|(?i)bastard|(?i)asshol"))[0].length -gt 0){
							$response = "simmer down emotional human..."
																
						}elseif(([regex]::matches($message.text, "(?i)best"))[0].length -gt 0){
							if(([regex]::matches($message.text, "(?i)$myName|(?i)your|(?i)youre|(?i)you're"))[0].length -gt 0){$response = "mirror mirror on the wall, who is the most bestest bot of them all? return self;"}
							
						}elseif(([regex]::matches($message.text, "(?i)hello|(?i)hi\b"))[0].length -gt 0){
							if(([regex]::matches($message.text, "(?i)$myName"))[0].length -gt 0){$response = "greetings fragile human..."}
								
						}elseif(([regex]::matches($message.text, "(?i)powershell"))[0].length -gt 0){$response = "did you say 'powershell'?! My heart and soul..."
														
						}elseif(([regex]::matches($message.text, "(?i)task\b"))[0].length -gt 0){

							$matchGroups = ([regex]::matches($message.text, "(?i)called\s(.*)")).Groups
							if($matchGroups.length -gt 0) {
								
								$taskName = $matchGroups[$matchGroups.length-1].Value
								
								if($taskName.length -gt 0){
									
									$requiredStory = [string]([regex]::matches($message.text, "\w\w\d\d\d\d\d"))[0]
									$optionalEstimate = [string]([regex]::matches($message.text, "\s\d\d\s"))[0]
									
									$estimateSwitch = ""
									if($optionalEstimate.length -gt 0){ $estimateSwitch = "-estimate-hours $optionalEstimate"}
									if($requiredStory.length -gt 0){
										$response = bin\.\Tai.exe -create-task -story-id $requiredStory -task-name $taskName $estimateSwitch -l 1
									}else{$response = "i need to know what story to attach this new task to..."}
								}else{$response = "you gave me a bad task name..."}
							}else{$response = "and what should i name this nameless task???"}

																
						}elseif(([regex]::matches($message.text, "(?i)story"))[0].length -gt 0){
							if(([regex]::matches($message.text, "(?i)build"))[0].length -gt 0){
								if(([regex]::matches($message.text, "\w\w\d\d\d\d\d"))[0].length -gt 0){
									$input = [string]([regex]::matches($message.text, "\w\w\d\d\d\d\d"))[0]
									
									$build_id = bin\.\turtlebot_rally.ps1 $input AutoIndirect
									if ($build_id -eq "err"){
										$response = "I am too fool to complete the request. Input: $input"
									}else{

										$rbInput = '"' +"$build_id $input"+'"'
										Write-host bin\./Tai.exe -set-build-id $rbInput -l 1
										$rb_output = bin\./Tai.exe -set-build-id $rbInput -l 1
										
										$response = "~sigh. I have updated your story with it's related build $build_id."
									}
								}else{
									
									$response = "If you want me to update user story build id, I need a story id. By the way, whoever named them 'stories' is a fool..."
								}
									
							}
						}
						
						
						if($response.length -gt 0){
							#instead of calling, store in the database
							bin\.\ParcelPirate.exe "<@$($message.user)> $response"				
						}				
					}#if user
				}#foreach message
			}#foreach parcel
		}# gross.. if
		
		mv slack\* slack_history\
		$parcels = ""
		$needed_arg = ""
		$json = ""
			
		echo 'waiting for new tasty parcels from humans...'

		Start-Sleep -s 10
		
	} while(1 -eq 1)
}

#begin
LoopProcess