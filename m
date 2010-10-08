From: David Miller <davem@davemloft.net>
Date: Fri, 08 Oct 2010 17:45:57 +0000
Subject: Re: [PATCH 1/2 v2] of: move phandle/ihandle into types.h and
Message-Id: <20101008.104557.59696706.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008171210.GE3863@angua.secretlab.ca>
	<20101008.101759.193728130.davem@davemloft.net>
	<20101008173650.GH3863@angua.secretlab.ca>
In-Reply-To: <20101008173650.GH3863-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 8 Oct 2010 11:36:50 -0600

> Weird.  Yeah, no other platforms expect to get a phandle type
> definition from the kernel headers.  The only thing driving this
> conversation is from arch/sparc/include/asm/Kbuild:
> 
> header-y += openprom.h

It was probably at one point for the sake of asm/openpromio.h but
that header has no dependencies on openprom.h

The only hit I can find in google code search, for non-kernel code, is
the SILO bootloader.

But that tree includes it's own copy of include/asm/openprom.h so
the actual kernel copy isn't even used.

I'd say we can stop exporting that header and also therefore not
worry about making phandle_t visible to userspace.


