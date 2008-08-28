From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:14 +0000
Subject: [PATCH 21/49]: cs4231: Use SNDRV_DMA_TYPE_DEV instead of
Message-Id: <20080827.212414.122512951.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


cs4231: Use SNDRV_DMA_TYPE_DEV instead of SNDRV_DMA_TYPE_SBUS.

SBUS layer now uses dma_*() interfaces, no need for special DMA code
any longer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 sound/sparc/cs4231.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 1c4797b..e2be131 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1784,9 +1784,9 @@ static unsigned int sbus_dma_addr(struct cs4231_dma_control *dma_cont)
 
 static void sbus_dma_preallocate(struct snd_cs4231 *chip, struct snd_pcm *pcm)
 {
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_SBUS,
-					snd_dma_sbus_data(chip->dev_u.sdev),
-					64 * 1024, 128 * 1024);
+	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+					      &chip->dev_u.sdev->ofdev.dev,
+					      64 * 1024, 128 * 1024);
 }
 
 /*
-- 
1.5.6.5.GIT

