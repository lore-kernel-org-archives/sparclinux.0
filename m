From: David Miller <davem@davemloft.net>
Date: Thu, 08 Oct 2009 04:39:15 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091007.213915.37481688.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
	<20091007.140938.255120957.davem@davemloft.net>
	<Pine.LNX.4.60.0910080155210.12519@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.60.0910080155210.12519-pb599fR3TxWvwYtD5Hs6llaTQe2KTcn/@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: crn-Tjka5CH3XzFBDgjK7y7TUQ@public.gmane.org
Cc: sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

From: Chris Newport <crn@netunix.com>
Date: Thu, 8 Oct 2009 02:29:25 +0100 (BST)

> Sun4d has never had SMP support and

Wrong.

> this is apparantly problematic due to Cray interlectual property
>  causing a lack of bus documentation.

XBUS documentation is not available, but we fully know how to
program the SBUS interrupt controller and whatnot.  It's all
there in the sun4d interrupt and SMP support and it did work
just fine at one point.

Amusingly the SBUS interrupt stuff on sun4d is a very close
sibling to the IMAP/ICLR scheme used on sun4u.
