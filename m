From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sun, 01 Nov 2009 17:43:40 +0000
Subject: Re: temperature & fan-control
Message-Id: <1257097420.2007.12.camel@deblnxsrv254.opensoftwarenetwork.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
In-Reply-To: <1256288818.1858.15.camel@deblnxsrv254.opensoftwarenetwork.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> 	Hello,
>=20
> 	2.6.27 is the last usable kernel on Blade 2000. I run a 2.6.28.10 with=20
> some patches and env_bbc is initialized. Module can be unloaded without=20
> Oops, but no information is read.
>=20
> 	I have disabled bbc on all my Blades because bbc module (2.6.27)=20
> randomly returns very strange values (more than 85 =C2=B0C) and workstati=
on=20
> switches off. It can happen when these workstations do not run anything. =

> These workstations are clean and run without any trouble with Solaris.
>=20
> 	When bbc returns an overheating event, fan speed is not set to its=20
> maximum value. I have try to debug without any success because I cannot=20
> reproduce it.
>=20
> 	Regards,
>=20
> 	JKB

Talking about env_bbc the Have you seen how the max1617 i2c devices are
supported in Open Solaris?

max1617.c & envctrl_targets.c
http://tinyurl.com/ykmufdv
http://tinyurl.com/yfn8y2z


Thanks,


Frans van Berckel

