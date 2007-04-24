From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 24 Apr 2007 08:01:20 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <462DB950.2050209@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
> Date: Mon, 23 Apr 2007 11:21:58 +0200
>=20
>> Is it possible to you to send your esp.c in attachment ? I use esp
>> driver with all patches you have sent to the mailing list.
>=20
> Here are the current esp.c and esp.h files, as attachments.

	Thanks a lot. I have tried on one of my SS20 and it can boot. Next=20
step, fix syscall_to_hard in read_pipe and sparc32/SMP will be stable ;-)

	Regards,

	JKB
