From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Fri, 03 Oct 2008 17:44:06 +0000
Subject: Re: Netra X1 - Tulip Issues - Since 2.6.24
Message-Id: <48E659E6.5070701@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <48E652A7.3010202@jg555.com>
In-Reply-To: <48E652A7.3010202@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Jim Gifford a =E9crit :
> Currently running 2.6.24-gentoo-r8 and 2.6.25-gentoo-r7. Also have tried =

> the vanilla kernel as well.
>=20
> It appears the issues seems to be isolated tot he Sparc X1's my x86's=20
> using the tulip driver are not having the issue.
>=20
> Not sure if it's a reporting issue or just a problem with the driver.=20
> Every packet seems to be an error. I've ran out of resources trying to=20
> figure this out on my own, but no luck. Seems to be TX issue only.

	This is a known trouble that seems to be fixed in 2.6.26. If I=20
remember, this trouble is older than 2.6.24. I have seen the same with=20
3Com adapter since 2.6.19 and it affected all archs.

	Regards,

	JKB
