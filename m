From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 05:23:09 +0000
Subject: Re: new parport_pc BUG
Message-Id: <20070728.222309.71090726.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 28 Jul 2007 11:55:13 +0300 (EEST)

> > This patch is big, but this transformation has been pending for
> > a long time, and I tested that parport_pc works on my ultra5.
> > 
> > Can you test it for me?
> 
> Floppy does not compile, seems to depend on some PCI header?

Please test with floppy disabled, I'll deal with that build
failure seperately.
