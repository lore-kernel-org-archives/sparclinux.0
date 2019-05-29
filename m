From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 29 May 2019 21:32:35 +0000
Subject: Re: [bisected] DEBUG_PAGEALLOC hangs on sparc64
Message-Id: <57385AAB-C9A1-46AD-B743-445D4ECCA902@jrtc27.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_946101B8-1742-4F83-8EF7-FDF051CC3C53"
List-Id: <sparclinux.vger.kernel.org>
References: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
In-Reply-To: <86e9d84e-cffa-0bae-f575-7cf6789f5fb8@linux.ee>
To: sparclinux@vger.kernel.org


--Apple-Mail=_946101B8-1742-4F83-8EF7-FDF051CC3C53
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On 29 May 2019, at 22:00, James Clarke <jrtc27@jrtc27.com> wrote:
> On 29 May 2019, at 21:23, David Miller <davem@davemloft.net> wrote:
>>=20
>> From: Meelis Roos <mroos@linux.ee>
>> Date: Wed, 29 May 2019 22:08:26 +0300
>>=20
>>> Bisecting led me to 4.9 merge window and this patch that broke it:
>>>=20
>>> a74ad5e660a9ee1d071665e7e8ad822784a2dc7f is the first bad commit
>>> commit a74ad5e660a9ee1d071665e7e8ad822784a2dc7f
>>> Author: David S. Miller <davem@davemloft.net>
>>> Date:   Thu Oct 27 09:04:54 2016 -0700
>>>=20
>>>   sparc64: Handle extremely large kernel TLB range flushes more
>>>   gracefully.
>>=20
>> Thank you, I will take a close look at this ASAP.
>=20
> Perhaps I'm being stupid, but the first hunk in =
xcall_flush_tlb_kernel_range
> looks wrong to me. %g2 previously contained PAGE_SIZE-1, but is now =
clobbered
> by the new srlx, setting %g2 to (aligned_end-aligned_start)>>18. If =
the
> brnz %g2 is taken, %g2 gets overwritten, so it's not a problem, but if =
the
> branch *isn't* taken, then %g2 is zero, so the add %g2, 1, %g2 in the =
delay
> slot of the branch sets %g2 to 1. However, prior to this commit, %g2 =
would then
> have had the value PAGE_SIZE, and the following code to do a =
page-by-page flush
> assumes this, using it as the amount to step through. Rather than =
stepping
> through page-by-page (with offset 0x20 to indicate nucleus), we will =
step
> through the loop byte-by-byte, so some iterations will have low bit
> combinations for things other than a nucleus page demap operation. =
This same
> bug is replicated in the new __cheetah_xcall_flush_tlb_kernel_range.

Meelis, could you please try the attached patch to see if it fixes the =
issue?

David, I don't actually see why we need this alignment code in the first =
place.
The only call to the xcall is in smp_flush_tlb_kernel_range which =
already
rounds the start and end to multiples of the page size, so I believe we =
should
be able to delete the first four instructions of the 3 different
implementations? The non-xcall variants already skip doing this.

Regards,
James

--Apple-Mail=_946101B8-1742-4F83-8EF7-FDF051CC3C53
Content-Disposition: attachment;
	filename=0001-sparc64-Fix-regression-in-non-hypervisor-TLB-flush-x.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-sparc64-Fix-regression-in-non-hypervisor-TLB-flush-x.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20c30831c5498105b986a563e3cde35b4015ae97e5=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20James=20Clarke=20<jrtc27@jrtc27.com>=0ADate:=20=
Wed,=2029=20May=202019=2022:31:31=20+0100=0ASubject:=20[PATCH]=20=
sparc64:=20Fix=20regression=20in=20non-hypervisor=20TLB=20flush=20xcall=0A=
=0APreviously,=20%g2=20would=20end=20up=20with=20the=20value=20=
PAGE_SIZE,=20but=20after=20the=0Acommit=20mentioned=20below=20it=20ends=20=
up=20with=20the=20value=201=20due=20to=20being=20reused=0Afor=20a=20=
different=20purpose.=20We=20need=20it=20to=20be=20PAGE_SIZE=20as=20we=20=
use=20it=20to=20step=0Athrough=20pages=20in=20our=20demap=20loop,=20=
otherwise=20we=20set=20different=20flags=20in=20the=0Alow=2012=20bits=20=
of=20the=20address=20written=20to,=20thereby=20doing=20things=20other=20=
than=20a=0Anucleus=20page=20flush.=0A=0AFixes:=20a74ad5e660a9=20=
("sparc64:=20Handle=20extremely=20large=20kernel=20TLB=20range=20flushes=20=
more=20gracefully.")=0AReported-by:=20Meelis=20Roos=20<mroos@linux.ee>=0A=
Signed-off-by:=20James=20Clarke=20<jrtc27@jrtc27.com>=0A---=0A=20=
arch/sparc/mm/ultra.S=20|=204=20++--=0A=201=20file=20changed,=202=20=
insertions(+),=202=20deletions(-)=0A=0Adiff=20--git=20=
a/arch/sparc/mm/ultra.S=20b/arch/sparc/mm/ultra.S=0Aindex=20=
d245f89d1395..d220b6848746=20100644=0A---=20a/arch/sparc/mm/ultra.S=0A=
+++=20b/arch/sparc/mm/ultra.S=0A@@=20-587,7=20+587,7=20@@=20=
xcall_flush_tlb_kernel_range:=09/*=2044=20insns=20*/=0A=20=09sub=09=09=
%g7,=20%g1,=20%g3=0A=20=09srlx=09=09%g3,=2018,=20%g2=0A=20=09brnz,pn=09=09=
%g2,=202f=0A-=09=20add=09=09%g2,=201,=20%g2=0A+=09=20sethi=09=09=
%hi(PAGE_SIZE),=20%g2=0A=20=09sub=09=09%g3,=20%g2,=20%g3=0A=20=09or=09=09=
%g1,=200x20,=20%g1=09=09!=20Nucleus=0A=201:=09stxa=09=09%g0,=20[%g1=20+=20=
%g3]=20ASI_DMMU_DEMAP=0A@@=20-751,7=20+751,7=20@@=20=
__cheetah_xcall_flush_tlb_kernel_range:=09/*=2044=20insns=20*/=0A=20=09=
sub=09=09%g7,=20%g1,=20%g3=0A=20=09srlx=09=09%g3,=2018,=20%g2=0A=20=09=
brnz,pn=09=09%g2,=202f=0A-=09=20add=09=09%g2,=201,=20%g2=0A+=09=20sethi=09=
=09%hi(PAGE_SIZE),=20%g2=0A=20=09sub=09=09%g3,=20%g2,=20%g3=0A=20=09or=09=
=09%g1,=200x20,=20%g1=09=09!=20Nucleus=0A=201:=09stxa=09=09%g0,=20[%g1=20=
+=20%g3]=20ASI_DMMU_DEMAP=0A--=20=0A2.20.1=0A=0A=

--Apple-Mail=_946101B8-1742-4F83-8EF7-FDF051CC3C53--
