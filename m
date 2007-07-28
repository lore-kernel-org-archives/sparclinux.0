From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 28 Jul 2007 07:59:44 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <46AAF770.7030502@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Wed, 25 Jul 2007 10:31:50 +0200
>=20
>> 	I have tried your patch with icemonkey and it hangs (in a futex).=20
>> Strace output ends with :
>=20
> Thanks for testing, I'll keep digging.

	I have tested your patch for two days. Now, I can affirm that it does=20
not fix futex trouble. I have seen exactly same bug report on=20
sparc-debian mailing list.

	Regards,

	JKB
