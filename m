From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 28 Jul 2007 21:48:56 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070728234856.0fb78952.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 28 Jul 2007 19:18:50 +0100 (BST)
Mark Fortescue <mark@mtfhpc.demon.co.uk> wrote:

> Hi David,
> 
> Do you have any Sparc32/generic Sparc patches that have not already been 
> pushded up to 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> I have just tried out the latest commit on my sun4c SS1 and have found it 
> to have a NULL pointer bug. I can't give any details as the serial console 
> support is broaken and on the cgthree console, the information scrolled of 
> the top of the console before I had a chance to read any of the key 
> details.
> 

I have just booted the 2.6.32-rc1-git4 (which differs from yours by only 3 IA64 patches) on SS20 
with UP kernel and Aurora 3. The SMP kernel boots but it crashes when storage is
initialized (I try tracking this down).

There is a trick however which appeared to be needed some kernel versions ago. I need to patch vsprinf.c
file to replace the va_arg(long long) call with two va_arg(long) calls. It is probably due to broken compiler in 
the Aurora 3. Otherwise it hangs very early. This hanging is random and may differ with features selected to
be compiled into the kernel.

Regards,
Krzysztof
