From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Fri, 27 Apr 2007 08:33:30 +0000
Subject: Re: [PATCH]: Final ESP driver rewrite
Message-Id: <Pine.LNX.4.61.0704271032380.506@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070427.002829.43009224.davem@davemloft.net>
 <Pine.LNX.4.61.0704270956500.506@yvahk01.tjqt.qr> <20070427.012436.109059523.davem@davemloft.net>
In-Reply-To: <20070427.012436.109059523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org


On Apr 27 2007 01:24, David Miller wrote:
>> On Apr 27 2007 00:28, David Miller wrote:
>>=20
>> >This is the patch I intend to send to Linus via my
>> >sparc-2.6 tree.
>> >
>> >Thanks to everyone for the review and testing!
>> >
>> >commit cd9ad58d4061494e7fdd70ded7bcf2418daf356a
>> >Author: David S. Miller <davem@sunset.davemloft.net>
>> >Date:   Thu Apr 26 21:19:23 2007 -0700
>>=20
>> Would not it be better to delete the file (=C3=A0 la `svn rm` first), th=
en readd it?
>
>What I did in GIT was remove drivers/scsi/esp.[ch] then add
>drivers/scsi/esp_scsi.[ch] and drivers/scsi/sun_esp.c
>
>And that is reflected exactly in the patch, so what's the
>suggestion?

Well the patch looks like it's done in one commit (rather than two -
delete+add), but that's probably just because it's the diff over both commi=
ts.
All fine.


Jan
--=20
