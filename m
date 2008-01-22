From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Tue, 22 Jan 2008 19:43:45 +0000
Subject: [PATCH] sparc64, openpromfs: constify function pointer tables
Message-Id: <Pine.LNX.4.64.0801222043300.5722@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
---
 arch/sparc/kernel/setup.c      |    2 +-
 arch/sparc64/kernel/setup.c    |    2 +-
 arch/sparc64/solaris/socksys.c |    2 +-
 fs/openpromfs/inode.c          |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index f822838..d07bc74 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -379,7 +379,7 @@ static void c_stop(struct seq_file *m, void *v)
 {
 }
 
-struct seq_operations cpuinfo_op = {
+const struct seq_operations cpuinfo_op = {
 	.start =c_start,
 	.next =	c_next,
 	.stop =	c_stop,
diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index 0f5be82..a813441 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -421,7 +421,7 @@ static void c_stop(struct seq_file *m, void *v)
 {
 }
 
-struct seq_operations cpuinfo_op = {
+const struct seq_operations cpuinfo_op = {
 	.start =c_start,
 	.next =	c_next,
 	.stop =	c_stop,
diff --git a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
index 7736411..5f06418 100644
--- a/arch/sparc64/solaris/socksys.c
+++ b/arch/sparc64/solaris/socksys.c
@@ -54,7 +54,7 @@ extern void mykfree(void *);
 
 static unsigned int (*sock_poll)(struct file *, poll_table *);
 
-static struct file_operations socksys_file_ops = {
+static const struct file_operations socksys_file_ops = {
 	/* Currently empty */
 };
 
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index d881738..6b7ff16 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -131,7 +131,7 @@ static void property_stop(struct seq_file *f, void *v)
 	/* Nothing to do */
 }
 
-static struct seq_operations property_op = {
+static const struct seq_operations property_op = {
 	.start		= property_start,
 	.next		= property_next,
 	.stop		= property_stop,
-- 
1.5.3.4

