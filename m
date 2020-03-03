From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 03 Mar 2020 13:46:47 +0000
Subject: Re: [PATCH] kbuild: use KBUILD_DEFCONFIG as the fallback for DEFCONFIG_LIST
Message-Id: <CAK7LNATyuyU46qXngDr80d51cs0-J=00jkgL1rdASUMfgmfKOw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200228034640.25247-1-masahiroy@kernel.org> <CAK7LNAS9uWyvFeVkxtbkuBrnqumYzzLfcsUrVByHHyons4m8hA@mail.gmail.com>
In-Reply-To: <CAK7LNAS9uWyvFeVkxtbkuBrnqumYzzLfcsUrVByHHyons4m8hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-um@lists.infradead.org, sparclinux <sparclinux@vger.kernel.org>

On Fri, Feb 28, 2020 at 12:48 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Feb 28, 2020 at 12:47 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Most of the Kconfig commands (except defconfig and all*config) read
> > the .config file as a base set of CONFIG options.
> >
> > When it does not exist, the files in DEFCONFIG_LIST are searched in
> > this order and loaded if found.
> >
> > I do not see much sense in the last two lines in DEFCONFIG_LIST.
> >
> > [1] ARCH_DEFCONFIG
> >
> > The entry for DEFCONFIG_LIST is guarded by 'depends on !UML'. So, the
> > ARCH_DEFCONFIG definition in arch/x86/um/Kconfig is meaningless.
> >
> > arch/{sh,sparc,x86}/Kconfig define ARCH_DEFCONFIG depending on 32 or
> > 64 bit variant symbols. This is a little bit strange; ARCH_DEFCONFIG
> > should be a fixed string because the base config file is loaded before
> > the symbol evaluation stage.
> >
> > Using KBUILD_DEFCONFIG makes more sense because it is fixed before
> > Kconfig is invoked. Fortunately, arch/{sh,sparc,x86}/Makefile define it
> > in the same way, and it works as expected. Hence, replace ARCH_DEFCONFIG
> > with "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)".
> >
> > [2] arch/$(ARCH)/defconfig
> >
> > This file path is no longer valid. The defconfig files are always located
> > in the arch configs/ directories.
> >
> >   $ find arch -name defconfig | sort
> >   arch/alpha/configs/defconfig
> >   arch/arm64/configs/defconfig
> >   arch/csky/configs/defconfig
> >   arch/nds32/configs/defconfig
> >   arch/riscv/configs/defconfig
> >   arch/s390/configs/defconfig
> >   arch/unicore32/configs/defconfig
> >
> > The path arch/*/configs/defconfig is already covered by
> > "arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)". So, this file path is
> > not necessary.
> >
> > I moved the default KBUILD_DEFCONFIG to the top Makefile. Otherwise,
> > the 7 architectures listed above would end up with endless loop of
> > syncconfig.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> I forgot to say this.
> This is v2.
>
> Changes in v2:
>   - Move KBUILD_DEFCONFIG to fix endless loop of syncconfig
>
>

Applied to linux-kbuild.


Best Regards
Masahiro Yamada
