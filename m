From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 09 Oct 2009 06:35:34 +0000
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device
Message-Id: <20091009063534.GC12948@yookeroo.seuss>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
In-Reply-To: <20091007043052.16890.15975.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Tue, Oct 06, 2009 at 10:30:59PM -0600, Grant Likely wrote:
> Add a common header file for working with the flattened device tree
> data structure and merge the shared data tags used by Microblaze and
> PowerPC
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/microblaze/include/asm/prom.h |   12 +-----------
>  arch/powerpc/include/asm/prom.h    |   12 +-----------
>  include/linux/of_fdt.h             |   30 ++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/of_fdt.h
> 
> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
> index 64e8b3a..5f461f0 100644
> --- a/arch/microblaze/include/asm/prom.h
> +++ b/arch/microblaze/include/asm/prom.h
> @@ -17,20 +17,10 @@
>  #ifndef _ASM_MICROBLAZE_PROM_H
>  #define _ASM_MICROBLAZE_PROM_H
>  #ifdef __KERNEL__
> -
> -/* Definitions used by the flattened device tree */
> -#define OF_DT_HEADER		0xd00dfeed /* marker */
> -#define OF_DT_BEGIN_NODE	0x1 /* Start of node, full name */
> -#define OF_DT_END_NODE		0x2 /* End node */
> -#define OF_DT_PROP		0x3 /* Property: name off, size, content */
> -#define OF_DT_NOP		0x4 /* nop */
> -#define OF_DT_END		0x9
> -
> -#define OF_DT_VERSION		0x10


So, if you're merging all these, I guess the question is do we also
want to merge them with scripts/dtc/libfdt/fdt.h, and by extension
with the upstream libfdt header file which defines the same things.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
