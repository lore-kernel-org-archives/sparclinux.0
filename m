From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Jun 2017 07:26:20 +0000
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
Message-Id: <CAMuHMdXSrfbSX2de2q35Hj6vQwi+sr23M1LEg82JL+FyLq4OJw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170623220857.28774-2-palmer@dabbelt.com>
 <201706261344.OUjMGlsQ%fengguang.wu@intel.com>
In-Reply-To: <201706261344.OUjMGlsQ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 26, 2017 at 7:39 AM, kbuild test robot <lkp@intel.com> wrote:
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.12-rc6]
> [cannot apply to next-20170623]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/pci-Add-and-use-PCI_GENERIC_SETUP-Kconfig-entry/20170626-043558
> config: m68k-allnoconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 4.9.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=m68k
>
> All warnings (new ones prefixed by >>):
>
> warning: (M68K) selects PCI_GENERIC_SETUP which has unmet direct dependencies (MMU)

I can't seem to find this dependency of PCI_GENERIC_SETUP on MMU?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
