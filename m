From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 00:24:03 +0000
Subject: Re: [PATCH] Sun/Solaris VTOC table corrections
Message-Id: <20070725.172403.23043798.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707251742000.20510@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 26 Jul 2007 01:15:51 +0100 (BST)

> OK This one is easy as the VTOC structure is only used in 
> fs/partions/msdos.c and the parts that get moved by changing the number 
> of slices are not used yet (v2.6.22). I have attached a patch.

Doesn't apply to 2.6.23-rc1, can you rediff for me and kill
the trailing whitespace on the line with the comment you
added?

Thanks.
