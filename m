From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Oct 2009 17:06:15 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <fa686aa40910151006k43b07c30q1e43c3b1ae4af561@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
	<20091015120007.3780c59b.sfr@canb.auug.org.au>
In-Reply-To: <20091015120007.3780c59b.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

On Wed, Oct 14, 2009 at 7:00 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Grant,
>
> On Tue, 06 Oct 2009 22:29:57 -0600 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>
>> Well, I've got to start somewhere...
>>
>> So here goes. =A0I've begun the work to merge and clean up the OF device
>> tree handling code and this is my first set of patches. =A0Not fully
>> tested yet, but I'm getting them out to the lists so that I can start
>> responding to comments and collecting acks. =A0This first batch isn't
>> anything exciting, just a merge of common code
>
> This all looks OK to me. =A0One thing: =A0I started in this as well some =
time
> ago and in my attempt I was hoping to avoid the ARCH ifdefs in linux/of.h
> by creating asm/of.h and moving the differing bits in there ...

Thanks Stephen.

At the moment I'm purposefully experimenting with doing arch #ifdefs
in the hope that it will lead to obvious places where the code can be
generalized even further.  I'll see how it looks before I commit down
that path though.

In the mean time, I've pushed out the current series with acked-bys
added to my git server.  I think I'm ready for things to start going
into linux-next.  Since this is the first time I've asked for a tree
to be added to linux-next, please let me know if you see anything
troublesome or problematic.  Here's the tree:

The following changes since commit 4bdf0bb7d64cf672199519b3d808e2a82f5b59e9:
  Grant Likely (1):
        powerpc/5200: Update defconfigs

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 next-devicetree

Grant Likely (12):
      of: Rework linux/of.h and asm/prom.h include ordering
      of: merge phandle, ihandle and struct property
      of: merge struct device_node
      of: Move OF_IS_DYNAMIC and OF_MARK_DYNAMIC macros to of.h
      of: add common header for flattened device tree representation
      of: merge struct boot_param_header from Microblaze and PowerPC
      of: merge of_node_*_flag() and set_node_proc_entry()
      of: merge of_read_number() an of_read_ulong()
      of: merge of_node_get(), of_node_put() and of_find_all_nodes()
      of: merge of_*_flat_dt*() functions
      of: merge other miscellaneous prototypes
      of: merge of_find_all_nodes() implementations

 arch/microblaze/include/asm/prom.h |  135 +--------------------------------
 arch/microblaze/kernel/head.S      |    2 +-
 arch/microblaze/kernel/prom.c      |   23 ------
 arch/powerpc/include/asm/prom.h    |  147 +-------------------------------=
----
 arch/powerpc/kernel/prom.c         |   23 ------
 arch/sparc/include/asm/prom.h      |   55 +-------------
 drivers/of/base.c                  |   26 ++++++-
 include/linux/of.h                 |  103 +++++++++++++++++++++++++
 include/linux/of_fdt.h             |   86 +++++++++++++++++++++
 9 files changed, 221 insertions(+), 379 deletions(-)
 create mode 100644 include/linux/of_fdt.h


> I'll send out the two patches I did just to show what I mean (these are
> from before microblaze was using the OF stuff).

Got them, thanks.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
