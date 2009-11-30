From: David Miller <davem@davemloft.net>
Date: Mon, 30 Nov 2009 21:05:21 +0000
Subject: Re: Boot problems on a V880
Message-Id: <20091130.130521.261909944.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Mon, 30 Nov 2009 16:02:14 -0500

> It doesn't seem that the RSC is the problem, but I have two bad slots on 
> the CPU backplane (as verified by booting this on my other V880).  That 
> V880 is installed with "2.6.26-1-sparc64" from Debian/Lenny, which 
> booted ok on this one when I cloned the disk (and pulled the CPU modules 
> from the bottom two slots).  It looks like this 2.6.32-rc3 will boot, 
> but I can't get the onboard (sungem) ethernet to work (on either 
> 2.6.26-1-sparc64 or 2.6.32-rc3).

What are the symptoms, link simply doesn't come up?

We made some fixes to link type detection in sungem recently, maybe we
need some more touchups to get it perfect.

Can you please post the output of "prtconf -pv" either from Linux or
Solaris on this machine?

Thanks.
