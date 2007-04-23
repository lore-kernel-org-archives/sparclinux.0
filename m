From: David Miller <davem@davemloft.net>
Date: Mon, 23 Apr 2007 09:08:06 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070423.020806.41634792.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 23 Apr 2007 02:06:08 -0700 (PDT)

> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Mon, 23 Apr 2007 10:42:55 +0200
>=20
> > esp: esp0: Aborting command [fb850200:2a]
> > followed by a lot of insane messages ;-)
>=20
> I fixed that, see my other patch.

To clarify, make sure you are using the current version of
the driver I posted just the other day.

You have the current version with the fix for SMART if
the drivers/scsi/esp.c file has the function "esp_autosense()"
