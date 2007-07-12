From: David Miller <davem@davemloft.net>
Date: Thu, 12 Jul 2007 09:38:28 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070712.023828.78711084.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Thu, 12 Jul 2007 09:17:04 +0200

> Are there significative differences between futex management on sbus
> and pci sparc64 ?

Absolutely none.

If it is some race, the timing differences of the two cpus
can be enough to make it hard if not impossible to trigger
on one machine vs. another.  I see bugs like this all the
time.
