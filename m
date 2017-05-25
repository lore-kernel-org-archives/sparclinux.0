From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 25 May 2017 14:51:52 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <8ddc7276-6296-2284-51d3-01093ccbeccb@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
In-Reply-To: <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, sparclinux <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Arnd,

Here is the draft patch. Some questions below.


On 5/24/2017 5:18 AM, Arnd Bergmann wrote:
> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
>>> Found this problem while enabling queued rwlock on SPARC.
>>> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
>>> specific byte in qrwlock structure. Without this parameter,
>>> we clear the wrong byte. Here is the code.
>>>
>>> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>>>   {
>>>          return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>>>   }
>>>
>>> Define CPU_BIG_ENDIAN for SPARC to fix it.
>>> --- a/arch/sparc/Kconfig
>>> +++ b/arch/sparc/Kconfig
>>> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>>>   config ARCH_PROC_KCORE_TEXT
>>>          def_bool y
>>>
>>> +config CPU_BIG_ENDIAN
>>> +       bool
>>> +       default y if SPARC
>> Nice catch!
>>
>> Traditionally, CPU_BIG_ENDIAN and CPU_LITTLE_ENDIAN were defined only on
>> architectures that may support both.  And it was checked in platform code
>> and drivers only.
>> Hence the symbol is lacking from most architectures. Heck, even
>> architectures that support both may default to one endiannes, and declare
>> only the symbol for the other endianness:
>>
>> --- arch/alpha ---
>> --- arch/arc ---
>> arch/arc/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/arm ---
>> arch/arm/mm/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/arm64 ---
>> arch/arm64/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/blackfin ---
>> --- arch/c6x ---
>> arch/c6x/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/cris ---
>> --- arch/frv ---
>> --- arch/h8300 ---
>> --- arch/hexagon ---
>> --- arch/ia64 ---
>> --- arch/Kconfig ---
>> --- arch/m32r ---
>> arch/m32r/Kconfig:config CPU_LITTLE_ENDIAN
>> --- arch/m68k ---
>> --- arch/metag ---
>> --- arch/microblaze ---
>> --- arch/mips ---
>> arch/mips/Kconfig:config CPU_BIG_ENDIAN
>> arch/mips/Kconfig:config CPU_LITTLE_ENDIAN
>> --- arch/mn10300 ---
>> --- arch/nios2 ---
>> --- arch/openrisc ---
>> --- arch/parisc ---
>> --- arch/powerpc ---
>> arch/powerpc/platforms/Kconfig.cputype:config CPU_BIG_ENDIAN
>> arch/powerpc/platforms/Kconfig.cputype:config CPU_LITTLE_ENDIAN
>> --- arch/s390 ---
>> arch/s390/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/score ---
>> --- arch/sh ---
>> arch/sh/Kconfig.cpu:config CPU_LITTLE_ENDIAN
>> arch/sh/Kconfig.cpu:config CPU_BIG_ENDIAN
>> --- arch/sparc ---
>> --- arch/tile ---
>> --- arch/um ---
>> --- arch/unicore32 ---
>> --- arch/x86 ---
>> --- arch/xtensa ---
>>
>> However, there are already a few users in generic code, which are thus
>> broken on many platforms:
>>
>>      drivers/of/base.c
>>      drivers/of/fdt.c
>>      drivers/tty/serial/earlycon.c
>>      drivers/tty/serial/serial_core.c
>>
>> include/asm-generic/qrwlock.h is also generic, but depends on the
>> architecture to select ARCH_USE_QUEUED_RWLOCKS, which only very few do
>> (x86, and now sparc).
>>
>> I guess the time is ripe for adding (both) symbols to all architectures?
> Good idea. I think we can do most of this by adding a few lines to
> arch/Kconfig:
>
> config CPU_BIG_ENDIAN
>          bool
>
> config CPU_LITTLE_ENDIAN
>         def_bool !CPU_BIG_ENDIAN
>
> This way, we only need to add 'select CPU_BIG_ENDIAN' to the
> architectures that are always big-endian, and we don't need to
> change anything for the ones that have a single 'CPU_BIG_ENDIAN'
> option.
>
> The three architectures that have a 'choice' statement (mips, ppc and
> sh) will have to convert, and m32r will have to replace the

what to you mean by "(mips, ppc andsh) will have to convert"?  Do you 
expect any changes here?

> option with the opposite one, which could break 'make oldconfig',
> but nobody really cares about m32r any more.
>
>         Arnd
Here is the proposed draft patch
===================
---
  arch/Kconfig          |    6 ++++++
  arch/frv/Kconfig      |    1 +
  arch/h8300/Kconfig    |    1 +
  arch/m32r/Kconfig     |    6 +++---
  arch/m68k/Kconfig     |    1 +
  arch/openrisc/Kconfig |    1 +
  arch/parisc/Kconfig   |    1 +
  arch/s390/Kconfig     |    1 +
  arch/sparc/Kconfig    |    1 +
  9 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6c00e5b..19fcafd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -867,4 +867,10 @@ config STRICT_MODULE_RWX
  config ARCH_WANT_RELAX_ORDER
         bool

+config CPU_BIG_ENDIAN
+        bool
+
+config CPU_LITTLE_ENDIAN
+       def_bool !CPU_BIG_ENDIAN
+
  source "kernel/gcov/Kconfig"
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index eefd9a4..db258a4 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -16,6 +16,7 @@ config FRV
         select OLD_SIGACTION
         select HAVE_DEBUG_STACKOVERFLOW
         select ARCH_NO_COHERENT_DMA_MMAP
+       select CPU_BIG_ENDIAN

  config ZONE_DMA
         bool
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3ae8525..22ebf28 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -22,6 +22,7 @@ config H8300
         select HAVE_ARCH_KGDB
         select HAVE_ARCH_HASH
         select CPU_NO_EFFICIENT_FFS
+       select CPU_BIG_ENDIAN

  config RWSEM_GENERIC_SPINLOCK
         def_bool y
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 9547446..d57e37b 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -193,9 +193,9 @@ config TIMER_DIVIDE
         int "Timer divider (integer)"
         default "128"

-config CPU_LITTLE_ENDIAN
-        bool "Generate little endian code"
-       default n
+config CPU_BIG_ENDIAN
+        bool "Generate big endian code"
+       default y

  config MEMORY_START
         hex "Physical memory start address (hex)"
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index d140206..b44579b 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -22,6 +22,7 @@ config M68K
         select MODULES_USE_ELF_RELA
         select OLD_SIGSUSPEND3
         select OLD_SIGACTION
+       select CPU_BIG_ENDIAN

  config RWSEM_GENERIC_SPINLOCK
         bool
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 1e95920..d772983 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -28,6 +28,7 @@ config OPENRISC
         select OR1K_PIC
         select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
         select NO_BOOTMEM
+       select CPU_BIG_ENDIAN

  config MMU
         def_bool y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 531da9e..7a8ec28 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -40,6 +40,7 @@ config PARISC
         select GENERIC_CLOCKEVENTS
         select ARCH_NO_COHERENT_DMA_MMAP
         select CPU_NO_EFFICIENT_FFS
+       select CPU_BIG_ENDIAN

         help
           The PA-RISC microprocessor is designed by Hewlett-Packard and 
used
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e161faf..169e50b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -177,6 +177,7 @@ config S390
         select ARCH_HAS_SCALED_CPUTIME
         select VIRT_TO_BUS
         select HAVE_NMI
+       select CPU_BIG_ENDIAN


  config SCHED_OMIT_FRAME_POINTER
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c5b5a7b..7a28e8a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -45,6 +45,7 @@ config SPARC
         select CPU_NO_EFFICIENT_FFS
         select LOCKDEP_SMALL if LOCKDEP
         select ARCH_WANT_RELAX_ORDER
+       select CPU_BIG_ENDIAN

  config SPARC32
         def_bool !64BIT
--
1.7.1

