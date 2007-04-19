From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2007 07:47:05 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070419.004705.91314983.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 17 Apr 2007 17:28:24 +0200

> 	esp: esp0: reconnect, tag type changed 22 --> 00

There is a bug in this error message, could you reproduce
this with the following fix applied so I can debug this
further?

The patch might apply with some fuzz.  Even if it doesn't
apply, it is very easy for you to hand edit the file to
change that esp->command_block[1] into esp->command_block[0]
:-)

Thanks!

commit fb6627f19994a6ab6f08faa7c4fcd6856ad40c01
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Thu Apr 19 00:45:45 2007 -0700

    [SCSI] SUNESP: Fix error message in esp_reconnect_with_tag().
   =20
    When the tag type does not match the one in the command
    we printed the tag number instead of the type from the
    command block DMA area.
   =20
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index fd5548f..2b79dfe 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -1439,7 +1439,7 @@ static struct esp_cmd_entry *esp_reconnect_with_tag(s=
truct esp *esp,
 		printk(KERN_ERR PFX "esp%d: Reconnect, tag type changed "
 		       "%02x --> %02x.\n",
 		       esp->host->unique_id, ent->tag[0],
-		       esp->command_block[1]);
+		       esp->command_block[0]);
 		return NULL;
 	}
=20
