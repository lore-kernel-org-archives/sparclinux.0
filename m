From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Wed, 01 Aug 2007 11:21:08 +0000
Subject: Re: [RESEND] [BUG] futex_unlock_pi() hurts my brain and may cause
Message-Id: <46B06CA4.30605@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070731.184250.71089148.davem@davemloft.net>
In-Reply-To: <20070731.184250.71089148.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Wed, 01 Aug 2007 09:13:52 +0200
>=20
>> 	I shall try this patch. I hope today, but I have a lot of
>> work. Do you want I revert your previous patch (in
>> asm-sparc64/futex.h) ?
>=20
> It doesn't matter.

	David, I have tried your patch. It does not fix futex bug (iceape hangs=20
with same futex call).

	Regards,

	JKB
