From: "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Sun, 10 Jan 2021 11:53:10 +0000
Subject: Re: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
Message-Id: <6B074439-2E91-4FCF-84C8-82AE13D8C7F0@goldelico.com>
List-Id: <sparclinux.vger.kernel.org>
References: <JUTMMQ.NNFWKIUV7UUJ1@crapouillou.net>
 <20210108235805.GA17543@alpha.franken.de>
 <20210109003352.GA18102@alpha.franken.de>
 <DUUPMQ.U53A0W7YJPGM@crapouillou.net>
In-Reply-To: <DUUPMQ.U53A0W7YJPGM@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Cercueil <paul@crapouillou.net>
Cc: juri.lelli@redhat.com, linux-aio@kvack.org, airlied@linux.ie, nouveau@lists.freedesktop.org, bigeasy@linutronix.de, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-mips <linux-mips@vger.kernel.org>, bsegall@google.com, clm@fb.com, ray.huang@amd.com, paulus@samba.org, kraxel@redhat.com, sparclinux@vger.kernel.org, deanbo422@gmail.com, hch@lst.de, vincent.guittot@linaro.org, paulmck@kernel.org, mpe@ellerman.id.au, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, airlied@redhat.com, linux-snps-arc@lists.infradead.org, linux-mm@kvack.org, mgorman@suse.de, linux-xtensa@linux-xtensa.org, arnd@arndb.de, intel-gfx@lists.freedesktop.org, sroland@vmware.com, josef@toxicpanda.com, rostedt@goodmis.org, torvalds@linuxfoundation.org, green.hu@gmail.com, rodrigo.vivi@intel.com, dsterba@suse.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, dietmar.eggemann@arm.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, chris@zankel.net, monstr@monstr.eu, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, nickhu@andestech.com, jcmvbkbc@gmail.com, linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, christian.koenig@amd.com, bcrl@kvack.org, spice-devel@lists.freedesktop.org, vgupta@synopsys.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, bristot@redhat.com, davem@davemloft.net, linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk


> Am 10.01.2021 um 12:35 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi Thomas,
>=20
> Le sam. 9 janv. 2021 =E0 1:33, Thomas Bogendoerfer <tsbogend@alpha.franke=
n.de> a =E9crit :
>> On Sat, Jan 09, 2021 at 12:58:05AM +0100, Thomas Bogendoerfer wrote:
>>> On Fri, Jan 08, 2021 at 08:20:43PM +0000, Paul Cercueil wrote:
>>> > Hi Thomas,
>>> >
>>> > 5.11 does not boot anymore on Ingenic SoCs, I bisected it to this com=
mit.

Just for completeness, I have no such problems booting CI20/jz4780 or Skyto=
ne400/jz4730 (unpublished work) with 5.11-rc2.
But may depend on board capabilites (ram size, memory layout or something e=
lse).

>>> >
>>> > Any idea what could be happening?
>>> not yet, kernel crash log of a Malta QEMU is below.
>> update:
>> This dirty hack lets the Malta QEMU boot again:
>> diff --git a/mm/highmem.c b/mm/highmem.c
>> index c3a9ea7875ef..190cdda1149d 100644
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -515,7 +515,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgpro=
t_t prot)
>> 	vaddr =3D __fix_to_virt(FIX_KMAP_BEGIN + idx);
>> 	BUG_ON(!pte_none(*(kmap_pte - idx)));
>> 	pteval =3D pfn_pte(pfn, prot);
>> -	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
>> +	set_pte(kmap_pte - idx, pteval);
>> 	arch_kmap_local_post_map(vaddr, pteval);
>> 	current->kmap_ctrl.pteval[kmap_local_idx()] =3D pteval;
>> 	preempt_enable();
>> set_pte_at() tries to update cache and could do an kmap_atomic() there.
>> Not sure, if this is allowed at this point.
>=20
> Yes, I can confirm that your workaround works here too.
>=20
> Cheers,
> -Paul
>=20
>=20
