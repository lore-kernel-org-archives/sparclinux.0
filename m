From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 14 Oct 2005 20:45:24 +0000
Subject: [PATCH] fix qlogicpti INQUIRY sniffing (was Re: qlogicpti kernel
Message-Id: <20051014.134524.132414794.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This should fix it.  Tom, give this a test on your box.
Thanks.

diff-tree f75884d28a6eae5a422d0454b982da3842f777af (from 688cb30bdc3e398d97682a6a58f825821ee838c2)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Fri Oct 14 13:44:32 2005 -0700

    [QLOGICPTI]: Handle INQUIRY response sniffing correctly.
    
    These days, in 2.6.x, even INQUIRY commands are sent using
    scatter gather lists.
    
    Bug reported by Tom 'spot' Callaway.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index a917ab7..1fd5fc6 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1119,6 +1119,36 @@ static inline void update_can_queue(stru
 	host->sg_tablesize = QLOGICPTI_MAX_SG(num_free);
 }
 
+static unsigned int scsi_rbuf_get(struct scsi_cmnd *cmd, unsigned char **buf_out)
+{
+	unsigned char *buf;
+	unsigned int buflen;
+
+	if (cmd->use_sg) {
+		struct scatterlist *sg;
+
+		sg = (struct scatterlist *) cmd->request_buffer;
+		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
+		buflen = sg->length;
+	} else {
+		buf = cmd->request_buffer;
+		buflen = cmd->request_bufflen;
+	}
+
+	*buf_out = buf;
+	return buflen;
+}
+
+static void scsi_rbuf_put(struct scsi_cmnd *cmd, unsigned char *buf)
+{
+	if (cmd->use_sg) {
+		struct scatterlist *sg;
+
+		sg = (struct scatterlist *) cmd->request_buffer;
+		kunmap_atomic(buf - sg->offset, KM_IRQ0);
+	}
+}
+
 /*
  * Until we scan the entire bus with inquiries, go throught this fella...
  */
@@ -1145,11 +1175,9 @@ static void ourdone(struct scsi_cmnd *Cm
 		int ok = host_byte(Cmnd->result) = DID_OK;
 		if (Cmnd->cmnd[0] = 0x12 && ok) {
 			unsigned char *iqd;
+			unsigned int iqd_len;
 
-			if (Cmnd->use_sg != 0)
-				BUG();
-
-			iqd = ((unsigned char *)Cmnd->buffer);
+			iqd_len = scsi_rbuf_get(Cmnd, &iqd);
 
 			/* tags handled in midlayer */
 			/* enable sync mode? */
@@ -1163,6 +1191,9 @@ static void ourdone(struct scsi_cmnd *Cm
 			if (iqd[7] & 0x20) {
 				qpti->dev_param[tgt].device_flags |= 0x20;
 			}
+
+			scsi_rbuf_put(Cmnd, iqd);
+
 			qpti->sbits |= (1 << tgt);
 		} else if (!ok) {
 			qpti->sbits |= (1 << tgt);
