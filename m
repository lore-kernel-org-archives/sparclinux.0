From: Meelis Roos <mroos@linux.ee>
Date: Mon, 24 May 2004 11:34:46 +0000
Subject: [PATCH] Make 32 CPUs the default for SMP
Message-Id: <Pine.GSO.4.44.0405241432420.8614-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

arch/sparc64/kernel/smp.c:424:2: #error Fixup cheetah_xcall_deliver Dave...

As 32 CPU-s is currently the max supported value, I suggest this patch:

=== arch/sparc64/Kconfig 1.51 vs edited ==--- 1.51/arch/sparc64/Kconfig	2004-04-12 00:08:29 +03:00
+++ edited/arch/sparc64/Kconfig	2004-05-24 14:33:47 +03:00
@@ -130,7 +130,7 @@
 	int "Maximum number of CPUs (2-64)"
 	range 2 64
 	depends on SMP
-	default "64"
+	default "32"

 config CPU_FREQ
 	bool "CPU Frequency scaling"

-- 
Meelis Roos (mroos@linux.ee)

