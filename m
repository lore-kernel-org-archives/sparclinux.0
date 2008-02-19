From: David Miller <davem@davemloft.net>
Date: Tue, 19 Feb 2008 04:25:23 +0000
Subject: Re: [PATCH] ESP driver
Message-Id: <20080218.202523.113868965.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47B9F9E1.8020007@systella.fr>
In-Reply-To: <47B9F9E1.8020007@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Mon, 18 Feb 2008 22:34:25 +0100

> 	I think I have found a bug in esp_scsi.c. Without this patch, my=20
> SS20/SMP was not able to rebuild its internal raid1 volume due to esp0=20
> DMA errors. With the following patch, same workstation is building a=20
> kernel, doing a rsync (between two local directories) and rebuilding a=20
> 26 GB raid1 volume without any trouble.
>=20
> Signed-off-by: BERTRAND Joel <joel.bertrand@systella.fr>

It may correct your problem for some reason, but this change
is not correct (and your email client or your editor used
spaces instead of tab characters in your change).  The FAS100A
implements the ESP_STAT_INTR bit correctly.

If the FAS100A needed this change, you would get spurious IRQs or
other state machine errors, not DMA errors.

I think your change merely changes timings, making the DMA problem
harder to trigger.

I'm sorry I don't have more desirable feedback for your patch, but
it's the best I can do :-)
