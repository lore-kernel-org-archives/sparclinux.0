From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 05:40:37 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <20070728.224037.39158363.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 28 Jul 2007 19:18:50 +0100 (BST)

> Do you have any Sparc32/generic Sparc patches that have not already been 
> pushded up to 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

No.

> I have just tried out the latest commit on my sun4c SS1 and have found it 
> to have a NULL pointer bug. I can't give any details as the serial console 
> support is broaken and on the cgthree console, the information scrolled of 
> the top of the console before I had a chance to read any of the key 
> details.
> 
> In addition, enabling CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY killed the 
> kernel while starting up the cgthree (it just stopped - no messages).
> 
> Looks like I am going to have to step through the changes from my 
> working v2.6.22 kernel slowly.

Yes, basically expect sparc32 to break as long as there is not
a maintainer that constantly pulls from upstream and tests things
on a frequent basis as I do for sparc64.

Feel free to step up and be "the one" :-)
