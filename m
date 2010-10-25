From: David Miller <davem@davemloft.net>
Date: Mon, 25 Oct 2010 16:09:57 +0000
Subject: Re: [PATCH 3/3] sparc32: fix build failure on CONFIG_SPARC_LEON
Message-Id: <20101025.090957.104053185.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-3-git-send-email-namhyung@gmail.com>
	<20101025.090043.71110898.davem@davemloft.net>
	<1288022849.1689.14.camel@leonhard>
In-Reply-To: <1288022849.1689.14.camel@leonhard>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: namhyung@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 26 Oct 2010 01:07:29 +0900

> 2010-10-25 (=BF=F9), 09:00 -0700, David Miller:
>> From: Namhyung Kim <namhyung@gmail.com>
>> Date: Tue, 26 Oct 2010 00:52:38 +0900
>>=20
>> >   CC      arch/sparc/kernel/irq_32.o
>> > arch/sparc/kernel/irq_32.c: In function 'request_fast_irq':
>> > arch/sparc/kernel/irq_32.c:370:25: error: conflicting types for 'trapb=
ase_cpu1'
>>=20
>> I doubt SMP LEON chips even exist, so better to just anti-dep
>> this in arch/sparc/Kconfig
>=20
> If I understood correctly, you meant this?

Yes, something like that.
