From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 28 Feb 2011 07:41:28 +0000
Subject: Re: [RFC PATCH 06/15] dt: xilinx_hwicap: merge platform and
Message-Id: <20110228074128.GB7855@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043405.20795.19903.stgit@localhost6.localdomain6>
	<8da12938-78ee-4a0f-b1e4-7bfac7fa16c3@VA3EHSMHS036.ehs.local>
In-Reply-To: <8da12938-78ee-4a0f-b1e4-7bfac7fa16c3-+Ck8Kgl/v09DUMyIFHz4objjLBE8jN/0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Neuendorffer <stephen.neuendorffer-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Fri, Feb 25, 2011 at 10:25:22AM -0800, Stephen Neuendorffer wrote:
> Minor nit below
> 
> Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> 
> Steve
> 
> > +#ifdef CONFIG_OF
> >  /* Match table for of_platform binding */
> 
> Does the comment still make sense?

Fixed, thanks.

