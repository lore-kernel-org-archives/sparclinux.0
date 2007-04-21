From: David Miller <davem@davemloft.net>
Date: Sat, 21 Apr 2007 23:20:06 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070421.162006.112290328.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Thu, 19 Apr 2007 14:19:48 +0200

> 	Thanks. Patch applied. Now, kernel says :
> ...
> /dev/md1: clean, 220181/1251712 files...
> esp: esp0: Reconnect, tag type changed 22 --> 20
> esp: esp0: Aborting command [fbc5f3c0:2a]
> esp: esp0: Queued command [fbc5f3c0:2a]
> esp: esp0: Queued command [fbc5f4e0:2a]
> esp: esp0: Dumping command log
>=20
> followd by a lot of insane messages ;-)

OK, I read over the SCSI standard docs a bit and my
assertion check here is wrong.

Regardless of what type of TAG type we sent to the target, when it
reconnects after a disconnect it always gives SIMPLE_QUEUE_TAG (0x20)
as the tag type.

This is explained clearly in section 6.6.17 of the SCSI-2 standard,
for example.

Georg Chini gave the important clue, MD and RAID.  Those make ordered
tags go out to the device.  Normally only simple tags are used so the
tag the target gives back on reconnect always matched up by
coincidence :-)

Please test with this patch, thanks!

diff --git a/drivers/scsi/esp.c b/drivers/scsi/esp.c
index a3550b3..fa49348 100644
--- a/drivers/scsi/esp.c
+++ b/drivers/scsi/esp.c
@@ -1435,13 +1435,6 @@ static struct esp_cmd_entry *esp_reconnect_with_tag(=
struct esp *esp,
 		       esp->host->unique_id, esp->command_block[1]);
 		return NULL;
 	}
-	if (ent->tag[0] !=3D esp->command_block[0]) {
-		printk(KERN_ERR PFX "esp%d: Reconnect, tag type changed "
-		       "%02x --> %02x.\n",
-		       esp->host->unique_id, ent->tag[0],
-		       esp->command_block[0]);
-		return NULL;
-	}
=20
 	return ent;
 }
