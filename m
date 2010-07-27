From: David Miller <davem@davemloft.net>
Date: Tue, 27 Jul 2010 01:38:08 +0000
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
Message-Id: <20100726.183808.15223674.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
	<20100726.154854.35052662.davem@davemloft.net>
	<AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z@mail.gmail.com>
In-Reply-To: <AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 16:51:01 -0600

> Indeed.  I looked at it briefly, but it wasn't immediately clear what
> the impact would be to switch powerpc over to -1, and it looked to me
> like sparc depends on -1 to signify no node association.

Kernel wide, NUMA interfaces tend to take "-1" to mean "any node."

I had looked over the powerpc cases, and besides 1 or 2 strange
locations the powerpc call sites were ready to handle -1.
