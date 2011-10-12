From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 12 Oct 2011 23:21:28 +0000
Subject: Re: longjmp question
Message-Id: <20111012232128.GA5603@wooyd.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
To: sparclinux@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 12, 2011 at 07:06:17PM -0400, David Miller wrote:
> 
> Jurij, how do I setup this testcase?
> 
> I checked out Ruby from SVN and built it, but I can't find this
> miniruby thing so that I can run the command line in that Ruby bug
> report.
> 
> Thanks.

Thanks for looking at it! Attached is a script which I use to set up 
the environment and start gdb for the binary (you probably will need 
directory names adjusted, if you are building from directly from svn 
and not from Debian package). I'm still in the process of trying to 
understand what's Ruby is trying to do with all the machine state 
saves and restores, so I was not able to make a lot of progress so 
far.

Best regads,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=run

#!/bin/sh
export RUBY=/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236/ruby1.9.1
export PATH=/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
export RUBYLIB=/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236:/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236/.ext/common:/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236/.ext/sparc-linux:/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236/lib
export LD_LIBRARY_PATH=/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236
export LD_PRELOAD=/home/jurij/ruby/ruby1.9.1-1.9.3~preview1+svn33236/libruby-1.9.1.so.1.9.1

cat > script <<EOF
file ./ruby1.9.1
set args -rcontinuation -e 'callcc { |c| c.call }'
set break pending on
break cont_capture
run
EOF

gdb -x script

--8t9RHnE3ZwKMSgU+--
