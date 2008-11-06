From: David Miller <davem@davemloft.net>
Date: Thu, 06 Nov 2008 04:10:30 +0000
Subject: Re: sparc boot failure
Message-Id: <20081105.201030.50705571.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49125E98.8070905@earthlink.net>
In-Reply-To: <49125E98.8070905@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 05 Nov 2008 22:03:52 -0500

> sparc has failed to boot recently and I bisected it down to this patch:
 ...
>  sparc: correct section of current_pc()
 ...
> Reverting this patch gets current git booting again.

Thanks for tracking this down.  I'll take a look and if I
can't figure it out I'll revert.
