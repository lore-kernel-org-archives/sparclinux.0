From: David Miller <davem@davemloft.net>
Date: Tue, 24 Jul 2007 21:48:44 +0000
Subject: Re: QLGC,ISP SCSI driver not finding attached devices
Message-Id: <20070724.144844.74557601.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707241758020.17959@mtfhpc.demon.co.uk>
	<20070724.124304.51855385.davem@davemloft.net>
	<Pine.LNX.4.61.0707242116370.17959@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707242116370.17959@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: James.Bottomley@SteelEye.com, sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org

From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 24 Jul 2007 22:28:42 +0100 (BST)

> I thought I rememberd seeing somthing about memset.
> 
> Having changed the memset code, I have found that the ESP scsi BUS 
> Timeout can be reverted back to 250ms. Both SCSI drivers are now working 
> properly both built in and as modules.

Thanks Mark.

What I'll do is merge in the sparc32 memset() fix then, once that is
in, send James a patch to revert the ESP bus timeout back down to 250.
