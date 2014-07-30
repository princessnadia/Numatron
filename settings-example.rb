@settings = {
	'server' => 'irc.esper.net', # The server to connect to
	'port' => 6697,							 # The port
	'ssl' => true,							 # Whether to use, or not to use ssl
	'nickname'=> 'MyBot',				 # Nickname
	'username'=> 'MyBot',				 # Username
	'realname'=> 'MyBot',				 # Realname
	'password'=> 'MyPass',			 # Password
	'admins'  => ["vifino"],		 # The admins that have complete control, use with caution, lowercase
	'channels'=> ["#mybot"],		 # Channels to join
	'blacklistChannels'=> ["#officialChan"], # Channel, where bot functions arent allowed, aka, passive mode.
	'notFoundmsg' => false,			 # Wether to say that a command doesnt exist, or nit
	'prefix' => "#"							 # Prefix for the commands, can be long, and is regex
}
