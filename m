From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Wed, 23 Nov 2016 21:11:32 +0000
Subject: [PATCH] dbri: Fix compiler warning
Message-Id: <1479935492-28263-1-git-send-email-tushar.n.dave@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: perex@perex.cz, tiwai@suse.com, thomas.tai@oracle.com, alsa-devel@alsa-project.org, sparclinux@vger.kernel.org

dbri uses 'u32' for dma handle while invoking kernel DMA APIs,
instead of using dma_addr_t. This hasn't caused any 'incompatible
pointer type' warning on SPARC because until now dma_addr_t is of
type u32. However, recent changes in SPARC ATU (iommu) enabled 64bit
DMA and therefore dma_addr_t became of type u64. This makes
'incompatible pointer type' warnings inevitable.

e.g.
sound/sparc/dbri.c: In function ‘snd_dbri_create’:
sound/sparc/dbri.c:2538: warning: passing argument 3 of ‘dma_zalloc_coherent’ from incompatible pointer type
./include/linux/dma-mapping.h:608: note: expected ‘dma_addr_t *’ but argument is of type ‘u32 *’

This patch resolves above compiler warning.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
Reviewed-by: thomas tai <thomas.tai@oracle.com>
---
 sound/sparc/dbri.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 0190cb6..542c1b5 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -304,7 +304,7 @@ struct snd_dbri {
 	spinlock_t lock;
 
 	struct dbri_dma *dma;	/* Pointer to our DMA block */
-	u32 dma_dvma;		/* DBRI visible DMA address */
+	dma_addr_t dma_dvma;	/* DBRI visible DMA address */
 
 	void __iomem *regs;	/* dbri HW regs */
 	int dbri_irqp;		/* intr queue pointer */
@@ -657,12 +657,14 @@ static void dbri_cmdwait(struct snd_dbri *dbri)
  */
 static s32 *dbri_cmdlock(struct snd_dbri *dbri, int len)
 {
+	u32 dvma_addr = (u32)dbri->dma_dvma;
+
 	/* Space for 2 WAIT cmds (replaced later by 1 JUMP cmd) */
 	len += 2;
 	spin_lock(&dbri->cmdlock);
 	if (dbri->cmdptr - dbri->dma->cmd + len < DBRI_NO_CMDS - 2)
 		return dbri->cmdptr + 2;
-	else if (len < sbus_readl(dbri->regs + REG8) - dbri->dma_dvma)
+	else if (len < sbus_readl(dbri->regs + REG8) - dvma_addr)
 		return dbri->dma->cmd;
 	else
 		printk(KERN_ERR "DBRI: no space for commands.");
@@ -680,6 +682,7 @@ static s32 *dbri_cmdlock(struct snd_dbri *dbri, int len)
  */
 static void dbri_cmdsend(struct snd_dbri *dbri, s32 *cmd, int len)
 {
+	u32 dvma_addr = (u32)dbri->dma_dvma;
 	s32 tmp, addr;
 	static int wait_id = 0;
 
@@ -689,7 +692,7 @@ static void dbri_cmdsend(struct snd_dbri *dbri, s32 *cmd, int len)
 	*(cmd+1) = DBRI_CMD(D_WAIT, 1, wait_id);
 
 	/* Replace the last command with JUMP */
-	addr = dbri->dma_dvma + (cmd - len - dbri->dma->cmd) * sizeof(s32);
+	addr = dvma_addr + (cmd - len - dbri->dma->cmd) * sizeof(s32);
 	*(dbri->cmdptr+1) = addr;
 	*(dbri->cmdptr) = DBRI_CMD(D_JUMP, 0, 0);
 
@@ -747,6 +750,7 @@ static void dbri_reset(struct snd_dbri *dbri)
 /* Lock must not be held before calling this */
 static void dbri_initialize(struct snd_dbri *dbri)
 {
+	u32 dvma_addr = (u32)dbri->dma_dvma;
 	s32 *cmd;
 	u32 dma_addr;
 	unsigned long flags;
@@ -764,7 +768,7 @@ static void dbri_initialize(struct snd_dbri *dbri)
 	/*
 	 * Initialize the interrupt ring buffer.
 	 */
-	dma_addr = dbri->dma_dvma + dbri_dma_off(intr, 0);
+	dma_addr = dvma_addr + dbri_dma_off(intr, 0);
 	dbri->dma->intr[0] = dma_addr;
 	dbri->dbri_irqp = 1;
 	/*
@@ -778,7 +782,7 @@ static void dbri_initialize(struct snd_dbri *dbri)
 	dbri->cmdptr = cmd;
 	*(cmd++) = DBRI_CMD(D_WAIT, 1, 0);
 	*(cmd++) = DBRI_CMD(D_WAIT, 1, 0);
-	dma_addr = dbri->dma_dvma + dbri_dma_off(cmd, 0);
+	dma_addr = dvma_addr + dbri_dma_off(cmd, 0);
 	sbus_writel(dma_addr, dbri->regs + REG8);
 	spin_unlock(&dbri->cmdlock);
 
@@ -1077,6 +1081,7 @@ static void recv_fixed(struct snd_dbri *dbri, int pipe, volatile __u32 *ptr)
 static int setup_descs(struct snd_dbri *dbri, int streamno, unsigned int period)
 {
 	struct dbri_streaminfo *info = &dbri->stream_info[streamno];
+	u32 dvma_addr = (u32)dbri->dma_dvma;
 	__u32 dvma_buffer;
 	int desc;
 	int len;
@@ -1177,7 +1182,7 @@ static int setup_descs(struct snd_dbri *dbri, int streamno, unsigned int period)
 		else {
 			dbri->next_desc[last_desc] = desc;
 			dbri->dma->desc[last_desc].nda -			    dbri->dma_dvma + dbri_dma_off(desc, desc);
+			    dvma_addr + dbri_dma_off(desc, desc);
 		}
 
 		last_desc = desc;
@@ -1192,7 +1197,7 @@ static int setup_descs(struct snd_dbri *dbri, int streamno, unsigned int period)
 	}
 
 	dbri->dma->desc[last_desc].nda -	    dbri->dma_dvma + dbri_dma_off(desc, first_desc);
+	    dvma_addr + dbri_dma_off(desc, first_desc);
 	dbri->next_desc[last_desc] = first_desc;
 	dbri->pipes[info->pipe].first_desc = first_desc;
 	dbri->pipes[info->pipe].desc = first_desc;
@@ -1697,6 +1702,7 @@ calling dbri_process_interrupt_buffer(), which works even if the CPU's
 static void xmit_descs(struct snd_dbri *dbri)
 {
 	struct dbri_streaminfo *info;
+	u32 dvma_addr = (u32)dbri->dma_dvma;
 	s32 *cmd;
 	unsigned long flags;
 	int first_td;
@@ -1718,7 +1724,7 @@ static void xmit_descs(struct snd_dbri *dbri)
 			*(cmd++) = DBRI_CMD(D_SDP, 0,
 					    dbri->pipes[info->pipe].sdp
 					    | D_SDP_P | D_SDP_EVERY | D_SDP_C);
-			*(cmd++) = dbri->dma_dvma +
+			*(cmd++) = dvma_addr +
 				   dbri_dma_off(desc, first_td);
 			dbri_cmdsend(dbri, cmd, 2);
 
@@ -1740,7 +1746,7 @@ static void xmit_descs(struct snd_dbri *dbri)
 			*(cmd++) = DBRI_CMD(D_SDP, 0,
 					    dbri->pipes[info->pipe].sdp
 					    | D_SDP_P | D_SDP_EVERY | D_SDP_C);
-			*(cmd++) = dbri->dma_dvma +
+			*(cmd++) = dvma_addr +
 				   dbri_dma_off(desc, first_td);
 			dbri_cmdsend(dbri, cmd, 2);
 
@@ -2539,7 +2545,7 @@ static int snd_dbri_create(struct snd_card *card,
 	if (!dbri->dma)
 		return -ENOMEM;
 
-	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08x)\n",
+	dprintk(D_GEN, "DMA Cmd Block 0x%p (0x%08llx)\n",
 		dbri->dma, dbri->dma_dvma);
 
 	/* Map the registers into memory. */
-- 
1.9.1

