From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 07 Oct 2005 05:12:40 +0000
Subject: Re: [PATCH 2.6] sparc32 unresolved symbols
Message-Id: <20051006.221240.81151515.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1128605659.2140.127.camel@localhost.localdomain>
In-Reply-To: <1128605659.2140.127.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 08:34:19 -0500

> (The sym53c8xx driver is used for the SPARCStation 2)

SparcStation 2 is sun4c and SBUS, so there is no way this PCI driver
is needed there. :-)

> Not terribly difficult to fix, patch attached.
> 
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

I think it's better to write a sparc specific version in
the end.  A lot of the PIO gunk in lib/iomap.c might not be
appropriate on sparc32.

But for now I'll apply your patch, thanks.
