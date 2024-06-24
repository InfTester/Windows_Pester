#set variables
$servers = @('SRV1','SRV2','SRV3','SRV4','SRV5')

#For loop - For executing code a predicted number of times.
# for ($i = 0; $i -lt 1; $i++) { $i }
#Consists of 4 elements:
#1. The iterative variable declaration
#2. The Condition to continue running the loop
#3. The action to perform on the iterative variable after each successful loop
#4. the code you want to execute
for ($i =0; $i -lt $servers.Length; $i++) {
	$servers[$i] = "new $server"
}
$servers