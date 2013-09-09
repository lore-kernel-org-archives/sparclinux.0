From: David Miller <davem@davemloft.net>
Date: Mon, 09 Sep 2013 17:31:47 +0000
Subject: Re: [RFC] sparc64: Duplicate kernel text on every NUMA node
Message-Id: <20130909.133147.299057761271519545.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <8311377178790@web14g.yandex.ru>
In-Reply-To: <8311377178790@web14g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 09 Sep 2013 18:50:00 +0400

> Before:
>=20
> real =A0=A0=A0=A07m58.466s
> user =A060m49.660s
> sys =A0=A0=A047m40.030s
>=20
> After:
>=20
> real =A0=A0=A0=A07m55.562s
> user =A060m20.900s
> sys =A0=A0=A046m36.040s
>=20
> So, the real profit (system time) is whole 2.2%. I thought, it would be m=
ore :)
> It seems, it's not big enough to really implement this feature. Practice =
checks
> a hypothesis.

You are juding the suitability of your optimization using one
statistical sample of a benchmark involving trillions of memory
accesses?

Please at least run it 3 or 4 times so you can see how much variation
occurs between runs in the same configuration. :-)

