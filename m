Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225C2620EC;
	Tue,  4 Mar 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117819; cv=none; b=L0HErzCwekEYxfB398xhV/iRZv8SsAfDwUdtliVFJN+42IX6f85hxqsOqLL/SAtfqlLxJL3li7X74PGmZvWjwI/setl1WETzj/+n34dQ/iFTWFPXaRhnAsIzluY9qs9GODUVif4BS9VlbHUnadkns8OqV5By2vFeZRoGxTZS//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117819; c=relaxed/simple;
	bh=TGI/H3hK5ajdkkVDdKQRezZi/m186Hn9w32Ho0mio2o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L5YkqjuYQ9UBaf6zelX6YmVrpHCrD2Vg4LD03Skq3gdeDd+l6k6Q4rERkqD6KUpOgU8MZm4kt4xtALUF5gr6EFtysxJAub8zNmGWpng2EXcjMhA8v5r8vFLKDX+tsHmYw914U8MikplJnE4I7SwOg3UFYgikSO7LzSjqHbNSoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IfLlcfo4; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IfLlcfo4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741117809; x=1741722609; i=markus.elfring@web.de;
	bh=NAqioDBnaCR/fX3O979gDdxkodeOLW6s/eR0SCVTizo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IfLlcfo42J6gUsPkkOw3qJ+P+aVUjMY8LFIo+hLRmyVLiYH7E3HdddzmsNr7rVFT
	 6FhfK3ifb+4POy3hwuBOohSZb/+e5oMcg4ySc6XCKVMgKvCkWZRMGhxu5jS5Zm1wl
	 fUizJdnxNoUXnaZNko6/mtILCHpgb5CYTphcYFvTgMHDA6Hz3sstnp4UZ9LvyiWgC
	 AnKNcWTRyvCxZaCrKZW86ivZZnEFrR8I+GuvZLC0TPTkrjR+btE2lsnZ2yEyzyhRA
	 QHD/AsCw0gpaqOu1YxiwWsK19XjYblydIMUjrU2tbVUTn7nlVbCPjteJ/aEUe0+r6
	 qpb4yqUXxsELWdNq4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1tsYwn4A0D-004pJK; Tue, 04
 Mar 2025 20:50:09 +0100
Message-ID: <f7d11fd7-6b41-4dbd-b7dc-518fe6e6426f@web.de>
Date: Tue, 4 Mar 2025 20:50:06 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] bbc_i2c: Fix exception handling in attach_one_i2c()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, sparclinux@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>,
 Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>,
 "David S. Miller" <davem@davemloft.net>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <21e58abb-f215-b9b7-ffe8-236dd40c6bd2@web.de>
Content-Language: en-GB
In-Reply-To: <21e58abb-f215-b9b7-ffe8-236dd40c6bd2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WpWmttFFn8Qub64QBVtRj6aRk7IDFd3+w6lJR6TrfK8BSH156Ot
 hu6UopotRXDpps5+KITM05hQRO91neMEUKBl4E/Pw6c6uVCiQ284/JDE3tl1f+wn3w6lmEe
 d3QuaT3UgtFYU3zm9I+FuqJLOxJY2XWMQ5sHa/OHspiTepFl0WmgNdmPd13G5yEd2wu1kJP
 hGq6cT++PrBjIxK4z51fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yKktvz9VDmM=;6q/3gbhSNL/sHrPhjt7U2GB+w7U
 vSfEZeDYNAzI8t/grqY9Q3Ww8qIwQBLwtwOuN7hKhmoEJyNI3eqXvMrhlW6Neiq5pcfL0irOe
 zBqEe2HkcqbQ6dt7s8iTxt6tup12+QeN8PoOdvZBIzfxsmPb6F40AOiwe8WBWe+IY/jp4nk30
 Z8RTadRfn6MuP3i1g9DHm5pMpwdAeEScZuIFFvS2MGBdwtKroUUH3PrJpcpc3gElkBFeEXmCf
 F3eSOGTIteRBfTYeO1I4QcCl8HSxLpmsTqzOgUuj8MBVL/qiFL47Lk9y3jF7N1yLMVQasQUaJ
 z0DP7w/Pi77yCZaXf1DsEADgeRjgoGausGvzwrtTE66o8SHwEJ2q9IRjxxF9tuVQJjuBGJSUj
 X4PnTOJ7oK4yrU0JuPmoNZq6PQ3NZeCuhyi8Kuk9GdZk142+2aVpf5821PrfKm+um6yWr3RvF
 +MXFdtN53AEMuHbZD+JPROskKiDQHADgvjTdwV+MIzNUbP0AZvVu6uX8EAZwRVDjnord6cUnp
 NAmFxnwvpXwk6Gmz2d7X5R0KWOhLkYlny1vjVlwq8Hb/NV7AZqjscqf5pnBIAzPfjOioHKVec
 qFAMNKCOSlqgVbBZ+4Qxhbk4jkfGe6ifMDScFxMmo0tCV0WKIasYpPOGeuZ+JsrFvIcCOFzZE
 0FbdCG3DkMzMaOP79kJUrLG7qs4bepuXUURm1oOIeBy9M1CVJb9cT3Vs6akKKpO2oEm2x2E24
 MJJDNGpRWuVXXm8jWRlNEP+utm15nN1j3frwEKvISCfGyxXrmKix2UULVhHU6siPNXsQaSI9H
 VD/u/Z4WThkuTMvD5NjcqexBdHoohH292FJL4rFO2wNH8BOayV2tPLuUKiJ2uqhlVV3Ir3DJv
 d+R9xigG1mM0SaVBVRcSoqNYnFpi45uAVQeQLjKCwlEIn7RWOLNeDMTCWcOMd398u51QCgyyU
 YttK1vWd/boZVkEUe5+3NZSk/d0GQl5rAw9U4E5Q73hhKsiuvGX03nX8+oI/He0hST+65CEtA
 5iaXQhmH44nmqLdUH9RPeWdSXu/pHe1g4TXOJu6HbuSZGel9yhIfaPk0AkqcwM4bwgb85IwEC
 2AdDPkLdixNKpgJS4Q7iYNwErjqjbsv2ep+w/jmTwXffxX3rAzeTca8BEoZWd91ipdDME+9nC
 xWecGi4mXqzfDW8p98GS/Lzml+RcABxEF/ZIIdhKJWrdRFXWnXIhcgDLQIIAeYx1mCsNo/Ddd
 tNDtrvjHQanztPSDcQS1RzBkALmMp/dEZmZFfmkduuE45f4vany5Efx9jKnNC5diFmd/zIYql
 T2mfgaQoo86yPWyO+WmUy06/0Bq/f9tiscQdpnKRgakcDKmq5crk4Q5+70G7QLU11E/QpJx6M
 qQ1pRcB9m/j2+ICHeExgEUmN8wwvjIZOkCWQzYwsnrrZItL0VSB9f2sO1mxMugWhDqZNV+j/v
 t3nSEg19mZvhlcpKG9vmlkol28fM=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 21 Mar 2023 21:12:29 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cattach_one_i2c=
=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Cof_iorema=
p=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 5cdceab3d5e0 ("bbc-i2c: Fix BBC I2C envctrl on SunBlade 2000")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/sbus/char/bbc_i2c.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 537e55cd038d..03e29f2760b2 100644
=2D-- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -306,19 +306,19 @@ static struct bbc_i2c_bus * attach_one_i2c(struct pl=
atform_device *op, int index

 	bp->i2c_control_regs =3D of_ioremap(&op->resource[0], 0, 0x2, "bbc_i2c_r=
egs");
 	if (!bp->i2c_control_regs)
-		goto fail;
+		goto free_bus;

 	if (op->num_resources =3D=3D 2) {
 		bp->i2c_bussel_reg =3D of_ioremap(&op->resource[1], 0, 0x1, "bbc_i2c_bu=
ssel");
 		if (!bp->i2c_bussel_reg)
-			goto fail;
+			goto unmap_io_control_regs;
 	}

 	bp->waiting =3D 0;
 	init_waitqueue_head(&bp->wq);
 	if (request_irq(op->archdata.irqs[0], bbc_i2c_interrupt,
 			IRQF_SHARED, "bbc_i2c", bp))
-		goto fail;
+		goto recheck_bussel_reg;

 	bp->index =3D index;
 	bp->op =3D op;
@@ -348,11 +348,12 @@ static struct bbc_i2c_bus * attach_one_i2c(struct pl=
atform_device *op, int index

 	return bp;

-fail:
+recheck_bussel_reg:
 	if (bp->i2c_bussel_reg)
 		of_iounmap(&op->resource[1], bp->i2c_bussel_reg, 1);
-	if (bp->i2c_control_regs)
-		of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
+unmap_io_control_regs:
+	of_iounmap(&op->resource[0], bp->i2c_control_regs, 2);
+free_bus:
 	kfree(bp);
 	return NULL;
 }
=2D-
2.40.0

