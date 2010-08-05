From: David Miller <davem@davemloft.net>
Date: Thu, 05 Aug 2010 23:15:20 +0000
Subject: Re: liburcu: debian sparc fail to configure
Message-Id: <20100805.161520.149851500.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100805221352.GA30108@Krystal>
In-Reply-To: <20100805221352.GA30108@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Thu, 5 Aug 2010 18:13:52 -0400

> * Jon Bernard (jbernard@debian.org) wrote:
>> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
>> > Hi Jon,
>> >=20
>> > What's the cpuinfo spec of the build machine ?
>>=20
>> Here is the contents of /proc/cpuinfo:
>>=20
>>     cpu     : TI UltraSparc IIIi (Jalapeno)
>=20
> http://en.wikipedia.org/wiki/SPARC#SPARC_microprocessor_specifications
>=20
> UltraSPARC IIIi (Jalape=F1o)    ....   V9 / JPS1
>=20
> so it should be a sparcv9.
>=20
> Can you try a uname -a  to see which kernel version/architecture this
> is? I wonder if it's a 32 or 64-bit kernel.

Yes it's a 64-bit kernel.

Why are you checking /proc/cpuinfo's "cpu" field anyways?

Parse instead the "type" field and if it's sun4u or sun4v you
have a 64-bit box.
