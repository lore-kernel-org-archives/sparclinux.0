From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2018 10:28:32 +0000
Subject: Re: Build regressions/improvements in v4.16-rc1
Message-Id: <CAMuHMdW5qRH93CMyRL-gbWgiA_rnizErbjNtSMT5b3d58N3ZTQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1518430656-21669-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1518430656-21669-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Michael Bringmann <mwb@linux.vnet.ibm.com>, Rob Gardner <rob.gardner@oracle.com>, sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux MIPS Mailing List <linux-mips@linux-mips.org>, adi-buildroot-devel@lists.sourceforge.net

On Mon, Feb 12, 2018 at 11:17 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.16-rc1[1] compared to v4.15[2].
>
> Summarized:
>   - build errors: +13/-5
>   - build warnings: +1653/-1537
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/head/7928b2cbe55b2a410a0f5c1f154610059c57b1b2/ (all 273 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/d8a5b80568a9cb66810e75b182018e9edb68e8ff/ (271 out of 273 configs)
>
>
> *** ERRORS ***
>
> 13 error regressions:
>   + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: 'emulated' may be used uninitialized in this function [-Werror=uninitialized]:  => 1361:2

Lots of powerpc configs

>   + /home/kisskb/slave/src/drivers/net/ethernet/intel/i40e/i40e_ethtool.c: error: implicit declaration of function 'cmpxchg64' [-Werror=implicit-function-declaration]:  => 4443:6, 4443:2

mips{,el}-allmodconfig

>   + /home/kisskb/slave/src/fs/signalfd.c: error: 'BUS_MCEERR_AR' undeclared (first use in this function):  => 126:26

Lots of blackfin configs

>   + error: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!:  => N/A
>   + error: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!:  => N/A

sparc-allmodconfig (i.e. sparc32)

>   + error: No rule to make target arch/ia64/kernel/pci-swiotlb.o:  => N/A

ia64-defconfig (patch availavle)

>   + error: hotplug-cpu.c: undefined reference to `find_and_online_cpu_nid':  => .text+0x13c)

ppc64le/pseries_le_defconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
