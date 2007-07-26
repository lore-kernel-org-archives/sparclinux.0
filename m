From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 01:55:31 +0000
Subject: Re: [PATCH] Add 82077 FDC to sun4c
Message-Id: <20070725.185531.26305564.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251659420.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251659420.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 02:48:53 +0100 (BST)

> I do not have data sheets for the 82072A and the 82077 (pre-1991), only a 
> data sheet for the 82077A, so if the spurious interrupts need to be fixed, 
> I will have to do it by trial and error using the data sheet as a guide as 
> to what I should be seeing.

I've found the openbsd sparc floppy driver to be a good guide.
