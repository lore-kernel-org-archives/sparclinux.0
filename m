From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Date: Fri, 25 Jun 2004 09:31:21 +0000
Subject: [SPARC64] kernel 2.6.7+cset-20040625_0611 = ERROR
Message-Id: <Pine.LNX.4.58L.0406251320310.6037@alpha.zarz.agh.edu.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, SPARC Linux kernel list <sparclinux@vger.kernel.org>

I try to build this on my machine 

cpu		: TI UltraSparc II  (BlackBird)
fpu		: UltraSparc II integrated FPU
promlib		: Version 3 Revision 12
prom		: 3.12.3
type		: sun4u
ncpus probed	: 4
ncpus active	: 4

and:
make image
[...]
  CC      arch/sparc64/kernel/process.o
In file included from include/linux/byteorder/big_endian.h:11,
                 from include/asm/byteorder.h:48,
                 from include/asm/bitops.h:11,
                 from include/linux/bitops.h:4,
                 from include/linux/thread_info.h:20,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from arch/sparc64/kernel/process.c:16:
include/linux/byteorder/swab.h: In function `__swab16p':
include/linux/byteorder/swab.h:139: warning: passing arg 1 of 
`___arch__swab16p' discards qualifiers from pointer target type
include/linux/byteorder/swab.h: In function `__swab32p':
include/linux/byteorder/swab.h:152: warning: passing arg 1 of 
`___arch__swab32p' discards qualifiers from pointer target type
include/linux/byteorder/swab.h: In function `__swab64p':
include/linux/byteorder/swab.h:172: warning: passing arg 1 of 
`___arch__swab64p' discards qualifiers from pointer target type
In file included from include/linux/sched.h:15,
                 from include/linux/module.h:10,
                 from arch/sparc64/kernel/process.c:16:
include/linux/cpumask.h: In function `__first_cpu':
include/linux/cpumask.h:210: warning: passing arg 1 of `find_next_bit' 
discards qualifiers from pointer target type
include/linux/cpumask.h: In function `__next_cpu':
include/linux/cpumask.h:216: warning: passing arg 1 of `find_next_bit' 
discards qualifiers from pointer target type
make[1]: *** [arch/sparc64/kernel/process.o] Error 1
make: *** [arch/sparc64/kernel] Error 2

-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
