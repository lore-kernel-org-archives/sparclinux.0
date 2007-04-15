From: David Miller <davem@davemloft.net>
Date: Sun, 15 Apr 2007 00:12:11 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070414.171211.03609097.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 14 Apr 2007 17:58:57 -0500

Thanks for testing and the new log Tom.

Let's see what happened:

> ESP: tgt[3] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
> ESP: intr sreg[93] seqreg[00] sreg2[00] ireg[18]
> ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
> ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
> ESP: Command done status[2] message[0]

Target 3 (presumably your disk) gave a CHECK_CONDITION
for the INQUIRY, that's fine, so that scsi layer gives
a REQUEST_SENSE.

> ESP: tgt[3] lun[0] scsi_cmd [ 03 00 00 00 fc 00 ]
> ESP: intr sreg[91] seqreg[04] sreg2[00] ireg[18]
> ESP: start data addr[f0005000] len[252] write(1)
> ESP: intr sreg[83] seqreg[04] sreg2[00] ireg[10]
> ESP: data done csr[a6400310] flgs[1] sent[18]
> ESP: intr sreg[87] seqreg[04] sreg2[00] ireg[08]
> ESP: intr sreg[80] seqreg[04] sreg2[00] ireg[20]
> ESP: Command done status[0] message[0]

This seems to go fine (we get the 18 bytes of sense data etc.) but for
some reason the scsi layer decides to not attach to this device.

Perhaps the sense data is not being DMA'd correctly.

Let's get some more debugging, please run with this patch, thanks.

...

Actually, scratch that.

I think I know what the problem is, you need this fix below in your
tree too.  This is upstream as of the beginning of last week so you
perhaps don't have it, although I've posted it explicitly to you on
several occaisions.

This bug causes sense data to not get copied at all into the scsi
sense buffer, which makes all manner of things go wrong as you
can imagine :)

I'm guessing that normally on your system this disk needs to be spun
up during the initial scsi bus scan?  I guess this also means you are
net-booting these kernels else the disk would be spun-up already by
the firmware.

Either way, give this patch below a spin and let me know how it
goes.

commit 8cc574a3c5cea70229f243a6b57fd69e60491d82
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Mon Apr 2 14:21:55 2007 -0700

    [SCSI]: Fix scsi_send_eh_cmnd scatterlist handling
    
    This fixes a regression caused by commit:
    
    2dc611de5a3fd955cd0298c50691d4c05046db97
    
    The sense buffer code in scsi_send_eh_cmnd was changed to use
    alloc_page() and a scatter list, but the sense data copy was not
    updated to match so what we actually get in the sense buffer is total
    grabage starting with the kernel address of the struct page we got.
    Basically the stack frame of scsi_send_eh_cmd() is what ends up
    in the sense buffer.
    
    Depending upon how pointers look on a given platform, you can
    end up getting sr_ioctl.c errors when you mount a cdrom.  If
    the CDROM gives a check condition for GPCMD_GET_CONFIGURATION issued
    by drivers/cdrom/cdrom.c:cdrom_mmc_profile(), sr_ioctl will
    spit out this error message in sr_do_ioctl() with the way pointers
    are on sparc64:
    
    		default:
    			printk(KERN_ERR "%s: CDROM (ioctl) error, command: ", cd->cdi.name);
    			__scsi_print_command(cgc->cmd);
    			scsi_print_sense_hdr("sr", &sshdr);
    			err = -EIO;
    
    This is the error Tom Callaway reported in:
    
    http://marc.info/?l=linux-sparc&m7407453208101&w=2
    
    Anyways, fix this by using page_address(sgl.page) which is OK
    because we know this is low-mem due to GFP_ATOMIC.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Acked-by: Christoph Hellwig <hch@lst.de>

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index b8edcf5..918bb60 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -716,7 +716,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 	 */
 	if (copy_sense) {
 		if (!SCSI_SENSE_VALID(scmd)) {
-			memcpy(scmd->sense_buffer, scmd->request_buffer,
+			memcpy(scmd->sense_buffer, page_address(sgl.page),
 			       sizeof(scmd->sense_buffer));
 		}
 		__free_page(sgl.page);
