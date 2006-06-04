From: Richard Braun <syn@sceen.net>
Date: Sun, 04 Jun 2006 05:52:24 +0000
Subject: Re: Checksum problem on sparc64
Message-Id: <20060604055224.GA17666@sceen.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <sparclinux.vger.kernel.org>
References: <20060323223510.GA7683@sceen.net>
In-Reply-To: <20060323223510.GA7683@sceen.net>
To: sparclinux@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Some time ago, I sent a message about bad TCP checkums in some packets.
I've been able to get more free time and track the bug. Here is the story :

The bug is triggered by tcp_fragment() in net/ipv4/tcp_output.c (I also
had problems with IPv6, but have not yet checked that the origin of the
problem is the same - it probably is). The code involved is :

if (!skb_shinfo(skb)->nr_frags && skb->ip_summed !=3D CHECKSUM_HW) {
	/* Copy and checksum data tail into the new buffer. */
	buff->csum =3D csum_partial_copy_nocheck(skb->data + len, skb_put(buff, ns=
ize), nsize, 0);

	skb_trim(skb, len);

	skb->csum =3D csum_block_sub(skb->csum, buff->csum, len);
}

As many Sun machines have NICs that support hardware TCP/UDP
checksumming, you really need to force linux to use the software
implementation. One way to trigger the bug is to transfer a large amount
of data between two hosts in a LAN, and in the middle of the process,
lower the MTU of the sparc interface. tcp_fragment() should be called.
Depending on the content of the packets, you may or may not get a bad
checksum (let's say it's somehow pseudo-random). When grabbing packets
with tcpdump, don't forget to use -s 0, so that tcpdump gets all the
content of each packet, in order to calculate and check the TCP checksum.

When csum_block_sub() is called, it calls in turn csum_sub() and
csum_add(). In csum_sub(), the second parameter sent to csum_block_sub()
is complemented before being sent to csum_add() (in one's complement
arithmetic, subtracting is adding the complement). But on sparc64, the
csum_partial_xxx functions returns 16 bits words (actually 32 bits words
so that there is room for a carry bit). The value returned by
csum_block_sub() may have the 16 MSB bits set. Later, it is used in
tcp_v4_send_check() (net/ipv4/tcp_ipv4.c), in csum_partial() :
th->check =3D tcp_v4_check(th, len, inet->saddr, inet->daddr,
                         csum_partial((char *)th,
                                      th->doff << 2,
                                      skb->csum));

After lots of checks, it seems that the value returned by csum_partial()
is causing the problem. When skb->csum has the 16 MSB bits set,
csum_partial() forgets to add a carry bit. E.g. :
skb->csum =3D 0xffffabcd
tcphdr_csum =3D 0xdcba
skb->csum + tcphdr_csum =3D 0x100008887

The MSB bit is the 33rd bit and is apparently silently ignored.
The partial checksum is then 1 less than it should be. When returning
the complement of that partial checksum, the value is then 1 more than
it should be.

Here is a tcpdump output from my last message :

13:14:30.397874 > 0800 1416: IP (tos 0x8, ttl  63, id 26859, offset 0, flags
[DF], length: 1400) 10.0.0.2.22 > 84.96.34.158.59002: . [bad tcp cksum 696d
(->696c)!] 3016044:3017392(1348) ack 7729 win 6788 <nop,nop,timestamp 34000=
990
1795720>

You can clearly see that the checksum calculated by tcpdump is 1 more than
the packet checksum.

When studying the sparc64-specific csum_partial() assembly function
(arch/sparc64/lib/checksum.S), I noticed that a 64 bits register is used
to compute the checksum of the given data. But when adding the sum
parameter to that computed value, the code directly folds from 32 bits
to 16 bits. This is where the carry bit is lost. Unfortunately, I'm not
skilled enough in sparc64 assembly language to provide a functional patch
(my tests included a C version of csum_partial()) but I guess it won't
be difficult for any hacker around (say David Miller :-)) to fix this.
After all, it was only about a carry bit. Just a little bit...

Hope it helps :-).

--=20
Richard Braun

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEgnUYBlWsEPLYRi8RAjHKAKCjbaK9r6mDojPTmyhQX+iZ3oNHxQCfaFiu
oq57R/A0HTcVKcK7FnrVzro=
=QXjG
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
