From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Thu, 19 Apr 2018 19:04:12 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <B1FA84B2-1325-4099-8882-36C3CC259101@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

On 19 Apr 2018, at 19:21, John Paul Adrian Glaubitz <glaubitz@physik.fu-ber=
lin.de> wrote:

> On 04/19/2018 05:41 PM, David Miller wrote:
>> Then it could be pre-Ultra-IIIi systems that trigger the problem.
>> Ultra30 is as such.
>=20
> Possible. But I haven't received any such bug report from Debian users
> yet and we have people running the sparc64 port on machines as old
> as the Ultra 10.
>=20
> Rene, would you mind testing Debian's sparc64 port on your machine?

I would, however I realize this bug message does not reliably appear.
(I should note the kernel continued to run further thru all the installation
so for my first glance it was =93only=94 of cosmetic nature.)
My thinking was to post it in case it ring a bell or remind someone of some=
thing.

I will keep you posted what else I find, e.g. trying to mount a floppy on
the Ultra 5 oopsed. Will double check and re-post details separately
(unless someone warns me floppy support is known to be broken right
now ;-)

On the plus side: I could start latest xorg-server w/ sunffb driver, though
someone deleted the nice Mesa driver since the last time I turned it on,
=85 :-/

> Just booting the installation image is probably enough provided the
> bug shows immediately once the kernel is booted. See [1].
>=20
> Adrian
>=20
>> [1] https://cdimage.debian.org/cdimage/ports/

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

