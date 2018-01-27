From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sat, 27 Jan 2018 08:10:59 +0000
Subject: [PATCH -next] oradax: Fix return value check in dax_attach()
Message-Id: <1517040659-37838-1-git-send-email-weiyongjun1@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

In case of error, the function class_create() returns ERR_PTR() and
never returns NULL. The NULL test in the return value check should be
replaced with IS_ERR().

Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/sbus/char/oradax.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 10452ae..03dc047 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -336,9 +336,9 @@ static int __init dax_attach(void)
 	}
 
 	cl = class_create(THIS_MODULE, DAX_NAME);
-	if (cl = NULL) {
+	if (IS_ERR(cl)) {
 		dax_err("class_create failed");
-		ret = -ENXIO;
+		ret = PTR_ERR(cl);
 		goto class_error;
 	}

