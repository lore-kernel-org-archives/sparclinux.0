From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 19:53:51 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416.125351.115910586.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Emanuele Rocca <ema@debian.org>
Date: Mon, 16 Apr 2007 21:49:58 +0200

> Exactly, blank screen after 'Booting Linux...'.

I have no idea what's going wrong then, and this kind of
but I can't really work on without physical access to
the system sorry.  I really need to be in front of the
computer having this issue and do a lot of test boots
and debug statment frobbing to try and figure it out.

> And the following messages, which didn't come out booting without atyfb:
> 
> ioctl32(Xorg:4222): Unknown cmd fd(6) cmd(40584606){00} arg(fffd5a4c) on /dev/fb0
> ioctl32(Xorg:4222): Unknown cmd fd(6) cmd(40184600){00} arg(fffd5a54) on /dev/fb0

That's normal and comes from the X server.

If the X server doesn't bring up your screen either, something
is very very wrong with your graphics card which makes it even
less likely that the kernel driver can be fixed too.

Did this graphics card really ever work properly?  What kernel
version was that?
