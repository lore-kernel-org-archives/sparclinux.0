From: David Miller <davem@davemloft.net>
Date: Sat, 14 Apr 2007 05:01:19 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070413.220119.115498726.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 13 Apr 2007 23:10:46 -0500

> Here you go. Doesn't seem to make much difference. The only difference I
> see is this:
> 
> ESP: tgt[0] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]

I need to have my head examined :-)

Please try this patch:

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index 989b022..b500961 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -174,7 +174,7 @@ static void esp_enable_interrupts(struct esp *esp)
 {
 	u32 val = dma_read32(DMA_CSR);
 
-	dma_write32(val & ~DMA_INT_ENAB, DMA_CSR);
+	dma_write32(val | DMA_INT_ENAB, DMA_CSR);
 }
 
 static int esp_interrupt_pending(struct esp *esp)
