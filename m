From: David Miller <davem@davemloft.net>
Date: Wed, 10 Jul 2013 20:49:45 +0000
Subject: Re: [PATCH] SPARC32 : vm_area_struct access for old Sun SPARCs
Message-Id: <20130710.134945.2233713889634072023.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <51D745AC.5020607@caramail.com>
In-Reply-To: <51D745AC.5020607@caramail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Olivier Danet <odanet@caramail.com>
Date: Sat, 06 Jul 2013 00:16:12 +0200

> Here is a fix for a problem signalled by Rob Landley on the QEMU
> mailing list :
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2013-06/msg05013.html
> 
> The bug is present since Linux 3.8.

Your patch was severely corrupted by your email client, amongst other
things it turned all TAB characters into spaces.  It also chopped up
long line.

I applied the patch by hand, but next time I'm going to push this patch
back to you and you will need to properly submit it unmolested.

Thanks.
