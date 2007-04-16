From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 20:19:04 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416.131904.21926815.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Emanuele Rocca <ema@debian.org>
Date: Mon, 16 Apr 2007 22:08:40 +0200

> * David Miller <davem@davemloft.net>, [2007-04-16 12:53 -0700]:
> >  From: Emanuele Rocca <ema@debian.org>
> >  Date: Mon, 16 Apr 2007 21:49:58 +0200
> >  
> >  > Exactly, blank screen after 'Booting Linux...'.
> >  
> >  I have no idea what's going wrong then, and this kind of
> >  but I can't really work on without physical access to
> >  the system sorry.  I really need to be in front of the
> >  computer having this issue and do a lot of test boots
> >  and debug statment frobbing to try and figure it out.
> 
> Want to come to Italy? :-)
> 
> BTW, we had reports from Debian users that ran into this bug also on
> ultra10, and I guess every machine with a Creator 3D card is affected.
> 
> Nothing critical, though, given that with atyfb:off everything works
> properly.

So the source of the problem is that there is a creatorFB
card and an atyfb in the same machine?

Probably you have a screen showing on the creatorFB :-)
