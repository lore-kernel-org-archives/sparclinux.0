From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 02 Nov 2016 16:36:32 +0000
Subject: [PATCH RESEND v3 1/2] config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc
Message-Id: <1478104593-189775-2-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478104593-189775-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1478104593-189775-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, peterz@infradead.org, akpm@linux-foundation.org
Cc: keescook@chromium.org, mingo@kernel.org, paulmck@linux.vnet.ibm.com, dan.j.williams@intel.com, tj@kernel.org, jpoimboe@redhat.com, nikolay@cumulusnetworks.com, dvyukov@google.com, sam@ravnborg.org, shuah@kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, rob.gardner@oracle.com, babu.moger@oracle.com

This new config parameter limits the space used for "Lock debugging:
prove locking correctness" by about 4MB. The current sparc systems have
the limitation of 32MB size for kernel size including .text, .data and
.bss sections. With PROVE_LOCKING feature, the kernel size could grow
beyond this limit and causing system boot-up issues. With this option,
kernel limits the size of the entries of lock_chains, stack_trace etc.,
so that kernel fits in required size limit. This is not visible to user
and only used for sparc.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |    1 +
 lib/Kconfig.debug  |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b23c76b..a85e51d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,6 +43,7 @@ config SPARC
 	select ARCH_HAS_SG_CHAIN
 	select CPU_NO_EFFICIENT_FFS
 	select HAVE_ARCH_HARDENED_USERCOPY
+	select PROVE_LOCKING_SMALL if PROVE_LOCKING
 
 config SPARC32
 	def_bool !64BIT
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b01e547..a6c8db1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1085,6 +1085,9 @@ config PROVE_LOCKING
 
 	 For more details, see Documentation/locking/lockdep-design.txt.
 
+config PROVE_LOCKING_SMALL
+	bool
+
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
1.7.1

