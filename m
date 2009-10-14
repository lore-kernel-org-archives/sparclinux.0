From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 14 Oct 2009 04:47:07 +0000
Subject: Re: [RFC PATCH 05/12] of: add common header for flattened device
Message-Id: <20091014044707.GA3952@yookeroo.seuss>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043052.16890.15975.stgit@angua>
	<20091009063534.GC12948@yookeroo.seuss>
	<fa686aa40910090007lef3fddbod0c5843abfe33be5@mail.gmail.com>
In-Reply-To: <fa686aa40910090007lef3fddbod0c5843abfe33be5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Fri, Oct 09, 2009 at 01:07:57AM -0600, Grant Likely wrote:
> On Fri, Oct 9, 2009 at 12:35 AM, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> > On Tue, Oct 06, 2009 at 10:30:59PM -0600, Grant Likely wrote:
> >> Add a common header file for working with the flattened device tree
> >> data structure and merge the shared data tags used by Microblaze and
> >> PowerPC
> >>
> >> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >> ---
> >>
> >> =A0arch/microblaze/include/asm/prom.h | =A0 12 +-----------
> >> =A0arch/powerpc/include/asm/prom.h =A0 =A0| =A0 12 +-----------
> >> =A0include/linux/of_fdt.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 30 +++++++++++=
+++++++++++++++++++
> >> =A03 files changed, 32 insertions(+), 22 deletions(-)
> >> =A0create mode 100644 include/linux/of_fdt.h
> >>
> >> diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/incl=
ude/asm/prom.h
> >> index 64e8b3a..5f461f0 100644
> >> --- a/arch/microblaze/include/asm/prom.h
> >> +++ b/arch/microblaze/include/asm/prom.h
> >> @@ -17,20 +17,10 @@
> >> =A0#ifndef _ASM_MICROBLAZE_PROM_H
> >> =A0#define _ASM_MICROBLAZE_PROM_H
> >> =A0#ifdef __KERNEL__
> >> -
> >> -/* Definitions used by the flattened device tree */
> >> -#define OF_DT_HEADER =A0 =A0 =A0 =A0 0xd00dfeed /* marker */
> >> -#define OF_DT_BEGIN_NODE =A0 =A0 0x1 /* Start of node, full name */
> >> -#define OF_DT_END_NODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2 /* End node */
> >> -#define OF_DT_PROP =A0 =A0 =A0 =A0 =A0 0x3 /* Property: name off, siz=
e, content */
> >> -#define OF_DT_NOP =A0 =A0 =A0 =A0 =A0 =A00x4 /* nop */
> >> -#define OF_DT_END =A0 =A0 =A0 =A0 =A0 =A00x9
> >> -
> >> -#define OF_DT_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x10
> >
> >
> > So, if you're merging all these, I guess the question is do we also
> > want to merge them with scripts/dtc/libfdt/fdt.h, and by extension
> > with the upstream libfdt header file which defines the same things.
>=20
> I see your question and raise you another.  Where should the merge
> file live for it to be included both by dtc and kernel code? Or should
> it just be cloned in the kernel tree?

Yeah, a good question.  As I see it there are two options.  Number one
is just make sure everything relevant that the kernel needs is in the
libfdt version, then just have the kernel code reference it from its
location in scripts/dtc.  Other option is we clone the file in the
kernel tree.  Requires keeping in sync, in theory at least, but since
that file has been pretty static (since it's only supposed to contain
passive structures/constants related to the physical flat tree
structure - no code or prototypes).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
