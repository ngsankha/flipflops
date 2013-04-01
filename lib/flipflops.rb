require 'net/ssh'

class FlipFlops

	@loggedin = false

	def set_repo(repo)
		@repo = repo
		self
	end

	def login(host, username, password, port = 22)
        puts "=== Logging in to " + host + " ==="
		begin
			@ssh = Net::SSH.start(host, username, {:password => password, :port => port})
			@loggedin = true
		rescue Timeout::Error
			puts "Slippers.login: Connection timed out."
		rescue Errno::EHOSTUNREACH
			puts "Slippers.login: Host unreachable."
		rescue Errno::ECONNREFUSED
			puts "Slippers.login: Host refused connection."
		rescue Net::SSH::AuthenticationFailed
			puts "Slippers.login: Authentication failed. Check your username/password combination."
		end
		self
	end

	def set_path(path)
        puts "=== Changing directory to " + path + " ==="
		if @loggedin
			output = @ssh.exec!("cd " + path)
			puts output
		else
			puts "Slippers.set_path: No establised SSH connection found."
		end
		self
	end

	def update_repo
        puts "=== Updating the repo " + @repo + " ==="
		if @loggedin
			output = @ssh.exec!("git pull " + @repo)
			puts output
		else
			puts "Slippers.update_repo: No establised SSH connection found."
		end
		self
	end

    def clone_repo
        puts "=== Cloning the repo " + @repo + " ==="
		if @loggedin
			output = @ssh.exec!("git clone " + @repo)
			puts output
		else
			puts "Slippers.update_repo: No establised SSH connection found."
		end
		self
	end

    def exec_script(script)
        if @loggedin
            output = @ssh.exec!(script)
            puts output
        else
            puts "Slippers.exec_script: No establised SSH connection found."
        end
        self
    end

    def close
        if @loggedin
            puts "=== Closing connection ==="
            @ssh.close
        else
            puts "Slippers.close: No establised SSH connection found."
        end
        self
    end
end