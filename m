From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Thu, 19 Apr 2018 05:47:17 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <0F003C2A-1CBC-4AA2-BD61-8446E4E06E38@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


On 19 Apr 2018, at 03:30, David Miller <davem@davemloft.net> wrote:

> From: Ren=E9 Rebe <rene@exactcode.com>
> Date: Wed, 18 Apr 2018 23:40:06 +0200
>=20
>> On 18 Apr 2018, at 23:34, Meelis Roos <mroos@linux.ee> wrote:
>>=20
>>> Turn off Transparent Hugepages in kernel configuration - they are known=
=20
>>> to cause this. I turned it off on all my sparc64 machines and crashes=20
>>> like that are gone.
>>=20
>> unfortunately the .config option is off:
>>=20
>> # CONFIG_TRANSPARENT_HUGEPAGE is not set
>>=20
>> :-/
>=20
> Indeed, I never believed this bug was related to huge pages.
>=20
> Hopefully I can get back to trying to narrow this one down.
>=20
> I've personally never seen this problem on any of my sun4v
> machines, and perhaps that is a clue.

Any chance this is non-sun4v related? This is an Ultra30 sun4u, ...

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

