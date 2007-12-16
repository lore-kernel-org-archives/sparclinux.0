From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 16 Dec 2007 22:48:31 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071216224831.GA23466@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 16, 2007 at 11:41:19PM +0100, Bernd Zeimetz wrote:
> >> I'll leave the kernel running and make sure the machine gets some more
> >> users and load during the next days.
> > 
> > Thanks for testing, let me know if any more issues trigger.
> 
> One problem I was pointed to was the build failure of erlang. Here the
> created erlc binary segfaults with a bus error.
> 
> - this only happens on US III machines, works fine on US II.
> 
> - on lebrun it doesn't happen on the first call of erlc, but after
> several successful runs of it - see
> http://buildd.debian.org/fetch.cgi?&pkg=erlang&ver=1%3A11.b.5dfsg-11&arch=sparc&stamp97012623&file=log

BTW, we've had lebrun crash three times since November 12th, the last time
a few hours ago. The first time I just cycled it via RSC, the second time
someone looked at it and the console was blank (!) after which we cycled it.
I'm going over there tomorrow morning to see what's on the console now.

-- 
     2. That which causes joy or happiness.
