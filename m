From: Jason Wever <weeve@gentoo.org>
Date: Mon, 27 Feb 2006 00:41:19 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060226174119.301f4fe7@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_5qwCeT2GBEr7y0XL.JJR7=4"
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

--Sig_5qwCeT2GBEr7y0XL.JJR7=4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Feb 2006 21:25:04 -0700
Jason Wever <weeve@gentoo.org> wrote:

> Will post an update on the original bug when I have something.

Have a bit more on the problem.  Hopefully this time its actually
useful :)

The short of what I found is to do one of the following:
- Use gcc-3.3.6 when the "Optimize for size" option is enabled
- Do not enable the "Optimize for size" option when using gcc-3.4.5

The long of it:

Tested Christoph's patch against the same tree on the Ultra 1 as the
original bug was posted against, which is running gcc-3.4.5 as a kernel
compiler.  When I did this and rebooted the box, basically all that
changed was that everything from the "BUG: spinlock already unlocked on
CPU#0, scsi_eh_0/633" line on down no longer showed up (actual text of
error with Christoph's patch in [1]).

At this point, before I went back to the "git bisect" method, I decided
to try compiling the kernel with different compilers to see if that was
the issue (since that's come up before).  Low and behold the kernel
build with gcc-3.3.6 ran fine, but the kernel built with gcc-3.4.5 did
not.

As my previous git bisect attempt had been done via building kernels on
a different box that contained gcc-3.3.6, I now ran git bisect on a box
with gcc-3.4.5.  What it appears to have boiled down to after running
git bisect and making sure I'm not running off into left field with
something else is the "[SPARC64]: Stop putting -finline-limit=3DXXX into
CFLAGS" patch from 20 Dec 2005. [2]. =20

To help confirm that this is either the issue or an issue, I rebuilt
the kernel from the same tree that caused the initial problem with
gcc-3.4.5 but this time with "Optimize for size" turned off.  Now the
kernel boots up as expected and the machine is happily updating its
portage tree as I type.

I'd be interested to see if anyone running gcc-3.4.5 on debian has
similar issues on an Ultra 1.  The model in question is an "Ultra 1
Server" running at 143 MHz on OBP 3,35.  Also be interested in hearing
how people using gcc-4.0.x make out as well (didn't have access to a
gcc-4.0.x compiler when doing this testing).

I still have the git tree at the point where I found the failure so if
you need me to pull anything from that state, just let me know.


[1] -=20
INIT: version 2.86 booting

Gentoo Linux; http://www.gentoo.org/
 Copyright 1999-2006 Gentoo Foundation; Distributed under the GPLv2
=20
 * Mounting proc
at /proc ...                                             [ ok ]
 * Mounting sysfs
at /sys ...                                             [ ok ]
 * Mounting /dev for
udev ...                                             [ ok ] esp0:
Aborting command esp0: dumping state
esp0: dma -- cond_reg<a6400311> addr<c7ffc002>
esp0: SW [sreg<13> sstep<04> ireg<10>]
esp0: HW reread [sreg<97> sstep<cc> ireg<08>]
esp0: current command [tgt<01> lun<00> pphase<STATUS> cphase<STATUS>]
esp0: disconnected
esp0: Aborting command
esp0: dumping state
esp0: dma -- cond_reg<a6400310> addr<c7ffc002>
esp0: SW [sreg<13> sstep<04> ireg<10>]
esp0: HW reread [sreg<17> sstep<cc> ireg<00>]
esp0: current command [tgt<01> lun<00> pphase<UNISSUED>
cphase<UNISSUED>] esp0: disconnected
esp0: Resetting scsi bus


[2] -=20
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Dec 20 14:53:05 2005 -0800

    [SPARC64]: Stop putting -finline-limit=3DXXX into CFLAGS
   =20
    It was a stupid workaround for the "static inline" vs.
    "extern inline" issues of long ago, and it is what causes
    schedule() to be inlined like crazy into kernel/sched.c
    when -Os is specified.
   =20
    MIPS and S390 should probably do the same.
   =20
    Now CC_OPTIMIZE_FOR_SIZE can be safely used on sparc64
    once more.
   =20
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 daaaee03ba6f89a05f7f9d52ec8c63a0deaeba52
51ff3f171e37deedafbdf2adac5984dd1c47317b M      arch :040000 040000
9725b0974ac6bfc1badb97cea8ed92985829a329
c406cf9af429c152e49458b4b7005de6942d9809 M      init

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_5qwCeT2GBEr7y0XL.JJR7=4
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAkqxdKvgdVioq28RAl9GAKCv22JzvmaTUEoffUAaiA+52CMOqwCfQMnN
jK1QoZNDoldBWbv9TmGn2gY=
=pukY
-----END PGP SIGNATURE-----

--Sig_5qwCeT2GBEr7y0XL.JJR7=4--
