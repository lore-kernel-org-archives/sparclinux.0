From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Nov 2005 08:58:10 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <20051123.005810.68037361.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Nov 2005 10:26:12 +0200 (EET)

> BUT now I noticed that the previous patch garbled it differently.
> Ususally I see things like that:
> ..=C9.=A5=BD..2.86 booting
> (instead of init version 2.86 booting)
>=20
> and I still see it with this patch. But with previous patch I saw
>   version 2.86 booting
> and perhaps some more dropped characters here and there. Entering=20
> runlevel 2 message was still garbage with previous patch too.

Ok, thanks for the info, I'll go back to studying the SAB programmer's
manual (available at:
	http://www.commtech-fastcom.com/data_sheets/sab82532.pdf
as well as other places, just give "SAB82532 manual" to any search
engine) and the driver to try and get some more ideas.
