From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2018 01:30:47 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <20180418.213047.500713499751878362.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Ren=E9 Rebe <rene@exactcode.com>
Date: Wed, 18 Apr 2018 23:40:06 +0200

> On 18 Apr 2018, at 23:34, Meelis Roos <mroos@linux.ee> wrote:
>=20
>> Turn off Transparent Hugepages in kernel configuration - they are known =

>> to cause this. I turned it off on all my sparc64 machines and crashes=20
>> like that are gone.
>=20
> unfortunately the .config option is off:
>=20
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
>=20
> :-/

Indeed, I never believed this bug was related to huge pages.

Hopefully I can get back to trying to narrow this one down.

I've personally never seen this problem on any of my sun4v
machines, and perhaps that is a clue.
