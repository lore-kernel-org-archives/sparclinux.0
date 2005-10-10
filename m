From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 20:38:51 +0000
Subject: Re: Oops while shutdown on serial console
Message-Id: <20051010.133851.109074767.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <diech22mm0@ds9.argh.org>
In-Reply-To: <diech22mm0@ds9.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 22:26:17 +0200 (CEST)

> Um 13:11 Uhr am 10.10.05 schrieb David S. Miller:
> 
> >> The same question applies to the bug I sent the patch earlier, 
> > Specific to sparc64 systems using iptables and having discontiguous
> > physical cpu numbers.
> 
> Huh? I think you mixed this one up. I meant the one-line fix which 
> included asm/io.h into irq.c for readb()/writeb(). 

Most configurations usually get the asm/io.h file indirectly
by other includes, which is probably why others have not hit
it before.
