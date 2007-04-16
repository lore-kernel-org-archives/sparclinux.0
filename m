From: Emanuele Rocca <ema@debian.org>
Date: Mon, 16 Apr 2007 20:08:40 +0000
Subject: Re:  [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416200840.GC3282@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net>, [2007-04-16 12:53 -0700]:
>  From: Emanuele Rocca <ema@debian.org>
>  Date: Mon, 16 Apr 2007 21:49:58 +0200
>  
>  > Exactly, blank screen after 'Booting Linux...'.
>  
>  I have no idea what's going wrong then, and this kind of
>  but I can't really work on without physical access to
>  the system sorry.  I really need to be in front of the
>  computer having this issue and do a lot of test boots
>  and debug statment frobbing to try and figure it out.

Want to come to Italy? :-)

BTW, we had reports from Debian users that ran into this bug also on
ultra10, and I guess every machine with a Creator 3D card is affected.

Nothing critical, though, given that with atyfb:off everything works
properly.

>  > And the following messages, which didn't come out booting without atyfb:
>  > 
>  > ioctl32(Xorg:4222): Unknown cmd fd(6) cmd(40584606){00} arg(fffd5a4c) on /dev/fb0
>  > ioctl32(Xorg:4222): Unknown cmd fd(6) cmd(40184600){00} arg(fffd5a54) on /dev/fb0
>  
>  That's normal and comes from the X server.
>  
>  If the X server doesn't bring up your screen 

X works pretty well.

>  What kernel version was that?

2.6.21-rc6

ciao,
    ema
