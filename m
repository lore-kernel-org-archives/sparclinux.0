From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 31 Mar 2012 21:29:01 +0000
Subject: Re: current 3.3+git compile failure on sparc64: pgd_t
Message-Id: <20120331212900.GA26142@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1204010001160.11347@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1204010001160.11347@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On Sun, Apr 01, 2012 at 12:03:05AM +0300, Meelis Roos wrote:
> system.h removal fallout?
> 
>   CC      arch/sparc/kernel/cpu.o
> In file included from /home/mroos/linux/arch/sparc/include/asm/pgtable_64.h:15:0,
>                  from /home/mroos/linux/arch/sparc/include/asm/pgtable.h:4,
>                  from arch/sparc/kernel/cpu.c:15:
> include/asm-generic/pgtable-nopud.h:13:16: error: unknown type name ‘pgd_t’
> include/asm-generic/pgtable-nopud.h:25:28: error: unknown type name ‘pgd_t’
> include/asm-generic/pgtable-nopud.h:26:27: error: unknown type name ‘pgd_t’
> include/asm-generic/pgtable-nopud.h:27:31: error: unknown type name ‘pgd_t’
> include/asm-generic/pgtable-nopud.h:28:30: error: unknown type name ‘pgd_t’
> include/asm-generic/pgtable-nopud.h:38:34: error: unknown type name ‘pgd_t’
> In file included from /home/mroos/linux/arch/sparc/include/asm/pgtable_64.h:783:0,
>                  from /home/mroos/linux/arch/sparc/include/asm/pgtable.h:4,
>                  from arch/sparc/kernel/cpu.c:15:
> include/asm-generic/pgtable.h: In function ‘pgd_none_or_clear_bad’:
> include/asm-generic/pgtable.h:258:2: error: implicit declaration of function ‘pgd_none’ [-Werror=implicit-function-declaration]
> include/asm-generic/pgtable.h:260:2: error: implicit declaration of function ‘pgd_bad’ [-Werror=implicit-function-declaration]
> include/asm-generic/pgtable.h: In function ‘pud_none_or_clear_bad’:
> include/asm-generic/pgtable.h:269:6: error: request for member ‘pgd’ in something not a structure or union

Providing your config (use savedefconfig) would be a help.

	Sam
