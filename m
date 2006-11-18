From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 18 Nov 2006 14:25:22 +0000
Subject: Re: Super/HyperSPARC (2.6.18.2)
Message-Id: <455F17D2.4060002@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20061116154638.GA3138@rayleigh.systella.fr>
In-Reply-To: <20061116154638.GA3138@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Ulrich Teichert a =E9crit :
> Hi,
>=20
>=20
>>	I use some SS20 to tests (as routers). All of these workstations have 2
>>	SSII/75, but I have some single and dual RT626.
>>
>>	On one SS20, I have changed SuperSPARC by HyperSPARC. It runs with a
>>	2.6.18.2 linux kernel and a debian/testing. With ROOS, I can see a very
>>	strange mistake : apt-get returns a random error (only occurs with
>>	hypersparc, UP and SMP).
>>
>>	I have tested all motherboards and modules I have used for test with Sol=
aris
>>	and netbsd. All work fine. I don't understand why I only see this bug wi=
th
>>	apt-get. Is there any issue ? A bug in hypersparc specific code ?
>=20
>=20
> What PROM version do you use? I had strange errors as well until I updated
> the PROMs,

	I use a regular 2.25R from ROSS technology. Same trouble with 2.25=20
(that doesn't officialy support RT626). I have remounted the SS20 with=20
two SS-II and I shall test on another SS20 with a 2.25W from ROSS=20
(hyperstation).

	Regards,

	JKB
