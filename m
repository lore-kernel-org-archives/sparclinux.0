From: David Miller <davem@davemloft.net>
Date: Wed, 07 Jan 2009 22:43:10 +0000
Subject: hardirq.h removal broke sparc64 build...
Message-Id: <20090107.144310.79937111.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: rmk+kernel@arm.linux.org.uk
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


[ Andrew, read carefully, I think some part of a patch you
  merged might have been lost while reshuffling or whatever. ]

This change:

commit ba84be2338d3a2b6020d39279335bb06fcd332e1
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Tue Jan 6 14:41:07 2009 -0800

    remove linux/hardirq.h from asm-generic/local.h

broke the build on sparc64:

drivers/base/topology.c: In function =E2=80=98show_physical_package_id=E2=
=80=99:
drivers/base/topology.c:103: error: implicit declaration of function =E2=80=
=98cpu_data=E2=80=99
drivers/base/topology.c:103: error: request for member =E2=80=98proc_id=E2=
=80=99 in something not a structure or union
drivers/base/topology.c: In function =E2=80=98show_core_id=E2=80=99:
drivers/base/topology.c:106: error: request for member =E2=80=98core_id=E2=
=80=99 in something not a structure or union

Even though there is a footnote there from Alexey saying that
sparc64 was fixed up :-)

    [adobriyan@gmail.com: fix sparc64]

I've spent most of last night and this morning trying to figure out
a way to fix this, it is very non-trivial.

Adding a simple asm/cpudata.h include into asm/topology_64.h for the
SMP case does not work.

asm/cpudata.h brings in percpu.h which wants SLAB which wants to use
GFP_* values and thus includes gfp.h

And thus because of the include loop:

	linux/gfp.h --> linux/mmzone.h --> linux/topology.h -->
	asm/topology.h --> asm/cpudata.h --> linux/percpu.h -->
	linux/slab.h

we can't include asm/cpudata.h into asm/topology.h otherwise
we get:

include/linux/slub_def.h: In function =E2=80=98kmalloc_large=E2=80=99:
include/linux/slub_def.h:209: error: implicit declaration of function =E2=
=80=98__get_free_pages=E2=80=99
include/linux/slub_def.h:209: error: =E2=80=98__GFP_COMP=E2=80=99 undeclare=
d (first use in this function)
include/linux/slub_def.h:209: error: (Each undeclared identifier is reporte=
d only once
include/linux/slub_def.h:209: error: for each function it appears in.)
include/linux/slub_def.h:209: warning: cast to pointer from integer of diff=
erent size

for the drivers/base/topology.o build failure case above.

Actually, looking at the patch, where is the part from Alexey
that does the "fix sparc64"?  I see nothing in the patch that
would even appear to possibly be for that.  The diffstat is:

 arch/avr32/kernel/traps.c     |    1 +
 arch/sh/kernel/traps_32.c     |    1 +
 drivers/acpi/processor_idle.c |    1 +
 include/asm-generic/local.h   |    1 -
 4 files changed, 3 insertions(+), 1 deletion(-)

Was Alexey's fix removed or lost? :-/
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
