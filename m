From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2018 15:41:47 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <20180419.114147.2105240780417112043.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 19 Apr 2018 16:10:54 +0200

> On 04/19/2018 07:47 AM, Ren=E9 Rebe wrote:
>> Any chance this is non-sun4v related? This is an Ultra30 sun4u, ...
>=20
> Don't think so:
 ...
> root@ravirin:~# cat /proc/cpuinfo
> cpu             : TI UltraSparc IIIi (Jalapeno)
> fpu             : UltraSparc IIIi integrated FPU

Then it could be pre-Ultra-IIIi systems that trigger the problem.
Ultra30 is as such.

