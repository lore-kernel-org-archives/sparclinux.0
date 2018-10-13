From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 13 Oct 2018 10:26:53 +0000
Subject: [PATCH] sparc: vDSO: Silence an uninitialized variable warning
Message-Id: <20181013102653.GE16086@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Smatch complains that "val" would be uninitialized if kstrtoul() fails.

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/sparc/vdso/vma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index f51595f861b8..5eaff3c1aa0c 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -262,7 +262,9 @@ static __init int vdso_setup(char *s)
 	unsigned long val;
 
 	err = kstrtoul(s, 10, &val);
+	if (err)
+		return err;
 	vdso_enabled = val;
-	return err;
+	return 0;
 }
 __setup("vdso=", vdso_setup);
-- 
2.18.0
