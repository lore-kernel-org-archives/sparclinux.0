From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Fri, 08 Oct 2004 16:49:04 +0000
Subject: Re: Linux prom mmu mapping expectations?
Message-Id: <BAY12-F303V5g2oHzGk00033de6@hotmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY12-F40FRaqbC8wSA0001e56f@hotmail.com>
In-Reply-To: <BAY12-F40FRaqbC8wSA0001e56f@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

>0xf0000000 is KERNBASE, and arch/sparc/kernel/head.S load mappings for the
>entire kernel image, starting at KERNBASE, into the MMU.

Thanks. I found the bug in Proll:
--- proll_18.orig/src/system.c  2002-07-23 07:52:49.000000000 +0200
+++ proll_18.min/src/system.c   2004-10-08 18:08:50.000000000 +0200
@@ -298,8 +298,8 @@
        }

        /* We need to start from LOADBASE, but kernel wants PAGE_SIZE. */
-       pa =3D PAGE_SIZE;
-       for (va =3D PAGE_SIZE; va < LOWMEMSZ; va +=3D PAGE_SIZE) {
+       pa =3D 0;
+       for (va =3D 0; va < LOWMEMSZ; va +=3D PAGE_SIZE) {
                map_page(l1, va, pa, 0, highbase);
                pa +=3D PAGE_SIZE;
        }

Now we are stuck at poke_srmmu call faulting mysteriously, even though=20
poke_srmmu is correctly initialized earlier at init_cypress_604. Kill one=20
bug, advance 500 instructions, next bug halts progress.

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8.=20
http://join.msn.com/?page=FEatures/junkmail

