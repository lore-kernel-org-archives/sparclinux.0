From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 25 Aug 2007 21:18:40 +0000
Subject: Questions about prom functions and restore_current()
Message-Id: <20070825231840.5c0ddc2a.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I try to trace problems with prom and SMP. I wonder what actually
the restore_current() function does (it restores g6 register, but I do
not understand why).

The restore_current() uses the macro below, which seems to have the first
line redundant unless some magic is involved. The __b_load_current load
is overwritten by the boot_cpu_id4 load in the third line.

/* Blackbox - take care with this... - check smp4m and smp4d before changing this. */
#define LOAD_CURRENT(dest_reg, idreg)                   \
    sethi    %hi(___b_load_current), %idreg;            \
    sethi    %hi(current_set), %dest_reg;           \
    sethi    %hi(boot_cpu_id4), %idreg;             \
    or       %dest_reg, %lo(current_set), %dest_reg;    \
    ldub     [%idreg + %lo(boot_cpu_id4)], %idreg;      \
    ld       [%idreg + %dest_reg], %dest_reg;


Regards,
Krzysztof
