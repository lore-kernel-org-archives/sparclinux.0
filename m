From: David Miller <davem@davemloft.net>
Date: Wed, 22 Aug 2007 20:39:32 +0000
Subject: Re: sun4v oops
Message-Id: <20070822.133932.132926696.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1187814718.3439.350.camel@dhcp83-165.boston.redhat.com>
In-Reply-To: <1187814718.3439.350.camel@dhcp83-165.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Aug 2007 16:31:58 -0400

> Got this oops with the attached config very quickly after init, threw me
> back to the prom. Firmware is fully updated on the box, latest SILO too.
> 
> Starting udev: OOPS: Bogus kernel PC [0000000000000000] in fault handler
> OOPS: RPC [0000000000477aa4]
> OOPS: Fault was to vaddr[f7f22000]

Something jumped to address zero.

This happened at address 0x477aa4, find out where that is.

Also, if you're using gcc-4.2.x for kernel builds, don't.
There is a miscompile, that others have run into, which
I have tracked down and am trying to build a test case
for so the gcc folks can look at and hopefully fix it.

I don't anticipate really making a lot of progress on the
gcc-4.2.x bug until way after Kernel Summit in September.
