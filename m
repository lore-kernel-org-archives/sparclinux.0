From: David Miller <davem@davemloft.net>
Date: Wed, 18 Jun 2008 06:45:48 +0000
Subject: Re: [BUG] Kernel panic on heavy disk activity with esp_scsi
Message-Id: <20080617.234548.247628860.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1210367903.21472.14.camel@lya.porno-bullen.de>
In-Reply-To: <1210367903.21472.14.camel@lya.porno-bullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Friedrich Oslage <bluebird@porno-bullen.de>
Date: Fri, 09 May 2008 23:18:23 +0200

> esp: esp0: DMA length is zero!
> esp: esp0: cur adr[c3dfc000] len[00000000]

The real bug starts here.  I haven't yet figured out why this
might happen.

The driver tries to reset the chip, which should get things going
again, but this hits another bug:

> Kernel unaligned access at TPC[5e9060] scsi_is_host_device+0x8/0x20
 ...
> Caller[00000000005f7a6c]: esp_reset_cleanup+0x1b4/0x200
> Caller[00000000005f9c64]: scsi_esp_intr+0x1ec/0x960

The problem here is that tp->starget is set every time a lun
is allocated for a particular target so we can catch the
sdev_target parent value.

The reset handler uses the NULL'ness of this value to determine
which targets are active.

But esp_slave_destroy() does not NULL out this value when appropriate.

So for every target that doesn't respond, the SCSI bus scan causes
a stale pointer to be left here, with ensuing crashes like you're
seeing.

The following patch should fix the OOPS, but not the DMA length
problem which led to the ESP scsi reset in the first place.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index a0b6d41..305edde 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2371,6 +2371,7 @@ static int esp_slave_alloc(struct scsi_device *dev)
 	dev->hostdata = lp;
 
 	tp->starget = dev->sdev_target;
+	tp->starget_ref++;
 
 	spi_min_period(tp->starget) = esp->min_period;
 	spi_max_offset(tp->starget) = 15;
@@ -2425,10 +2426,17 @@ static int esp_slave_configure(struct scsi_device *dev)
 
 static void esp_slave_destroy(struct scsi_device *dev)
 {
+	struct esp *esp = shost_priv(dev->host);
+	struct esp_target_data *tp = &esp->target[dev->id];
 	struct esp_lun_data *lp = dev->hostdata;
 
 	kfree(lp);
 	dev->hostdata = NULL;
+
+	BUG_ON(tp->starget_ref <= 0);
+
+	if (!--tp->starget_ref)
+		tp->starget = NULL;
 }
 
 static int esp_eh_abort_handler(struct scsi_cmnd *cmd)
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index bb43a13..655e0b2 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -322,6 +322,7 @@ struct esp_target_data {
 	u8			nego_goal_tags;
 
 	struct scsi_target	*starget;
+	int			starget_ref;
 };
 
 struct esp_event_ent {
