From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 13 Sep 2005 20:08:42 +0000
Subject: Re: [2.6.13-rc6-git13/sparc64]: Slab corruption (possible stack or
Message-Id: <20050913.130842.52078742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.BSO.4.62.0509121604360.5000@rudy.mif.pg.gda.pl>
	<20050912.161326.131841878.davem@davemloft.net>
	<Pine.BSO.4.62.0509131148020.5000@rudy.mif.pg.gda.pl>
In-Reply-To: <Pine.BSO.4.62.0509131148020.5000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: kloczek@rudy.mif.pg.gda.pl
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org

From: Tomasz K=B3oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Tue, 13 Sep 2005 12:12:22 +0200 (CEST)

> # grep "^Sep 12" /var/log/messages | grep kernel: | uniq | cut -d " " -f =
6- | sort | uniq -c | sort -n | tail -n 2
>      509 svc: bad direction 268435456, dropping request
>      653 eth0: Happy Meal out of receive descriptors, packet dropped.
>=20
> As you see one of this two messagess occures avarange one time per ~two=20
> minutes.
> Second looks like some error in sunhme.c. eth0 it is:

It's not a bug, per se, your system is simply receiving more
network traffic than the kernel can receive.  So the network
adapter runs out of receive descriptors in which to receive
new packets, and starts dropping them until the kernel catches
up again.  That's what that message means.

The "svc: " one I've seen before, it looks like something is
clobbering the sunrpc message, for example a freed up buffer is having
some bit set in one of it's words.  This 268435456 value is
"0x10000000" hexadecimal.  The code expects the value zero, and we
have a stray bit being set in there, bit 28 to be exact.  This would
actually be expected after you trigger something like that
destroy_inode() bug as a buffer is being free'd up twice.
