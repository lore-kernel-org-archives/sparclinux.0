From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 20:46:49 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070416.134649.69022266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: "Adam Kropelin" <akropel1@rochester.rr.com>
Date: Sun, 15 Apr 2007 12:03:26 -0400

> ESP: data done csr[a6400310] flgs[1] sent[73728]
> ESP: start data addr[c004c000] len[0] write(1)
> esp: esp0: DMA error, csr=A440031e

I know what this bug is, it should be fixed by the following patch,
please give it a try.

I'll also add an assertion on zero transfer length when we start a
data transfer, that should never happen and is specifically what led
to the DMA error in this case.

commit 539d62c1f2b2b9ad2ace13ce2c7fc0aa47db87c3
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sat Apr 14 20:03:25 2007 -0700

    [SCSI] SUNESP: Fix partial transfer length calculations.
   =20
    If we limited the DMA transfer length due to chip limitations
    we might calculate a partial transfer length incorrectly in
    esp_data_bytes_sent().
   =20
    Fix this by remembering the DMA length we actually used for the
    data phase transfer in esp->data_dma_len.
   =20
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index dc25b1e..7882fc7 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -1567,7 +1567,7 @@ static int esp_data_bytes_sent(struct esp *esp, struc=
t esp_cmd_entry *ent,
 			ecount |=3D ((unsigned int)esp_read8(FAS_RLO)) << 16;
 	}
=20
-	bytes_sent =3D esp_cur_dma_len(cmd);
+	bytes_sent =3D esp->data_dma_len;
 	bytes_sent -=3D ecount;
=20
 	if (!(ent->flags & ESP_CMD_FLAG_WRITE))
@@ -1956,6 +1956,7 @@ again:
 			ent->flags &=3D ~ESP_CMD_FLAG_WRITE;
=20
 		dma_len =3D esp_dma_length_limit(esp, dma_addr, dma_len);
+		esp->data_dma_len =3D dma_len;
=20
 		esp_log_datastart("ESP: start data addr[%08x] len[%u] "
 				  "write(%d)\n",
diff --git a/drivers/scsi/esp.h b/drivers/scsi/esp.h
index 2b3d969..bd3237d 100644
--- a/drivers/scsi/esp.h
+++ b/drivers/scsi/esp.h
@@ -364,6 +364,8 @@ struct esp {
 	u8			*command_block;
 	dma_addr_t		command_block_dma;
=20
+	unsigned int		data_dma_len;
+
 	/* The following are used to determine the cause of an IRQ. Upon every
 	 * IRQ entry we synchronize these with the hardware registers.
 	 */
