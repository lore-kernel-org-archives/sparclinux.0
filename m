From: Paul Jackson <pj@sgi.com>
Date: Fri, 09 Dec 2005 11:51:26 +0000
Subject: [PATCH] sparc32 block needed in final image link build fix
Message-Id: <20051209115126.3286.25224.sendpatchset@jackhammer.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: sparclinux@vger.kernel.org, Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, wli@holomorphy.com

With this fix, sparc links vmlinuz again using crosstool.
Without this fix, the final link fails missing several dozen
dozen symbols, beginning with:

    kernel/built-in.o(.text+0x6fd0): In function `do_exit':
    : undefined reference to `exit_io_context'

(exit_io_context is defined in block/ll_rw_blk.c).

No further testing whatsoever was done after the link succeeded.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 arch/sparc/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.15-rc3-mm1.orig/arch/sparc/Makefile	2005-12-04 01:42:16.842337555 -0800
+++ 2.6.15-rc3-mm1/arch/sparc/Makefile	2005-12-09 03:38:53.226046309 -0800
@@ -34,7 +34,7 @@ libs-y += arch/sparc/prom/ arch/sparc/li
 # Renaming is done to avoid confusing pattern matching rules in 2.5.45 (multy-)
 INIT_Y		:= $(patsubst %/, %/built-in.o, $(init-y))
 CORE_Y		:= $(core-y)
-CORE_Y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
+CORE_Y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
 CORE_Y		:= $(patsubst %/, %/built-in.o, $(CORE_Y))
 DRIVERS_Y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
 NET_Y		:= $(patsubst %/, %/built-in.o, $(net-y))

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
