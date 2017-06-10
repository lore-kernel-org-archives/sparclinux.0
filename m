From: Stafford Horne <shorne@gmail.com>
Date: Sat, 10 Jun 2017 08:22:22 +0000
Subject: Re: [PATCH v2 1/2] arch: Define CPU_BIG_ENDIAN for all fixed big endian archs
Message-Id: <20170610082222.GC6190@lianli.shorne-pla.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497037687-107638-1-git-send-email-babu.moger@oracle.com>
 <1497037687-107638-2-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1497037687-107638-2-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Jun 09, 2017 at 12:48:06PM -0700, Babu Moger wrote:
> While working on enabling queued rwlock on SPARC, found
> this following code in include/asm-generic/qrwlock.h
> which uses CONFIG_CPU_BIG_ENDIAN to clear a byte.
> 
> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>  {
> 	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>  }
> 
> Problem is many of the fixed big endian architectures don't define
> CPU_BIG_ENDIAN and clears the wrong byte.
> 
> Define CPU_BIG_ENDIAN for all the fixed big endian architecture to fix it.
> 
> Also found few more references of this config parameter in
> drivers/of/base.c
> drivers/of/fdt.c
> drivers/tty/serial/earlycon.c
> drivers/tty/serial/serial_core.c
> Be aware that this may cause regressions if someone has worked-around
> problems in the above code already. Remove the work-around.
> 
> Here is our original discussion
> https://lkml.org/lkml/2017/5/24/620
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/frv/Kconfig      |    3 +++
>  arch/h8300/Kconfig    |    3 +++
>  arch/m68k/Kconfig     |    3 +++
>  arch/openrisc/Kconfig |    3 +++
>  arch/parisc/Kconfig   |    3 +++
>  arch/sparc/Kconfig    |    3 +++
>  6 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
> index eefd9a4..1cce824 100644
> --- a/arch/frv/Kconfig
> +++ b/arch/frv/Kconfig
> @@ -17,6 +17,9 @@ config FRV
>  	select HAVE_DEBUG_STACKOVERFLOW
>  	select ARCH_NO_COHERENT_DMA_MMAP
>  
> +config CPU_BIG_ENDIAN
> +	def_bool y
> +
>  config ZONE_DMA
>  	bool
>  	default y
> diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
> index 3ae8525..5380ac8 100644
> --- a/arch/h8300/Kconfig
> +++ b/arch/h8300/Kconfig
> @@ -23,6 +23,9 @@ config H8300
>  	select HAVE_ARCH_HASH
>  	select CPU_NO_EFFICIENT_FFS
>  
> +config CPU_BIG_ENDIAN
> +	def_bool y
> +
>  config RWSEM_GENERIC_SPINLOCK
>  	def_bool y
>  
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index d140206..029a58b 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -23,6 +23,9 @@ config M68K
>  	select OLD_SIGSUSPEND3
>  	select OLD_SIGACTION
>  
> +config CPU_BIG_ENDIAN
> +	def_bool y
> +
>  config RWSEM_GENERIC_SPINLOCK
>  	bool
>  	default y
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index 1e95920..a0f2e4a 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -29,6 +29,9 @@ config OPENRISC
>  	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
>  	select NO_BOOTMEM
>  
> +config CPU_BIG_ENDIAN
> +	def_bool y
> +

Acked-by: Stafford Horne <shorne@gmail.com>

I actually have this patch in my SMP branch [0] I am working on.  It would
be good to get this in, I have heard verious complaints about bugs with
endianness and mmio with OpenRISC but have not been able to look into it.
This might be related as well.

[0] https://github.com/stffrdhrn/linux/commit/2cc4b90eca865c54b87b8f59e523c131f30fc9ac

>  config MMU
>  	def_bool y
>  
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 531da9e..dda1f55 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -47,6 +47,9 @@ config PARISC
>  	  and later HP3000 series).  The PA-RISC Linux project home page is
>  	  at <http://www.parisc-linux.org/>.
>  
> +config CPU_BIG_ENDIAN
> +	def_bool y
> +
>  config MMU
>  	def_bool y
>  
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 58243b0..eb213b5 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -92,6 +92,9 @@ config ARCH_DEFCONFIG
>  config ARCH_PROC_KCORE_TEXT
>  	def_bool y
>  
> +config CPU_BIG_ENDIAN
> +	def_bool y
> +
>  config ARCH_ATU
>  	bool
>  	default y if SPARC64
> -- 
> 1.7.1
> 
