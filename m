From: Firoz Khan <firoz.khan@linaro.org>
Date: Wed, 02 Jan 2019 15:53:42 +0000
Subject: [PATCH 1/3] sparc: remove nargs from __SYSCALL
Message-Id: <1546444373-21386-2-git-send-email-firoz.khan@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546444373-21386-1-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>, Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org

The __SYSCALL macro's arguments are system call number,
system call entry name and number of arguments for the
system call.

Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
calculated nor used anywhere. So it would be better to
keep the implementaion as  __SYSCALL(nr, entry). This will
unifies the implementation with some other architetures
too.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/kernel/syscalls/syscalltbl.sh | 4 ++--
 arch/sparc/kernel/systbls_32.S           | 2 +-
 arch/sparc/kernel/systbls_64.S           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/syscalls/syscalltbl.sh b/arch/sparc/kernel/syscalls/syscalltbl.sh
index 77cf014..ffe954b 100644
--- a/arch/sparc/kernel/syscalls/syscalltbl.sh
+++ b/arch/sparc/kernel/syscalls/syscalltbl.sh
@@ -13,10 +13,10 @@ emit() {
 	t_entry="$3"
 
 	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s, sys_nis_syscall, )\n" "${t_nxt}"
+		printf "__SYSCALL(%s,sys_nis_syscall)\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
 	done
-	printf "__SYSCALL(%s, %s, )\n" "${t_nxt}" "${t_entry}"
+	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
 }
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index ab9e4d5..391a49a 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -9,7 +9,7 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
-#define __SYSCALL(nr, entry, nargs) .long entry
+#define __SYSCALL(nr, entry)	.long entry
 	.data
 	.align 4
 	.globl sys_call_table
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index a27394b..08ce7cb 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -10,7 +10,7 @@
  * Copyright (C) 1995 Adrian M. Rodriguez (adrian@remus.rutgers.edu)
  */
 
-#define __SYSCALL(nr, entry, nargs) .word entry
+#define __SYSCALL(nr, entry)	.word entry
 	.text
 	.align	4
 #ifdef CONFIG_COMPAT
-- 
1.9.1
