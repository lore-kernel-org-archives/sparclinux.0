From: David Miller <davem@davemloft.net>
Date: Wed, 07 Jan 2009 23:30:05 +0000
Subject: Re: hardirq.h removal broke sparc64 build...
Message-Id: <20090107.153005.136649913.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090107.144310.79937111.davem@davemloft.net>
	<20090107145822.625960f2.akpm@linux-foundation.org>
In-Reply-To: <20090107145822.625960f2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, rmk+kernel@arm.linux.org.uk, adobriyan@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 7 Jan 2009 14:58:22 -0800

> On Wed, 07 Jan 2009 14:43:10 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
>=20
> > I've spent most of last night and this morning trying to figure out
> > a way to fix this, it is very non-trivial.
> >=20
> > Adding a simple asm/cpudata.h include into asm/topology_64.h for the
> > SMP case does not work.
> >=20
> > asm/cpudata.h brings in percpu.h which wants SLAB which wants to use
> > GFP_* values and thus includes gfp.h
> >=20
> > And thus because of the include loop:
 ...
> > we can't include asm/cpudata.h into asm/topology.h otherwise
> > we get:
 ...
> > for the drivers/base/topology.o build failure case above.
>=20
> yes, there were some nasty problems like that.  In several cases we wimped
> out and added the necessary includes to the .c file.  Will that (sad hack)
> work here?

Ok, this works.

Linus, please apply, thanks!

topology: Fix sparc64 build.

Due to changeset ba84be2338d3a2b6020d39279335bb06fcd332e1
("remove linux/hardirq.h from asm-generic/local.h") the
sparc64 build started failing on drivers/base/topology.c:

drivers/base/topology.c: In function =E2=80=98show_physical_package_id=E2=
=80=99:
drivers/base/topology.c:103: error: implicit declaration of function =E2=80=
=98cpu_data=E2=80=99
drivers/base/topology.c:103: error: request for member =E2=80=98proc_id=E2=
=80=99 in something not a structure or union
drivers/base/topology.c: In function =E2=80=98show_core_id=E2=80=99:
drivers/base/topology.c:106: error: request for member =E2=80=98core_id=E2=
=80=99 in something not a structure or union

Adding the obvious fix of including asm/cpudata.h into
asm/topology.h on sparc64 doesn't fix it, in fact it
makes things worse because of the header file dependency
chain:

	linux/gfp.h --> linux/mmzone.h --> linux/topology.h -->
	asm/topology.h --> asm/cpudata.h --> linux/percpu.h -->
	linux/slab.h

which results in:

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

The simplest thing to do is to add yet another one-off hack like
parts of the guilty changeset did, by putting an explicit
linux/hardirq.h include into drivers/base/topology.c

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index a8bc1cb..a778fb5 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/hardirq.h>
 #include <linux/topology.h>
=20
 #define define_one_ro(_name) 		\
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
