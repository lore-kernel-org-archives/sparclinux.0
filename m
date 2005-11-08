From: Tobias Klauser <tklauser@nuerscht.ch>
Date: Tue, 08 Nov 2005 20:18:24 +0000
Subject: [PATCH] arch/sparc64: Use ARRAY_SIZE macro
Message-Id: <20051108201824.GB7935@neon.tklauser.home>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Use ARRAY_SIZE macro instead of sizeof(x)/sizeof(x[0]) and remove a
duplicate of ARRAY_SIZE which is never used anyways.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

---

 kernel/cpu.c  |    4 ++--
 kernel/sbus.c |    2 +-
 mm/fault.c    |    2 --
 3 files changed, 3 insertions(+), 5 deletions(-)

diff -X dontdiff -urpN linux-2.6.14/arch/sparc64/kernel/cpu.c linux-2.6.14~array_size/arch/sparc64/kernel/cpu.c
--- linux-2.6.14/arch/sparc64/kernel/cpu.c	2005-10-28 08:56:26.000000000 +0200
+++ linux-2.6.14~array_size/arch/sparc64/kernel/cpu.c	2005-11-08 10:34:58.000000000 +0100
@@ -43,7 +43,7 @@ struct cpu_fp_info linux_sparc_fpu[] = {
   { 0x3e, 0x22, 0, "UltraSparc IIIi+ integrated FPU"},
 };
 
-#define NSPARCFPU  (sizeof(linux_sparc_fpu)/sizeof(struct cpu_fp_info))
+#define NSPARCFPU  ARRAY_SIZE(linux_sparc_fpu)
 
 struct cpu_iu_info linux_sparc_chips[] = {
   { 0x17, 0x10, "TI UltraSparc I   (SpitFire)"},
@@ -59,7 +59,7 @@ struct cpu_iu_info linux_sparc_chips[]    { 0x3e, 0x22, "TI UltraSparc IIIi+ (Serrano)"},
 };
 
-#define NSPARCCHIPS  (sizeof(linux_sparc_chips)/sizeof(struct cpu_iu_info))
+#define NSPARCCHIPS  ARRAY_SIZE(linux_sparc_chips)
 
 char *sparc_cpu_type = "cpu-oops";
 char *sparc_fpu_type = "fpu-oops";
diff -X dontdiff -urpN linux-2.6.14/arch/sparc64/kernel/sbus.c linux-2.6.14~array_size/arch/sparc64/kernel/sbus.c
--- linux-2.6.14/arch/sparc64/kernel/sbus.c	2005-10-28 08:56:26.000000000 +0200
+++ linux-2.6.14~array_size/arch/sparc64/kernel/sbus.c	2005-11-08 10:33:03.000000000 +0100
@@ -790,7 +790,7 @@ static unsigned long sysio_irq_offsets[]
 
 #undef bogon
 
-#define NUM_SYSIO_OFFSETS (sizeof(sysio_irq_offsets) / sizeof(sysio_irq_offsets[0]))
+#define NUM_SYSIO_OFFSETS ARRAY_SIZE(sysio_irq_offsets)
 
 /* Convert Interrupt Mapping register pointer to associated
  * Interrupt Clear register pointer, SYSIO specific version.
diff -X dontdiff -urpN linux-2.6.14/arch/sparc64/mm/fault.c linux-2.6.14~array_size/arch/sparc64/mm/fault.c
--- linux-2.6.14/arch/sparc64/mm/fault.c	2005-10-28 08:56:26.000000000 +0200
+++ linux-2.6.14~array_size/arch/sparc64/mm/fault.c	2005-11-08 10:33:39.000000000 +0100
@@ -30,8 +30,6 @@
 #include <asm/sections.h>
 #include <asm/kdebug.h>
 
-#define ELEMENTS(arr) (sizeof (arr)/sizeof (arr[0]))
-
 /*
  * To debug kernel to catch accesses to certain virtual/physical addresses.
  * Mode = 0 selects physical watchpoints, mode = 1 selects virtual watchpoints.
