From: Cong Ding <dinggnu@gmail.com>
Date: Wed, 16 Jan 2013 22:01:54 +0000
Subject: [PATCH v2] sparc: kernel/sbus.c: fix memory leakage
Message-Id: <20130116220153.GD18593@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1358199372-11976-1-git-send-email-dinggnu@gmail.com>
 <20130116211309.GA13993@merkur.ravnborg.org>
 <20130116211725.GC18593@gmail.com>
 <20130116220018.GA14063@merkur.ravnborg.org>
In-Reply-To: <20130116220018.GA14063@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

the variable iommu and strbuf are not freed if it goes to error.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 arch/sparc/kernel/sbus.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
index 1271b3a..78aa26b 100644
--- a/arch/sparc/kernel/sbus.c
+++ b/arch/sparc/kernel/sbus.c
@@ -656,6 +656,8 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	return;
 
 fatal_memory_error:
+	kfree(strbuf);
+	kfree(iommu);
 	prom_printf("sbus_iommu_init: Fatal memory allocation error.\n");
 }
 
-- 
1.7.10.4

