From: Christoph Hellwig <hch@lst.de>
Date: Mon, 31 May 2004 20:10:44 +0000
Subject: Re: RFC: defining sbus dma direction bits in terms of enum dma_data_direction?
Message-Id: <20040531201044.GA23680@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531124455.GA16822@lst.de>
In-Reply-To: <20040531124455.GA16822@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 31, 2004 at 12:36:14PM -0700, David S. Miller wrote:
> On Mon, 31 May 2004 14:44:55 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Any chance to switch sbus over to using it aswell?
> 
> If you submit a patch, I'll integrate it and munge it until it
> builds :-)

Okay, here's a patch to switch sbus dma directions to use the generic
bits and kill all three users of scsi_to_sbus_dma direction.

BTW, should we keep the defintion because we're in stable series, or
does sbus not count as published interface? :)


--- 1.13/drivers/fc4/fc.c	2004-01-05 20:02:48 +01:00
+++ edited/drivers/fc4/fc.c	2004-05-31 22:06:59 +02:00
@@ -59,8 +59,6 @@
 #define dma_unmap_single(d,h,s,dir) sbus_unmap_single(d,h,s,dir)
 #define dma_map_sg(d,s,n,dir) sbus_map_sg(d,s,n,dir)
 #define dma_unmap_sg(d,s,n,dir) sbus_unmap_sg(d,s,n,dir)
-#define scsi_to_fc_dma_dir(dir)	scsi_to_sbus_dma_dir(dir)
-#define FC_DMA_BIDIRECTIONAL	SBUS_DMA_BIDIRECTIONAL
 #else
 #define dma_alloc_consistent(d,s,p) pci_alloc_consistent(d,s,p)
 #define dma_free_consistent(d,s,v,h) pci_free_consistent(d,s,v,h)
@@ -68,8 +66,6 @@
 #define dma_unmap_single(d,h,s,dir) pci_unmap_single(d,h,s,dir)
 #define dma_map_sg(d,s,n,dir) pci_map_sg(d,s,n,dir)
 #define dma_unmap_sg(d,s,n,dir) pci_unmap_sg(d,s,n,dir)
-#define scsi_to_fc_dma_dir(dir)	scsi_to_pci_dma_dir(dir)
-#define FC_DMA_BIDIRECTIONAL	PCI_DMA_BIDIRECTIONAL
 #endif							       
 
 #define FCP_CMND(SCpnt) ((fcp_cmnd *)&(SCpnt->SCp))
@@ -167,7 +163,7 @@
 			fcmd = l->fcmds + i;
 			plogi = l->logi + 3 * i;
 			dma_unmap_single (fc->dev, fcmd->cmd, 3 * sizeof(logi),
-					  FC_DMA_BIDIRECTIONAL);
+					  DMA_BIDIRECTIONAL);
 			plogi->code = LS_PLOGI;
 			memcpy (&plogi->nport_wwn, &fc->wwn_nport, sizeof(fc_wwn));
 			memcpy (&plogi->node_wwn, &fc->wwn_node, sizeof(fc_wwn));
@@ -188,7 +184,7 @@
 			}
 #endif			
 			fcmd->cmd = dma_map_single (fc->dev, plogi, 3 * sizeof(logi),
-						    FC_DMA_BIDIRECTIONAL);
+						    DMA_BIDIRECTIONAL);
 			fcmd->rsp = fcmd->cmd + 2 * sizeof(logi);
 			if (fc->hw_enque (fc, fcmd))
 				printk ("FC: Cannot enque PLOGI packet on %s\n", fc->name);
@@ -212,7 +208,7 @@
 		case FC_STATUS_OK:
 			plogi = l->logi + 3 * i;
 			dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi),
-					  FC_DMA_BIDIRECTIONAL);
+					  DMA_BIDIRECTIONAL);
 			if (!fc->wwn_dest.lo && !fc->wwn_dest.hi) {
 				memcpy (&fc->wwn_dest, &plogi[1].node_wwn, sizeof(fc_wwn)); 
 				FCD(("Dest WWN %08x%08x\n", *(u32 *)&fc->wwn_dest, fc->wwn_dest.lo))
@@ -231,7 +227,7 @@
 		case FC_STATUS_ERR_OFFLINE:
 			fc->state = FC_STATE_OFFLINE;
 			dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi),
-					  FC_DMA_BIDIRECTIONAL);
+					  _DMA_BIDIRECTIONAL);
 			printk ("%s: FC is offline\n", fc->name);
 			if (atomic_dec_and_test (&l->todo))
 				up(&l->sem);
@@ -256,7 +252,7 @@
 	switch (status) {
 	case FC_STATUS_OK: /* Ok, let's have a fun on a loop */
 		dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi),
-				  FC_DMA_BIDIRECTIONAL);
+				  DMA_BIDIRECTIONAL);
 		p = (fc_al_posmap *)(l->logi + 3 * i);
 #ifdef FCDEBUG
 		{
@@ -306,7 +302,7 @@
 		FCD(("SID %d DID %d\n", fc->sid, fc->did))
 		fcmd = l->fcmds + i;
 		dma_unmap_single(fc->dev, fcmd->cmd, 3 * sizeof(logi),
-				 FC_DMA_BIDIRECTIONAL);
+				 DMA_BIDIRECTIONAL);
 		fch = &fcmd->fch;
 		memset(l->logi + 3 * i, 0, 3 * sizeof(logi));
 		FILL_FCHDR_RCTL_DID(fch, R_CTL_ELS_REQ, FS_FABRIC_F_PORT);
@@ -317,7 +313,7 @@
 		fch->param = 0;
 		l->logi [3 * i].code = LS_FLOGI;
 		fcmd->cmd = dma_map_single (fc->dev, l->logi + 3 * i, 3 * sizeof(logi),
-					    FC_DMA_BIDIRECTIONAL);
+					    DMA_BIDIRECTIONAL);
 		fcmd->rsp = fcmd->cmd + sizeof(logi);
 		fcmd->cmdlen = sizeof(logi);
 		fcmd->rsplen = sizeof(logi);
@@ -434,11 +430,12 @@
 		
 		if (fcmd->data) {
 			if (SCpnt->use_sg)
-				dma_unmap_sg(fc->dev, (struct scatterlist *)SCpnt->buffer, SCpnt->use_sg,
-					     scsi_to_fc_dma_dir(SCpnt->sc_data_direction));
+				dma_unmap_sg(fc->dev, (struct scatterlist *)SCpnt->buffer,
+						SCpnt->use_sg,
+						SCpnt->sc_data_direction);
 			else
 				dma_unmap_single(fc->dev, fcmd->data, SCpnt->request_bufflen,
-						 scsi_to_fc_dma_dir(SCpnt->sc_data_direction));
+						 SCpnt->sc_data_direction);
 		}
 		break;
 	default:
@@ -579,7 +576,7 @@
 		fc->ls = (void *)l;
 		/* Assumes sizeof(fc_al_posmap) < 3 * sizeof(logi), which is true */
 		fcmd->cmd = dma_map_single (fc->dev, l->logi + 3 * i, 3 * sizeof(logi),
-					    FC_DMA_BIDIRECTIONAL);
+					    DMA_BIDIRECTIONAL);
 		fcmd->proto = PROTO_REPORT_AL_MAP;
 		fcmd->token = i;
 		fcmd->fc = fc;
@@ -598,7 +595,7 @@
 				} else {
 					fc->state = FC_STATE_OFFLINE;
 					enable_irq(fc->irq);
-					dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi), FC_DMA_BIDIRECTIONAL);
+					dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi), DMA_BIDIRECTIONAL);
 					if (atomic_dec_and_test (&l->todo))
 						goto all_done;
 				}
@@ -615,7 +612,7 @@
 
 				FCD(("SID %d DID %d\n", fc->sid, fc->did))
 				fcmd = l->fcmds + i;
-				dma_unmap_single(fc->dev, fcmd->cmd, 3 * sizeof(logi), FC_DMA_BIDIRECTIONAL);
+				dma_unmap_single(fc->dev, fcmd->cmd, 3 * sizeof(logi), DMA_BIDIRECTIONAL);
 				fch = &fcmd->fch;
 				FILL_FCHDR_RCTL_DID(fch, R_CTL_ELS_REQ, FS_FABRIC_F_PORT);
 				FILL_FCHDR_SID(fch, 0);
@@ -624,7 +621,7 @@
 				FILL_FCHDR_OXRX(fch, 0xffff, 0xffff);
 				fch->param = 0;
 				l->logi [3 * i].code = LS_FLOGI;
-				fcmd->cmd = dma_map_single (fc->dev, l->logi + 3 * i, 3 * sizeof(logi), FC_DMA_BIDIRECTIONAL);
+				fcmd->cmd = dma_map_single (fc->dev, l->logi + 3 * i, 3 * sizeof(logi), DMA_BIDIRECTIONAL);
 				fcmd->rsp = fcmd->cmd + sizeof(logi);
 				fcmd->cmdlen = sizeof(logi);
 				fcmd->rsplen = sizeof(logi);
@@ -652,7 +649,7 @@
 		switch (fc->state) {
 		case FC_STATE_ONLINE: break;
 		case FC_STATE_OFFLINE: break;
-		default: dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi), FC_DMA_BIDIRECTIONAL);
+		default: dma_unmap_single (fc->dev, l->fcmds[i].cmd, 3 * sizeof(logi), DMA_BIDIRECTIONAL);
 			break;
 		}
 	}
@@ -821,14 +818,14 @@
 				cmd->fcp_data_len = SCpnt->request_bufflen;
 				fcmd->data = dma_map_single (fc->dev, (char *)SCpnt->request_buffer,
 							     SCpnt->request_bufflen,
-							     scsi_to_fc_dma_dir(SCpnt->sc_data_direction));
+							     SCpnt->sc_data_direction);
 			} else {
 				struct scatterlist *sg = (struct scatterlist *)SCpnt->buffer;
 				int nents;
 
 				FCD(("XXX: Use_sg %d %d\n", SCpnt->use_sg, sg->length))
 				nents = dma_map_sg (fc->dev, sg, SCpnt->use_sg,
-						    scsi_to_fc_dma_dir(SCpnt->sc_data_direction));
+						    SCpnt->sc_data_direction);
 				if (nents > 1) printk ("%s: SG for nents %d (use_sg %d) not handled yet\n", fc->name, nents, SCpnt->use_sg);
 				fcmd->data = sg_dma_address(sg);
 				cmd->fcp_data_len = sg_dma_len(sg);
@@ -1065,7 +1062,7 @@
 	FILL_FCHDR_SEQ_DF_SEQ(fch, 0, 0, 0);
 	FILL_FCHDR_OXRX(fch, 0xffff, 0xffff);
 	fch->param = 0;
-	fcmd->cmd = dma_map_single (fc->dev, data, 2 * len, FC_DMA_BIDIRECTIONAL);
+	fcmd->cmd = dma_map_single (fc->dev, data, 2 * len, DMA_BIDIRECTIONAL);
 	fcmd->rsp = fcmd->cmd + len;
 	fcmd->cmdlen = len;
 	fcmd->rsplen = len;
@@ -1100,7 +1097,7 @@
 	
 	clear_bit(fcmd->token, fc->scsi_bitmap);
 	fc->scsi_free++;
-	dma_unmap_single (fc->dev, fcmd->cmd, 2 * len, FC_DMA_BIDIRECTIONAL);
+	dma_unmap_single (fc->dev, fcmd->cmd, 2 * len, DMA_BIDIRECTIONAL);
 	return l.status;
 }
 
--- 1.35/drivers/scsi/esp.c	2004-01-05 20:02:48 +01:00
+++ edited/drivers/scsi/esp.c	2004-05-31 21:54:20 +02:00
@@ -1437,7 +1437,7 @@
 		if (sp->request_bufflen) {
 			sp->SCp.have_data_in = sbus_map_single(esp->sdev, sp->SCp.buffer,
 							       sp->SCp.this_residual,
-							       scsi_to_sbus_dma_dir(sp->sc_data_direction));
+							       sp->sc_data_direction);
 			sp->SCp.ptr = (char *) ((unsigned long)sp->SCp.have_data_in);
 		} else {
 			sp->SCp.ptr = NULL;
@@ -1447,7 +1447,7 @@
 		sp->SCp.buffers_residual = sbus_map_sg(esp->sdev,
 						       sp->SCp.buffer,
 						       sp->use_sg,
-						       scsi_to_sbus_dma_dir(sp->sc_data_direction));
+						       sp->sc_data_direction);
 		sp->SCp.this_residual = sg_dma_len(sp->SCp.buffer);
 		sp->SCp.ptr = (char *) ((unsigned long)sg_dma_address(sp->SCp.buffer));
 	}
@@ -1457,12 +1457,12 @@
 {
 	if (sp->use_sg) {
 		sbus_unmap_sg(esp->sdev, sp->buffer, sp->use_sg,
-			      scsi_to_sbus_dma_dir(sp->sc_data_direction));
+			      sp->sc_data_direction);
 	} else if (sp->request_bufflen) {
 		sbus_unmap_single(esp->sdev,
 				  sp->SCp.have_data_in,
 				  sp->request_bufflen,
-				  scsi_to_sbus_dma_dir(sp->sc_data_direction));
+				  sp->sc_data_direction);
 	}
 }
 
--- 1.23/drivers/scsi/qlogicpti.c	2004-03-05 23:12:06 +01:00
+++ edited/drivers/scsi/qlogicpti.c	2004-05-31 21:54:42 +02:00
@@ -1038,7 +1038,7 @@
 		int sg_count;
 
 		sg = (struct scatterlist *) Cmnd->buffer;
-		sg_count = sbus_map_sg(qpti->sdev, sg, Cmnd->use_sg, scsi_to_sbus_dma_dir(Cmnd->sc_data_direction));
+		sg_count = sbus_map_sg(qpti->sdev, sg, Cmnd->use_sg, Cmnd->sc_data_direction);
 
 		ds = cmd->dataseg;
 		cmd->segment_cnt = sg_count;
@@ -1081,7 +1081,7 @@
 			sbus_map_single(qpti->sdev,
 					Cmnd->request_buffer,
 					Cmnd->request_bufflen,
-					scsi_to_sbus_dma_dir(Cmnd->sc_data_direction));
+					Cmnd->sc_data_direction);
 
 		cmd->dataseg[0].d_base = (u32) ((unsigned long)Cmnd->SCp.ptr);
 		cmd->dataseg[0].d_count = Cmnd->request_bufflen;
@@ -1412,12 +1412,12 @@
 			sbus_unmap_sg(qpti->sdev,
 				      (struct scatterlist *)Cmnd->buffer,
 				      Cmnd->use_sg,
-				      scsi_to_sbus_dma_dir(Cmnd->sc_data_direction));
+				      Cmnd->sc_data_direction);
 		} else {
 			sbus_unmap_single(qpti->sdev,
 					  (__u32)((unsigned long)Cmnd->SCp.ptr),
 					  Cmnd->request_bufflen,
-					  scsi_to_sbus_dma_dir(Cmnd->sc_data_direction));
+					  Cmnd->sc_data_direction);
 		}
 		qpti->cmd_count[Cmnd->device->id]--;
 		sbus_writew(out_ptr, qpti->qregs + MBOX5);
--- 1.6/include/asm-sparc/sbus.h	2004-03-14 07:54:58 +01:00
+++ edited/include/asm-sparc/sbus.h	2004-05-31 21:50:44 +02:00
@@ -7,6 +7,7 @@
 #ifndef _SPARC_SBUS_H
 #define _SPARC_SBUS_H
 
+#include <linux/dma-mapping.h>
 #include <linux/ioport.h>
 
 #include <asm/oplib.h>
@@ -106,10 +107,10 @@
 extern void *sbus_alloc_consistent(struct sbus_dev *, long, u32 *dma_addrp);
 extern void sbus_free_consistent(struct sbus_dev *, long, void *, u32);
 
-#define SBUS_DMA_BIDIRECTIONAL	0
-#define SBUS_DMA_TODEVICE	1
-#define SBUS_DMA_FROMDEVICE	2
-#define	SBUS_DMA_NONE		3
+#define SBUS_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
+#define SBUS_DMA_TODEVICE	DMA_TO_DEVICE
+#define SBUS_DMA_FROMDEVICE	DMA_FROM_DEVICE
+#define	SBUS_DMA_NONE		DMA_NONE
 
 /* All the rest use streaming mode mappings. */
 extern dma_addr_t sbus_map_single(struct sbus_dev *, void *, size_t, int);
=== include/asm-sparc64/sbus.h 1.4 vs edited ==--- 1.4/include/asm-sparc64/sbus.h	2004-03-14 07:54:58 +01:00
+++ edited/include/asm-sparc64/sbus.h	2004-05-31 21:50:10 +02:00
@@ -7,6 +7,7 @@
 #ifndef _SPARC64_SBUS_H
 #define _SPARC64_SBUS_H
 
+#include <linux/dma-mapping.h>
 #include <linux/ioport.h>
 
 #include <asm/oplib.h>
@@ -99,10 +100,10 @@
 extern void *sbus_alloc_consistent(struct sbus_dev *, size_t, dma_addr_t *dma_addrp);
 extern void sbus_free_consistent(struct sbus_dev *, size_t, void *, dma_addr_t);
 
-#define SBUS_DMA_BIDIRECTIONAL	0
-#define SBUS_DMA_TODEVICE	1
-#define SBUS_DMA_FROMDEVICE	2
-#define	SBUS_DMA_NONE		3
+#define SBUS_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
+#define SBUS_DMA_TODEVICE	DMA_TO_DEVICE
+#define SBUS_DMA_FROMDEVICE	DMA_FROM_DEVICE
+#define	SBUS_DMA_NONE		DMA_NONE
 
 /* All the rest use streaming mode mappings. */
 extern dma_addr_t sbus_map_single(struct sbus_dev *, void *, size_t, int);
