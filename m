From: Heitzso <heitzso@growthmodels.com>
Date: Thu, 05 May 2005 12:53:50 +0000
Subject: Re: ss20/ross/smp
Message-Id: <427A175E.5010709@growthmodels.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4279EFEB.2070705@growthmodels.com>
In-Reply-To: <4279EFEB.2070705@growthmodels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Then you're better off than me. Mine dies hard during init, 2.4.30


I don't know a lot about this.  Guessing that the gentoo
specific ross optimizations may be helping me.  What setup
or distro are you running.  I threw out my email to 3 lists
that cover the gamut.  Are you running gentoo?  If so, I
can give you my USE and other flags from make.conf to see
what the diff is.  Any other of the sparc distros will have a
slightly different setup for gcc, libraries, etc.  I wanted
gentoo to get a sun4m optimized ssl setup.  Otherwise
gentoo takes an incredibly long time to compile.

Related to that, I did a series of emerges (gentoo speak)
to insure that gcc/libs/kernel were sort-of in sync as I settled
in the environment.  You may be fighting some variation of a
kernel/lib problem.

I also have a keyboard attached and that may make a diff.
Again, don't really know.

>from kernel.org, SMP enabled. UP runs OK, though. But we seem to have
>similar hardware:
>
>The only thing I've noticed is that my prom counts the CPUs as 0 and 2:
>
>CPU_#0       HyperSPARC ROSS RT620/RT626         0x00080000 Bytes ECache 
>CPU_#2       HyperSPARC ROSS RT620/RT626         0x00080000 Bytes ECache 
>
>CPU_#1       ******* NOT installed *******
>CPU_#3       ******* NOT installed *******
>
>Does that hurt?
>  
>
No.  Usual way it numbers the cpus (believe, not expert).

>I'd like to do some debugging, but I don't know where to start. I have
>no idea where my sparc dies. Cache flushing (these routines are totally
>different for UP and SMP on Hypersparc, as I found out)? Forking and
>context changes? Being a kernel newbie doesn't really help, but I am
>willing to learn,
>

The one kernel that is sort-of guaranteed sparc32 smp
for ross is 2.2 series.  May be possible for you to compile
latest 2.2 kernel SMP and try that out.  Though I believe
interest is in getting SMP smoothed out and working 2.6.x


