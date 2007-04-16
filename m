From: Emanuele Rocca <ema@debian.org>
Date: Mon, 16 Apr 2007 21:16:51 +0000
Subject: Re:  [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416211651.GA4884@darkmoon.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

* David Miller <davem@davemloft.net>, [2007-04-16 13:19 -0700]:
>  From: Emanuele Rocca <ema@debian.org>
>  Date: Mon, 16 Apr 2007 22:08:40 +0200
>  > BTW, we had reports from Debian users that ran into this bug also on
>  > ultra10, and I guess every machine with a Creator 3D card is affected.
>  > 
>  > Nothing critical, though, given that with atyfb:off everything works
>  > properly.
>  
>  So the source of the problem is that there is a creatorFB
>  card and an atyfb in the same machine?
>  
>  Probably you have a screen showing on the creatorFB :-)

LOL, I've tried to actually connect my monitor to the atyfb and that was
really helpful. :-)

So, using the creatorFB I see Openboot and the silo prompt; after that,
the control goes to the atyfb card (which without a monitor can do
little).

Conversely, using the atyfb card there's no openboot (and no X, given
that I've configured it only for the creator) but the console shows up
just fine. :-)

ciao,
    ema
