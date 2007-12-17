From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 17 Dec 2007 09:40:05 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071217094005.GA31668@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 16, 2007 at 11:48:31PM +0100, Josip Rodin wrote:
> > One problem I was pointed to was the build failure of erlang. Here the
> > created erlc binary segfaults with a bus error.
> > 
> > - this only happens on US III machines, works fine on US II.
> > 
> > - on lebrun it doesn't happen on the first call of erlc, but after
> > several successful runs of it - see
> > http://buildd.debian.org/fetch.cgi?&pkg=erlang&ver=1%3A11.b.5dfsg-11&arch=sparc&stamp97012623&file=log
> 
> BTW, we've had lebrun crash three times since November 12th, the last time
> a few hours ago. The first time I just cycled it via RSC, the second time
> someone looked at it and the console was blank (!) after which we cycled it.
> I'm going over there tomorrow morning to see what's on the console now.

The machine was stuck with a white blank screen on the monitor, and a
dysfunctional keyboard (USB). It's a standard keyboard that came with the
same machine, and otherwise works fine. It's completely dead - not only
normal key combinations (including Alt+SysRq), but pressing Caps Lock
doesn't turn on its LED, and Stop+A doesn't work either.

The machine doesn't have any ports for the old-style Sun keyboards, so I'm
out of options...

-- 
     2. That which causes joy or happiness.
