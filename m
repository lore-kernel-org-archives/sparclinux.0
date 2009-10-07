From: David Miller <davem@davemloft.net>
Date: Wed, 07 Oct 2009 21:09:38 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091007.140938.255120957.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007135243.GC21646@anhedonia> <4ACCEC67.9070106@firmworks.com>
	<Pine.LNX.4.60.0910072148040.11795@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.60.0910072148040.11795-pb599fR3TxWvwYtD5Hs6llaTQe2KTcn/@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: crn-Tjka5CH3XzFBDgjK7y7TUQ@public.gmane.org
Cc: sammy-4OGMY2YDKIVeoWH0uzbU5w@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

From: Chris Newport <crn@netunix.com>
Date: Wed, 7 Oct 2009 21:54:34 +0100 (BST)

> Sun4c has also been broken for a long time and sun4d has never worked
> properly. Is it time to also prune these ?.
> That would leave only Sun4m in the 32bit kernel, which still works and
> has plenty of ongoing user interest.

Chris don't over-exaggerate the state.

The truth is that the whole sparc32 port is in a state of mild
disrepair, and many of the issues apply to all the port rather than
just one family of systems.  I think someone suitably motivated
could get most of the bugs sorted out.

There is no reason to drop support for SS1 machines, we already fully
build the software device tree and use all of the generic OF
infrastructure in the Linux kernel on those systems.  It is not a road
block at all for the OF genericization work, if that's what you read
into wmb's email.
