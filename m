From: Meelis Roos <mroos@linux.ee>
Date: Sat, 31 Mar 2012 21:03:05 +0000
Subject: current 3.3+git compile failure on sparc64: pgd_t
Message-Id: <alpine.SOC.1.00.1204010001160.11347@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

system.h removal fallout?

  CC      arch/sparc/kernel/cpu.o
In file included from /home/mroos/linux/arch/sparc/include/asm/pgtable_64.h=
:15:0,
                 from /home/mroos/linux/arch/sparc/include/asm/pgtable.h:4,
                 from arch/sparc/kernel/cpu.c:15:
include/asm-generic/pgtable-nopud.h:13:16: error: unknown type name =A1pgd_=
t=A2
include/asm-generic/pgtable-nopud.h:25:28: error: unknown type name =A1pgd_=
t=A2
include/asm-generic/pgtable-nopud.h:26:27: error: unknown type name =A1pgd_=
t=A2
include/asm-generic/pgtable-nopud.h:27:31: error: unknown type name =A1pgd_=
t=A2
include/asm-generic/pgtable-nopud.h:28:30: error: unknown type name =A1pgd_=
t=A2
include/asm-generic/pgtable-nopud.h:38:34: error: unknown type name =A1pgd_=
t=A2
In file included from /home/mroos/linux/arch/sparc/include/asm/pgtable_64.h=
:783:0,
                 from /home/mroos/linux/arch/sparc/include/asm/pgtable.h:4,
                 from arch/sparc/kernel/cpu.c:15:
include/asm-generic/pgtable.h: In function =A1pgd_none_or_clear_bad=A2:
include/asm-generic/pgtable.h:258:2: error: implicit declaration of functio=
n =A1pgd_none=A2 [-Werror=3Dimplicit-function-declaration]
include/asm-generic/pgtable.h:260:2: error: implicit declaration of functio=
n =A1pgd_bad=A2 [-Werror=3Dimplicit-function-declaration]
include/asm-generic/pgtable.h: In function =A1pud_none_or_clear_bad=A2:
include/asm-generic/pgtable.h:269:6: error: request for member =A1pgd=A2 in=
 something not a structure or union

--=20
Meelis Roos (mroos@linux.ee)
