From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Tue, 01 Jul 2008 15:25:03 +0000
Subject: next-0630: sparc64: build failed
Message-Id: <a4423d670807010825t7ea2eb44oda3f08dc007c40a2@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, sagar.abhishek@gmail.com, ros

Hi David, Abhishek

$ make CROSS_COMPILE=sparc64-unknown-linux-gnu- image modules && sudo
make modules_install
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
dnsdomainname: Unknown host
  CC      arch/sparc64/kernel/sparc64_ksyms.o
arch/sparc64/kernel/sparc64_ksyms.c:116: error: '_mcount' undeclared
here (not in a function)
cc1: warnings being treated as errors
arch/sparc64/kernel/sparc64_ksyms.c:116: error: type defaults to 'int'
in declaration of '_mcount'

This commit is cause.

commit 395a59d0f8e86bb39cd700c3d185d30c670bb958
Author: Abhishek Sagar <sagar.abhishek@gmail.com>
Date:   Sat Jun 21 23:47:27 2008 +0530

    ftrace: store mcount address in rec->ip

    Record the address of the mcount call-site. Currently all archs
except sparc64
    record the address of the instruction following the mcount call-site. Some
    general cleanups are entailed. Storing mcount addresses in rec->ip enables
    looking them up in the kprobe hash table later on to check if
they're kprobe'd.

    Signed-off-by: Abhishek Sagar <sagar.abhishek@gmail.com>
    Cc: davem@davemloft.net
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/sparc64/kernel/sparc64_ksyms.c
b/arch/sparc64/kernel/sparc64_ksyms.c
index 8ac0b99..b80d982 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -53,6 +53,7 @@
 #include <asm/ns87303.h>
 #include <asm/timer.h>
 #include <asm/cpudata.h>
+#include <asm/ftrace.h>

 struct poll {
        int fd;
@@ -112,7 +113,6 @@ EXPORT_SYMBOL(smp_call_function);
 #endif /* CONFIG_SMP */

 #if defined(CONFIG_MCOUNT)
-extern void _mcount(void);
 EXPORT_SYMBOL(_mcount);
 #endif


gcc version 4.3.1 (Gentoo 4.3.1 p1.0)
