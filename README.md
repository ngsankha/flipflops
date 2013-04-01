# Slippers

Just wear it and you are good to go! Erm, just kidding! Its a simple server deployment tool.

## Ok, how do I install?

Its a Ruby gem, so just get it by

    gem install slippers

## Hey, how do I use it?

Its pretty simple to use as well. It works with git repos currently. Just create a Ruby script like:

```
require 'slippers'
s = Slippers.new
s.login('host', 'username', 'password') 			# SSH login to the server
 .set_repo('https://github.com/username/repo.git') 	# Set the master repo to deploy from
 .exec_script('mysqld stop') 						# or whatever pre-deployment commands you would like to execute
 .set_path('public') 								# change directory
 .clone_repo 										# clone the master repository
 .exec_script('mysqld start')
 .close 											# close the connection

```

## Lets make it better?

Sure, I would love you to! File an issue if you find a bug, or have a feature request. Forks and pulls awesome too!