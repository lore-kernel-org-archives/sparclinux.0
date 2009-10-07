From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 13:41:20 +0000
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device tree
Message-Id: <fa686aa40910070641g561ec833vf1cf1a0e098cdbe6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
	<1254892467.6035.273.camel@pasglop>
In-Reply-To: <1254892467.6035.273.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, Oct 6, 2009 at 11:14 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-10-06 at 22:30 -0600, Grant Likely wrote:
>
>> --- /dev/null
>> +++ b/include/linux/of_fdt.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * Definitions for working with the Flattened Device Tree data format
>> + *
>> + * Copyright (C) 1996-2005 Paul Mackerras.
>> + *
>> + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
>> + * Updates for SPARC by David S. Miller
>> + * Merged to common code by Grant Likely
>
> I think you should prune the above. Make it (c) myself since I wrote the
> FDT code initially. You can add back (c) of other people as you add more
> stuff here I suppose.
>
> No big deal tho.

No problem.  What is the exact copyright text that you'd like to see
here?  I'm not going to guess on other people's copyright notice.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
