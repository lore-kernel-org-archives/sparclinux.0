From: David Miller <davem@davemloft.net>
Date: Sat, 23 Oct 2010 18:06:24 +0000
Subject: [PATCH] jump_label: Fix unaligned traps on sparc.
Message-Id: <20101023.110624.226758370.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: jbaron@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


The vmlinux.lds.h knobs to emit the __jump_table section in the main
kernel image takes care to align the section, but this doesn't help
for the __jump_table section that gets emitted into modules.

Fix the resulting lack of section alignment by explicitly specifying
it in the assembler.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
index 62e66d7..d95cf44 100644
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -14,6 +14,7 @@
 			 "nop\n\t"				\
 			 "nop\n\t"				\
 			 ".pushsection __jump_table,  \"a\"\n\t"\
+			 ".align 4\n\t"				\
 			 ".word 1b, %l[" #label "], %c0\n\t"	\
 			 ".popsection \n\t"			\
 			 : :  "i" (key) :  : label);\
