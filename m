From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 12 Jun 2017 21:24:54 +0000
Subject: Re: [PATCH 2/2] include: warn for inconsistent endian config definition
Message-Id: <e1560578-79ea-09a8-5b88-95aa907c4cce@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201706102219.7auwXKYx%fengguang.wu@intel.com>
 <002f7627-1ce5-eabb-967d-fe93a3660f03@oracle.com>
 <CAK8P3a24DZ26uQDMJMd-e7WKuM66rPnidaqQHQ4sEhPfQz2xJw@mail.gmail.com>
In-Reply-To: <CAK8P3a24DZ26uQDMJMd-e7WKuM66rPnidaqQHQ4sEhPfQz2xJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, David Miller <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org


On 6/12/2017 3:51 PM, Arnd Bergmann wrote:
> On Mon, Jun 12, 2017 at 10:30 PM, Babu Moger <babu.moger@oracle.com> wrote:
>> Looks like microblaze can be configured to either little or big endian
>> formats.  How about
>> adding a choice statement to address this.
>> Here is my proposed patch.
> Hi Babu,
>
> This part looks fine, but I think we also need this one:
>
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 740f2b82a182..1f6c486826a0 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -35,6 +35,8 @@ endif
>   CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_DIV) += -mno-xl-soft-div
>   CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_BARREL) += -mxl-barrel-shift
>   CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
> +CPUFLAGS-$(CONFIG_BIG_ENDIAN) += -mbig-endian
> +CPUFLAGS-$(CONFIG_LITTLE_ENDIAN) += -mlittle-endian
>
>   CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
>
>
> That way, we don't have to guess what the toolchain does, but rather
> tell it to do whatever is configured, like we do for most other architectures.

Ok. Thanks. Arnd. Will update and resend the series.

>
> Unfortunately we can't do the same thing on xtensa, as that no longer
> supports the -mbig-endian/-mbig-endian flags in any recent gcc version
> (a long time ago it had them, but they were removed along with many other
> options).
>
>          Arnd

