From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 18 May 2020 03:49:39 +0000
Subject: Re: [PATCH V3 07/15] arch/kunmap_atomic: Consolidate duplicate code
Message-Id: <20200518034938.GA3023182@iweiny-DESK2.sc.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
 <20200507150004.1423069-8-ira.weiny@intel.com>
 <20200516223306.GA161252@roeck-us.net>
In-Reply-To: <20200516223306.GA161252@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Sat, May 16, 2020 at 03:33:06PM -0700, Guenter Roeck wrote:
> On Thu, May 07, 2020 at 07:59:55AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >=20
> > Every single architecture (including !CONFIG_HIGHMEM) calls...
> >=20
> > 	pagefault_enable();
> > 	preempt_enable();
> >=20
> > ... before returning from __kunmap_atomic().  Lift this code into the
> > kunmap_atomic() macro.
> >=20
> > While we are at it rename __kunmap_atomic() to kunmap_atomic_high() to
> > be consistent.
> >=20
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>=20
> This patch results in:
>=20
> Starting init: /bin/sh exists but couldn't execute it (error -14)
>=20
> when trying to boot microblazeel:petalogix-ml605 in qemu.

Thanks for the report.  I'm not readily seeing the issue.

Do you have a kernel config?  Specifically is CONFIG_HIGHMEM set?

>=20
> Bisect log attached.
>=20
> Guenter
>=20
> ---
> # bad: [bdecf38f228bcca73b31ada98b5b7ba1215eb9c9] Add linux-next specific=
 files for 20200515
> # good: [2ef96a5bb12be62ef75b5828c0aab838ebb29cb8] Linux 5.7-rc5
> git bisect start 'HEAD' 'v5.7-rc5'
> # good: [3674d7aa7a8e61d993886c2fb7c896c5ef85e988] Merge remote-tracking =
branch 'crypto/master'
> git bisect good 3674d7aa7a8e61d993886c2fb7c896c5ef85e988
> # good: [87f6f21783522e6d62127cf33ae5e95f50874beb] Merge remote-tracking =
branch 'spi/for-next'
> git bisect good 87f6f21783522e6d62127cf33ae5e95f50874beb
> # good: [5c428e8277d5d97c85126387d4e00aa5adde4400] Merge remote-tracking =
branch 'staging/staging-next'
> git bisect good 5c428e8277d5d97c85126387d4e00aa5adde4400
> # good: [f68de67ed934e7bdef4799fd7777c86f33f14982] Merge remote-tracking =
branch 'hyperv/hyperv-next'
> git bisect good f68de67ed934e7bdef4799fd7777c86f33f14982
> # bad: [54acd2dc52b069da59639eea0d0c92726f32fb01] mm/memblock: fix a typo=
 in comment "implict"->"implicit"
> git bisect bad 54acd2dc52b069da59639eea0d0c92726f32fb01
> # good: [784a17aa58a529b84f7cc50f351ed4acf3bd11f3] mm: remove the pgprot =
argument to __vmalloc
> git bisect good 784a17aa58a529b84f7cc50f351ed4acf3bd11f3
> # good: [6cd8137ff37e9a37aee2d2a8889c8beb8eab192f] khugepaged: replace th=
e usage of system(3) in the test
> git bisect good 6cd8137ff37e9a37aee2d2a8889c8beb8eab192f
> # bad: [6987da379826ed01b8a1cf046b67cc8cc10117cc] sparc: remove unnecessa=
ry includes
> git bisect bad 6987da379826ed01b8a1cf046b67cc8cc10117cc
> # good: [bc17b545388f64c09e83e367898e28f60277c584] mm/hugetlb: define a g=
eneric fallback for is_hugepage_only_range()
> git bisect good bc17b545388f64c09e83e367898e28f60277c584
> # bad: [9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011] arch-kmap_atomic-consol=
idate-duplicate-code-checkpatch-fixes
> git bisect bad 9b5aa5b43f957f03a1f4a9aff5f7924e2ebbc011
> # good: [0941a38ff0790c1004270f952067a5918a4ba32d] arch/kmap: remove redu=
ndant arch specific kmaps
> git bisect good 0941a38ff0790c1004270f952067a5918a4ba32d
> # good: [56e635a64c2cbfa815c851af10e0f811e809977b] arch-kunmap-remove-dup=
licate-kunmap-implementations-fix
> git bisect good 56e635a64c2cbfa815c851af10e0f811e809977b
> # bad: [60f96b2233c790d4f1c49317643051f1670bcb29] arch/kmap_atomic: conso=
lidate duplicate code
> git bisect bad 60f96b2233c790d4f1c49317643051f1670bcb29
> # good: [7b3708dc3bf72a647243064fe7ddf9a76248ddfd] {x86,powerpc,microblaz=
e}/kmap: move preempt disable
> git bisect good 7b3708dc3bf72a647243064fe7ddf9a76248ddfd
> # first bad commit: [60f96b2233c790d4f1c49317643051f1670bcb29] arch/kmap_=
atomic: consolidate duplicate code

I'm confused by this.  This points to an earlier commit being bad?

commit 60f96b2233c790d4f1c49317643051f1670bcb29                            =
    =20
Author: Ira Weiny <ira.weiny@intel.com>                                    =
    =20
Date:   Thu May 14 13:39:54 2020 +1000                                     =
    =20
                                                                           =
    =20
    arch/kmap_atomic: consolidate duplicate code                           =
    =20
                                                                           =
    =20
    Every arch has the same code to ensure atomic operations and a check fo=
r   =20
    !HIGHMEM page.                                                         =
    =20
                                                                           =
    =20
    Remove the duplicate code by defining a core kmap_atomic() which only  =
    =20
    calls the arch specific kmap_atomic_high() when the page is high memory=
.   =20
                                                                           =
    =20
    Link: http://lkml.kernel.org/r/20200507150004.1423069-7-ira.weiny@intel=
.com=20
    Signed-off-by: Ira Weiny <ira.weiny@intel.com>                         =
    =20
    Reviewed-by: Christoph Hellwig <hch@lst.de>                            =
    =20
    Cc: Al Viro <viro@zeniv.linux.org.uk>                                  =
    =20
    Cc: Andy Lutomirski <luto@kernel.org>                                  =
    =20
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>                  =
    =20
    Cc: Borislav Petkov <bp@alien8.de>                                     =
    =20
    Cc: Christian K=F6nig <christian.koenig@amd.com>                       =
      =20
    Cc: Chris Zankel <chris@zankel.net>                                    =
    =20
    Cc: Daniel Vetter <daniel.vetter@ffwll.ch>                             =
    =20
    Cc: Dan Williams <dan.j.williams@intel.com>                            =
    =20
    Cc: Dave Hansen <dave.hansen@linux.intel.com>                          =
    =20
    Cc: "David S. Miller" <davem@davemloft.net>                            =
    =20
    Cc: Helge Deller <deller@gmx.de>                                       =
    =20
    Cc: "H. Peter Anvin" <hpa@zytor.com>                                   =
    =20
    Cc: Ingo Molnar <mingo@redhat.com>                                     =
    =20
    Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>     =
    =20
    Cc: Max Filippov <jcmvbkbc@gmail.com>                                  =
    =20
    Cc: Paul Mackerras <paulus@samba.org>                                  =
    =20
    Cc: Peter Zijlstra <peterz@infradead.org>                              =
    =20
    Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>                    =
    =20
    Cc: Thomas Gleixner <tglx@linutronix.de>                               =
             =20
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>               =
    =20
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>                 =
    =20


Any idea which one it is?

Ira
