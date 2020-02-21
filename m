From: Will Deacon <will@kernel.org>
Date: Fri, 21 Feb 2020 09:22:43 +0000
Subject: Re: [PATCH] kbuild: use KBUILD_DEFCONFIG as the fallback for DEFCONFIG_LIST
Message-Id: <20200221092242.GA11448@willie-the-truck>
List-Id: <sparclinux.vger.kernel.org>
References: <CGME20200221085039eucas1p2b439c37eb04870cc020f452b7ad31929@eucas1p2.samsung.com>
 <20200216154502.26478-1-masahiroy@kernel.org>
 <e0212512-bc44-fc3a-a647-47eff86983b7@samsung.com>
 <CAK7LNAQqsLnZc4h_XEMifS2hX+E39-vxD-BL5C59Aj+TaQo+eA@mail.gmail.com>
In-Reply-To: <CAK7LNAQqsLnZc4h_XEMifS2hX+E39-vxD-BL5C59Aj+TaQo+eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Albert Ou <aou@eecs.berkeley.edu>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nick Hu <nickhu@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Feb 21, 2020 at 06:18:50PM +0900, Masahiro Yamada wrote:
> On Fri, Feb 21, 2020 at 5:50 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > This patch landed in today's linux-next (next-20200221) and broke arm64
> > builds:
> >
> > --->8---
> >
> > $ make ARCH=3Darm64 CROSS_COMPILE=AArch64-linux-gnu- defconfig
> > *** Default configuration is based on 'defconfig'
> > #
> > # configuration written to .config
> > #
> > $ make ARCH=3Darm64 CROSS_COMPILE=AArch64-linux-gnu- Image.gz
> > scripts/kconfig/conf  --syncconfig Kconfig
> > scripts/kconfig/conf  --syncconfig Kconfig
> > scripts/kconfig/conf  --syncconfig Kconfig
> > scripts/kconfig/conf  --syncconfig Kconfig
> > scripts/kconfig/conf  --syncconfig Kconfig
> > ...
> >
> > (endless loop)
> >
> > --->8---
> >
> > Reverting it fixes the issue:
>=20
>=20
>=20
> My bad.
>=20
> This is because arch/arm64/Makefile does not define
> KBUILD_DEFCONFIG.
>=20
>=20
>=20
> I will drop it.
>=20
> Sorry about that.

Thanks, Masahiro.

Will
