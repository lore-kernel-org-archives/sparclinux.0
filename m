From: Brad Spengler <spender@grsecurity.net>
Date: Tue, 22 Jun 2010 23:16:14 +0000
Subject: Unaligned accesses w/ generic segmentation/rx/tx offloading
Message-Id: <20100622231614.GA10926@grsecurity.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm running the 2.6.32.15 kernel on a Sun Blade 2500 with the tg3=20
driver.
gcc version is:
gcc --version
gcc (Debian 4.3.2-1.1) 4.3.2

When rx/tx/generic segmentation offloading is disabled:
ethtool -k eth0
Offload parameters for eth0:
rx-checksumming: off
tx-checksumming: off
scatter-gather: off
tcp segmentation offload: off
udp fragmentation offload: off
generic segmentation offload: off
large receive offload: off

I've received several unaligned access messages:
Kernel unaligned access at TPC[6dae50]
Kernel unaligned access at TPC[6dae58]
Kernel unaligned access at TPC[6c8788]
Kernel unaligned access at TPC[6c8798]
Kernel unaligned access at TPC[704864]
They've only occurred once so far in a week or so, so I won't be able to=20
reproduce it at will.

The unaligned accesses appear to come from the following sources:

net/ipv4/tcp_output.c:tcp_transmit_skb():
6dae50:       c2 26 e0 04     st  %g1, [ %i3 + 4 ]
6dae58:       c2 26 e0 08     st  %g1, [ %i3 + 8 ]
If my analysis is correct, these are the two lines at 666 in 2.6.32.15:
        th->seq                 =3D htonl(tcb->seq);
        th->ack_seq             =3D htonl(tp->rcv_nxt);
the problem being the unaligned th.
net/ipv4/ip_output.c:ip_queue_xmit():
6c8788:       c2 24 20 0c     st  %g1, [ %l0 + 0xc ]
6c8798:       c2 24 20 10     st  %g1, [ %l0 + 0x10 ]
If my analysis is correct, these are the two lines at 376 in 2.6.32.15:
        iph->saddr    =3D rt->rt_src;
        iph->daddr    =3D rt->rt_dst;
the problem being an unaligned iph.
arch/sparc/lib/ipcsum.S:ip_fast_csum() (2nd asm instruction, unaligned iph)

I've uploaded the associated vmlinux for analysis to:
http://grsecurity.net/unaligned-vmlinux

Please keep me on CC for any replies.

Thanks,
-Brad

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwhRD4ACgkQmHm2SUJF1Gq3DgCeMcjMka5M2nOHNA38iZGLwhob
pIEAoIcJQQ4cl4fW9DdCTNRFNUCbe/sJ
=4Ted
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
