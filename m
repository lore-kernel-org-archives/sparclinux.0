From: David Miller <davem@davemloft.net>
Date: Sun, 05 Aug 2007 03:12:16 +0000
Subject: Re: Creator 3D fb [Bug 8232 on kernel's bugzilla]
Message-Id: <20070804.201216.71091639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46B43343.7050108@systella.fr>
In-Reply-To: <46B43343.7050108@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Sat, 04 Aug 2007 10:05:23 +0200

> 	I think this bug was forgotten ;-) David, you have sent a patch that=20
> partially fix this bug, but not totaly. Sometimes, after fb switches=20
> screen off, I have to switch between text console and X screen to=20
> reinitialize fb.
>=20
> 	This bug only occurs on Creator 3D (in a Sbus/UPA). I never see it on=20
> PCI/UPA workstation.

I'm going to have to ask you to help fix this bug since I
cannot reproduce it here.  Please try to figure out what
might be wrong in drivers/video/ffb.c to cause such a
problem.
