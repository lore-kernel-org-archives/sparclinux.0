From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Thu, 07 Oct 2004 18:22:38 +0000
Subject: Linux prom mmu mapping expectations?
Message-Id: <BAY12-F40FRaqbC8wSA0001e56f@hotmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

What kind of memory mappings Linux expects from Prom side?

Background: I've been trying to get Qemu run Linux 2.6.8.1 for sparc32, but=
=20
currently there is a MMU fault at srmmu_early_allocate_ptable_skeleton.  Th=
e=20
code in question is as follows:
0xf00fdec4:  ldd  [ %o1 + -64 ], %g2
0xf00fdec8:  ldd  [ %o1 + -56 ], %g4
0xf00fdecc:  st  %g2, [ %o0 + -64 ]
0xf00fded0:  st  %g3, [ %o0 + -60 ]
0xf00fded4:  st  %g4, [ %o0 + -56 ]
0xf00fded8:  st  %g5, [ %o0 + -52 ]
0xf00fdedc:  ldd  [ %o1 + -48 ], %g2
0xf00fdee0:  ldd  [ %o1 + -40 ], %g4

This code is in memcpy, but I can't find where it is called from in the=20
function (srmmu_early_allocate_ptable_skeleton, srmmu.c).

The faulting address is 0xf00fdec4, %o1 is 0xf0000000. There is no MMU=20
mapping at the address. I tried adding some code into Proll to map the area=
,=20
but that didn't help.

Any clues, please?

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*.=20
http://join.msn.com/?page=FEatures/featuredemail

