From: domen@coderock.org
Date: Mon, 10 Jan 2005 17:48:55 +0000
Subject: [patch 2/2] to arch/sparc64/Kconfig
Message-Id: <20050110174855.051C21F208@trashy.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Description: Remove x86-specific help in arch/sparc64/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>


Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/sparc64/Kconfig |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff -puN arch/sparc64/Kconfig~kconfig-arch_sparc64 arch/sparc64/Kconfig
--- kj/arch/sparc64/Kconfig~kconfig-arch_sparc64	2005-01-10 18:00:28.000000000 +0100
+++ kj-domen/arch/sparc64/Kconfig	2005-01-10 18:00:28.000000000 +0100
@@ -92,8 +92,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more than
+	  one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
@@ -101,17 +101,11 @@ config SMP
 	  singleprocessor machines. On a singleprocessor machine, the kernel
 	  will run faster if you say N here.
 
-	  Note that if you say Y here and choose architecture "586" or
-	  "Pentium" under "Processor family", the kernel will not work on 486
-	  architectures. Similarly, multiprocessor kernels for the "PPro"
-	  architecture may not work on all Pentium based boards.
-
 	  People using multiprocessor machines who say Y here should also say
 	  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
 	  Management" code will be disabled if you say Y here.
 
 	  See also the <file:Documentation/smp.txt>,
-	  <file:Documentation/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
 	  <http://www.tldp.org/docs.html#howto>.
 
_
