From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 12 Sep 2005 20:41:22 +0000
Subject: Re: [Aurora-sparc-devel] [2.6.13-rc6-git13/sparc64]: Slab
Message-Id: <20050912.134122.54246336.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
	<1126536316.25031.66.camel@localhost.localdomain>
In-Reply-To: <1126536316.25031.66.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tcallawa@redhat.com
Cc: aurora-sparc-devel@lists.auroralinux.org, linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 12 Sep 2005 09:45:16 -0500

> We've been seeing this intermittently on arthur since Aurora 1.0 (2.4).

That's amazing given that half of those SLAB functions in
the backtrace simply do not exist in 2.4.x :-)  Can you quote
a 2.4.x version of such a backtrace?  Thanks a lot.
