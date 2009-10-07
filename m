From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Oct 2009 05:14:27 +0000
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device
Message-Id: <1254892467.6035.273.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
In-Reply-To: <20091007043052.16890.15975.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, 2009-10-06 at 22:30 -0600, Grant Likely wrote:

> --- /dev/null
> +++ b/include/linux/of_fdt.h
> @@ -0,0 +1,30 @@
> +/*
> + * Definitions for working with the Flattened Device Tree data format
> + *
> + * Copyright (C) 1996-2005 Paul Mackerras.
> + *
> + * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
> + * Updates for SPARC by David S. Miller
> + * Merged to common code by Grant Likely

I think you should prune the above. Make it (c) myself since I wrote the
FDT code initially. You can add back (c) of other people as you add more
stuff here I suppose.

No big deal tho.

Ben.

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _LINUX_OF_FDT_H
> +#define _LINUX_OF_FDT_H
> +
> +/* Definitions used by the flattened device tree */
> +#define OF_DT_HEADER		0xd00dfeed	/* marker */
> +#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
> +#define OF_DT_END_NODE		0x2		/* End node */
> +#define OF_DT_PROP		0x3		/* Property: name off, size,
> +						 * content */
> +#define OF_DT_NOP		0x4		/* nop */
> +#define OF_DT_END		0x9
> +
> +#define OF_DT_VERSION		0x10
> +
> +#endif /* _LINUX_OF_FDT_H */


