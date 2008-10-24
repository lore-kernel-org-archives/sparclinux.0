From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Fri, 24 Oct 2008 07:06:24 +0000
Subject: [PATCH] dbri: check dma_alloc_coherent errors
Message-Id: <20081024160644C.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Needs to check for dma_alloc_coherent() allocation failure.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 sound/sparc/dbri.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index c257ad8..23ed6f0 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2534,6 +2534,8 @@ static int __devinit snd_dbri_create(struct snd_card *card,
 	dbri->dma = dma_alloc_coherent(&op->dev,
 				       sizeof(struct dbri_dma),
 				       &dbri->dma_dvma, GFP_ATOMIC);
+	if (!dbri->dma)
+		return -ENOMEM;
 	memset((void *)dbri->dma, 0, sizeof(struct dbri_dma));
 
 	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
-- 
1.5.5.GIT

