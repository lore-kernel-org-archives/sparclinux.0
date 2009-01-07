From: David Miller <davem@davemloft.net>
Date: Wed, 07 Jan 2009 22:30:52 +0000
Subject: mainline build failure...
Message-Id: <20090107.143052.13764119.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


Just FYI, I'm currently trying to resolve a build failure
that was introduced in the past 24 hours in Linus's tree
for sparc64:

  CC      drivers/base/topology.o
drivers/base/topology.c: In function =E2=80=98show_physical_package_id=E2=
=80=99:
drivers/base/topology.c:103: error: implicit declaration of function =E2=80=
=98cpu_data=E2=80=99
drivers/base/topology.c:103: error: request for member =E2=80=98proc_id=E2=
=80=99 in something not a structure or union
drivers/base/topology.c: In function =E2=80=98show_core_id=E2=80=99:
drivers/base/topology.c:106: error: request for member =E2=80=98core_id=E2=
=80=99 in something not a structure or union
make[1]: *** [drivers/base/topology.o] Error 1
make: *** [drivers/base/topology.o] Error 2

It's not simple to fix this, the "easy" idea to simply include
asm/cpudata.h into asm/topology_64.h for the SMP case doesn't work
at all:

  CC      drivers/base/topology.o
In file included from include/linux/slab.h:152,
                 from include/linux/percpu.h:5,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
cpudata_64.h:14,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
cpudata.h:4,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
topology_64.h:78,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
topology.h:4,
                 from include/linux/topology.h:34,
                 from include/linux/mmzone.h:763,
                 from include/linux/gfp.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from include/linux/sysdev.h:25,
                 from drivers/base/topology.c:26:
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
In file included from include/linux/percpu.h:5,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
cpudata_64.h:14,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
cpudata.h:4,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
topology_64.h:78,
                 from /home/davem/src/GIT/sparc-2.6/arch/sparc/include/asm/=
topology.h:4,
                 from include/linux/topology.h:34,
                 from include/linux/mmzone.h:763,
                 from include/linux/gfp.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from include/linux/sysdev.h:25,
                 from drivers/base/topology.c:26:
include/linux/slab.h: In function =E2=80=98kcalloc=E2=80=99:
include/linux/slab.h:214: error: =E2=80=98__GFP_ZERO=E2=80=99 undeclared (f=
irst use in this function)
include/linux/slab.h: In function =E2=80=98kmem_cache_zalloc=E2=80=99:
include/linux/slab.h:295: error: =E2=80=98__GFP_ZERO=E2=80=99 undeclared (f=
irst use in this function)
include/linux/slab.h: In function =E2=80=98kzalloc=E2=80=99:
include/linux/slab.h:305: error: =E2=80=98__GFP_ZERO=E2=80=99 undeclared (f=
irst use in this function)
include/linux/slab.h: In function =E2=80=98kzalloc_node=E2=80=99:
include/linux/slab.h:316: error: =E2=80=98__GFP_ZERO=E2=80=99 undeclared (f=
irst use in this function)
In file included from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from include/linux/sysdev.h:25,
                 from drivers/base/topology.c:26:
include/linux/gfp.h: At top level:
include/linux/gfp.h:222: error: conflicting types for =E2=80=98__get_free_p=
ages=E2=80=99
include/linux/slub_def.h:209: error: previous implicit declaration of =E2=
=80=98__get_free_pages=E2=80=99 was here
make[1]: *** [drivers/base/topology.o] Error 1

What a mess...

Anyways, once I have this sorted I'll merge the sparc-2.6 tree with
Linus's and push that out to kernel.org
=FF=F4=E8=BA{.n=C7+=89=B7=9F=AE=89=AD=86+%=8A=CB=FF=B1=E9=DD=B6=17=A5=8Aw=
=FF=BA{.n=C7+=89=B7=AC=A5=AA=DC=96)=EE=C7=F8=A7=B6=17=9B=A1=DC=A8}=A9=9E=B2=
=C6=A0z=DA&j:+v=89=A8=FE=F8=1E=AF=F9=1E=AEw=A5=FE=8A=E02=8A=DE=99=A8=E8=AD=
=DA&=A2)=DF=A1=ABa=B6=DA=FF=FF=FB=E0z=BF=E4z=B9=DE=97=FA+=83=F9=9A=8E=8A=DD=
=A2j=FF=8Aw=E8=FE=1Bf
