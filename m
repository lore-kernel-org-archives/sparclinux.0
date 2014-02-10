From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 10 Feb 2014 13:16:22 +0000
Subject: Re: [Debian] Kernel 3.12.9
Message-Id: <52F8D126.7050904@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <52F7BCE2.9010902@systella.fr>
In-Reply-To: <52F7BCE2.9010902@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

BERTRAND Jo=EBl a =E9crit :
> BERTRAND Jo=EBl a =E9crit :
>>      This kernel is a SMP kernel. Is there any issue with this kernel ?
>
>      With maxcpus=3D1, the same kernel boots fine.

	Another strange bug. On one of my T1000, I cannot boot recent kernel.=20
2.6.30.9 boots fine, 2.6.38 doesn't. I have tried 3.12.9/UP and it hangs=20
with :

mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!

	I have tried irqpool and pci=3Drouteirq without success. Of course,=20
hardware is not faulty, I have tested it.

	Regards,

	JB
