From: Jason Baron <jbaron@akamai.com>
Date: Wed, 06 Jul 2016 21:42:32 +0000
Subject: [PATCH v3 3/7] sparc: support static_key usage in non-module __exit sections
Message-Id: <d822da427ab07a02a394602eca687104ff682f83.1467837322.git.jbaron@akamai.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1467837322.git.jbaron@akamai.com>
In-Reply-To: <cover.1467837322.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

The jump table can reference text found in an __exit section. Thus,
instead of discarding it at build/link time, include EXIT_TEXT as part
of __init and release it at system boot time.

Without this patch the link fails with:

    `.exit.text' referenced in section `__jump_table' of xxx.o:
    defined in discarded section `.exit.text' of xxx.o

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 arch/sparc/kernel/vmlinux.lds.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 7d02b1fef025..d79b3b734245 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -150,6 +150,13 @@ SECTIONS
 	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
+#ifdef CONFIG_JUMP_LABEL
+	. = ALIGN(PAGE_SIZE);
+	.exit.text : {
+		EXIT_TEXT
+	}
+#endif
+
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 	BSS_SECTION(0, 0, 0)
-- 
2.6.1

