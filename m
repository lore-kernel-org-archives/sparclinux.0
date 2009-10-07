From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:49:04 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, microblaze-uclin

On Tue, Oct 6, 2009 at 10:29 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Well, I've got to start somewhere...
>
> So here goes. =A0I've begun the work to merge and clean up the OF device
> tree handling code and this is my first set of patches. =A0Not fully
> tested yet, but I'm getting them out to the lists so that I can start
> responding to comments and collecting acks. =A0This first batch isn't
> anything exciting, just a merge of common code

Shoot.... most of what I wrote got trimmed accidentally.  Here's the
rest of the text:

However, I've completely devoted to this work for at least the next
two months, so there are plenty more patches to follow.  Once I've
got all the common code merged between Microblaze, PowerPC and Sparc
I'll be fix the endian problems and making it easily usable by other
architectures like ARM and MIPS.  Lots of work to be done.

As for merging this stuff, because the patches cross architecture
boundaries, I've been thinking of publishing a new git tree for
collecting device tree related changes and getting it added to the
linux-next tree list.  I'll commit changes to that tree once I get
acks from each of the affected arch maintainers.  Then, either Linus
can pull my tree directly, or I could ask a more senior maintainer
to pull into their tree before sending a pull request to Linus.  Ben,
David and Michal, how does that sound to you?  Stephen, would you be
willing to add my tree to the linux-next list?

Also, I'd like to take on responsibility for maintaining the cross-
architecture device tree code.  If there are no objections, I'll
write a patch to add a device tree section to MAINTAINERS.

Cheers,
g.

> ---
>
> Grant Likely (12):
> =A0 =A0 =A0of: merge of_find_all_nodes() implementations
> =A0 =A0 =A0of: merge other miscellaneous prototypes
> =A0 =A0 =A0of: merge of_*_flat_dt*() functions
> =A0 =A0 =A0of: merge of_node_get(), of_node_put() and of_find_all_nodes()
> =A0 =A0 =A0of: merge of_read_number() an of_read_ulong()
> =A0 =A0 =A0of: merge of_node_*_flag() and set_node_proc_entry()
> =A0 =A0 =A0of: merge struct boot_param_header from Microblaze and PowerPC
> =A0 =A0 =A0of: add common header for flattened device tree representation
> =A0 =A0 =A0of: Move OF_IS_DYNAMIC and OF_MARK_DYNAMIC macros to of.h
> =A0 =A0 =A0of: merge struct device_node
> =A0 =A0 =A0of: merge phandle, ihandle and struct property
> =A0 =A0 =A0of: Rework linux/of.h and asm/prom.h include ordering
>
>
> =A0arch/microblaze/include/asm/prom.h | =A0135 +-------------------------=
-------
> =A0arch/microblaze/kernel/prom.c =A0 =A0 =A0| =A0 23 ------
> =A0arch/powerpc/include/asm/prom.h =A0 =A0| =A0147 ----------------------=
--------------
> =A0arch/powerpc/kernel/prom.c =A0 =A0 =A0 =A0 | =A0 23 ------
> =A0arch/sparc/include/asm/prom.h =A0 =A0 =A0| =A0 55 -------------
> =A0drivers/of/base.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 26 ++++++
> =A0include/linux/of.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0103 ++++++++++=
+++++++++++++++
> =A0include/linux/of_fdt.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 87 ++++++++++++++=
+++++++
> =A08 files changed, 221 insertions(+), 378 deletions(-)
> =A0create mode 100644 include/linux/of_fdt.h
