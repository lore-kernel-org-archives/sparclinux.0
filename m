From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2007 08:24:36 +0000
Subject: Re: [PATCH]: Final ESP driver rewrite
Message-Id: <20070427.012436.109059523.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070427.002829.43009224.davem@davemloft.net>
	<Pine.LNX.4.61.0704270956500.506@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0704270956500.506@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: jengelh@linux01.gwdg.de
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Fri, 27 Apr 2007 09:57:34 +0200 (MEST)

>=20
> On Apr 27 2007 00:28, David Miller wrote:
>=20
> >This is the patch I intend to send to Linus via my
> >sparc-2.6 tree.
> >
> >Thanks to everyone for the review and testing!
> >
> >commit cd9ad58d4061494e7fdd70ded7bcf2418daf356a
> >Author: David S. Miller <davem@sunset.davemloft.net>
> >Date:   Thu Apr 26 21:19:23 2007 -0700
>=20
> Would not it be better to delete the file (=E0 la `svn rm` first), then r=
eadd it?

What I did in GIT was remove drivers/scsi/esp.[ch] then add
drivers/scsi/esp_scsi.[ch] and drivers/scsi/sun_esp.c

And that is reflected exactly in the patch, so what's the
suggestion?
