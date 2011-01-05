From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 05 Jan 2011 19:56:11 +0000
Subject: [PATCH] use __devexit not __exit in n2_unregister_algs fixes build failure on fedora
Message-Id: <1294257371-19695-1-git-send-email-dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: dennis <dennis@daedalus.ausil.us>

thanks to kylem for helping with debugging
---
 drivers/crypto/n2_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 88ee015..3372491 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1542,7 +1542,7 @@ out:
 	return err;
 }
 
-static void __exit n2_unregister_algs(void)
+static void __devexit n2_unregister_algs(void)
 {
 	mutex_lock(&spu_lock);
 	if (!--algs_registered)
-- 
1.6.6.1

