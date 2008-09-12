From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 22:04:20 +0000
Subject: [PATCH]: Fix for user regsets.
Message-Id: <20080912.150420.187307290.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I pushed this to sparc-next-2.6 instead of sparc-2.6 because it's
not such a dire bug that it needs to go to 2.6.27 right now.  It
just means that binfmt_elf.c does a 6K allocation to dump the FPU
registers instead of ~800.

sparc: Fix user_regset 'n' field values.

As noticed by Russell King, we were not setting this properly
to the number of entries, but rather the total size.

This results in the core dumping code allocating waayyyy too
much memory.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ptrace.c   |    4 ++--
 arch/sparc64/kernel/ptrace.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/ptrace.c b/arch/sparc/kernel/ptrace.c
index 20699c7..8ce6285 100644
--- a/arch/sparc/kernel/ptrace.c
+++ b/arch/sparc/kernel/ptrace.c
@@ -288,7 +288,7 @@ static const struct user_regset sparc32_regsets[] = {
 	 */
 	[REGSET_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = 38 * sizeof(u32),
+		.n = 38,
 		.size = sizeof(u32), .align = sizeof(u32),
 		.get = genregs32_get, .set = genregs32_set
 	},
@@ -304,7 +304,7 @@ static const struct user_regset sparc32_regsets[] = {
 	 */
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG,
-		.n = 99 * sizeof(u32),
+		.n = 99,
 		.size = sizeof(u32), .align = sizeof(u32),
 		.get = fpregs32_get, .set = fpregs32_set
 	},
diff --git a/arch/sparc64/kernel/ptrace.c b/arch/sparc64/kernel/ptrace.c
index db2ddf2..f43adbc 100644
--- a/arch/sparc64/kernel/ptrace.c
+++ b/arch/sparc64/kernel/ptrace.c
@@ -443,7 +443,7 @@ static const struct user_regset sparc64_regsets[] = {
 	 */
 	[REGSET_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = 36 * sizeof(u64),
+		.n = 36,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.get = genregs64_get, .set = genregs64_set
 	},
@@ -455,7 +455,7 @@ static const struct user_regset sparc64_regsets[] = {
 	 */
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG,
-		.n = 35 * sizeof(u64),
+		.n = 35,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.get = fpregs64_get, .set = fpregs64_set
 	},
@@ -801,7 +801,7 @@ static const struct user_regset sparc32_regsets[] = {
 	 */
 	[REGSET_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = 38 * sizeof(u32),
+		.n = 38,
 		.size = sizeof(u32), .align = sizeof(u32),
 		.get = genregs32_get, .set = genregs32_set
 	},
@@ -817,7 +817,7 @@ static const struct user_regset sparc32_regsets[] = {
 	 */
 	[REGSET_FP] = {
 		.core_note_type = NT_PRFPREG,
-		.n = 99 * sizeof(u32),
+		.n = 99,
 		.size = sizeof(u32), .align = sizeof(u32),
 		.get = fpregs32_get, .set = fpregs32_set
 	},
-- 
1.5.6.5.GIT

