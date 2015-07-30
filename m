From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 30 Jul 2015 15:36:55 +0000
Subject: Re: Debian drops support for sparc
Message-Id: <20150730153655.GA17673@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150730140453.GA25014@ravnborg.org>
In-Reply-To: <20150730140453.GA25014@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jul 30, 2015 at 04:04:54PM +0200, Sam Ravnborg wrote:
> Hi all.
> 
> Debian have decided to drop support for sparc.
> See additional details  here: https://lists.debian.org/debian-sparc/2015/07/msg00023.html
> 
> To the best of my understanding this is 32 bit userland
> on top of sparc64 kernel that is dropped.
> 
> In Debian ports there is a sparc64 port which is 64-bit
> userland on top of sparc64 kernel.
> There are talks about improving support for the sparc64
> ports but I have not read anything conclusive.
> 
> Additional details can be found the following bug report:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bugt5938
> 
> A major issue is that gcc-4.9 cannot be built for sparc
> for reasons that I failed to follow.

That was a problem for about five months last year, afterwards it was
resolved, though some issues happened later as well:
https://buildd.debian.org/status/logs.php?pkg=gcc-4.9&arch=sparc

The next version also had a spotty coverage:
https://buildd.debian.org/status/logs.php?pkg=gcc-5&arch=sparc

But I think the focus should probably be on the sheer redness of the sparc
columns at:
https://release.debian.org/stretch/arch_qualify.html (prospective release)
https://release.debian.org/jessie/arch_qualify.html (current release)

So, the recurring issues of the number of porters, default compiler,
and buildd kernel stability are critical.

And probably the fact that nobody even responded to
https://lists.debian.org/debian-sparc/2015/07/msg00012.html did not help.
On that note, let's Cc: that list :)

-- 
     2. That which causes joy or happiness.
