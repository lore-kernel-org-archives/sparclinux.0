From: Heitzso <heitzso@growthmodels.com>
Date: Thu, 05 May 2005 14:50:27 +0000
Subject: Re: ss20/ross/smp
Message-Id: <427A32B3.2090701@growthmodels.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4279EFEB.2070705@growthmodels.com>
In-Reply-To: <4279EFEB.2070705@growthmodels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>>Then you're better off than me. Mine dies hard during init, 2.4.30
>>
>>
>>I don't know a lot about this.  Guessing that the gentoo
>>specific ross optimizations may be helping me.
>>    
>>
>
>I thought you were running stock kernel.org?
>
>  
>
I am running stock kernel.  But the tool chain is gentoo sparc
and the entire tool chain, libraries, etc. was compiled for my
sparc/ross box.  From another email response, guessing the
gentoo optimizations for the libraries/compilers/et al are not
the issue.

>>What setup or distro are you running.  I threw out my email to 3 lists
>>that cover the gamut.
>>    
>>
>
>Debian woody, sorry, I should have mentioned this.
>
>  
>
Debian woody will use a very different (older) tool chain stack then gentoo.
(gcc/libs).  Guessing this is likely diff letting me run SMP on roughly
equiv. box.

>>Are you running gentoo?  If so, I
>>can give you my USE and other flags from make.conf to see
>>what the diff is.  Any other of the sparc distros will have a
>>slightly different setup for gcc, libraries, etc.  I wanted
>>gentoo to get a sun4m optimized ssl setup.  Otherwise
>>gentoo takes an incredibly long time to compile.
>>    
>>
>
>Having only one ISDN line for internet access rules out gentoo or
>Debian testing/unstable or any other download intensive distro for now.
>
>  
>
>>Related to that, I did a series of emerges (gentoo speak)
>>to insure that gcc/libs/kernel were sort-of in sync as I settled
>>in the environment.  You may be fighting some variation of a
>>kernel/lib problem.
>>    
>>
>
>I don't think so, else 2.4.30 would not run UP on my box:
>
>maril:~# uname -a
>Linux maril 2.4.30 #3 Sat Apr 30 20:00:51 CEST 2005 sparc unknown
>maril:~# gcc -v
>Reading specs from /usr/lib/gcc-lib/sparc-linux/2.95.4/specs
>gcc version 2.95.4 20011002 (Debian prerelease)
>
>  
>
I'm compiling with gcc 3.3.5   Yours is 2.95.4
My understanding is this is very important re kernel compiles.
Somebody else may want to chime in and note why the gcc
version is (or isn't) important re SMP versus UP.

>[del]
>  
>
>>The one kernel that is sort-of guaranteed sparc32 smp
>>for ross is 2.2 series.  May be possible for you to compile
>>latest 2.2 kernel SMP and try that out.  Though I believe
>>interest is in getting SMP smoothed out and working 2.6.x
>>    
>>
>
>I will give 2.2 a spin to gather more info. I bought the system from ebay,
>so there may be a hardware glitch I don't know about, but when it's running
>2.2.x SMP, I think we can rule that out.
>  
>
You may want to swap out CPUs, i.e. run with just one, then
just the other, and double check that they're both good.
This is a possibility.
