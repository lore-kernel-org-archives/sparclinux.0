From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 20 Apr 2018 18:48:25 +0000
Subject: [PATCH] sparc64: Fix mistake in oradax license text
Message-Id: <1524250105-44243-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The license text in both oradax files mistakenly specifies "version 3" of
the GNU General Public License.  This is corrected to specify "version 2".

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
---
 arch/sparc/include/uapi/asm/oradax.h |    2 +-
 drivers/sbus/char/oradax.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/oradax.h b/arch/sparc/include/uapi/asm/oradax.h
index 7229519..4f6676f 100644
--- a/arch/sparc/include/uapi/asm/oradax.h
+++ b/arch/sparc/include/uapi/asm/oradax.h
@@ -3,7 +3,7 @@
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
+ * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 96b4ad7..719d5fe 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -3,7 +3,7 @@
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
+ * the Free Software Foundation, either version 2 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
-- 
1.7.1

