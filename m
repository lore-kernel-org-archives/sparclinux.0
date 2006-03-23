From: Richard Braun <syn@sceen.net>
Date: Thu, 23 Mar 2006 22:35:10 +0000
Subject: Checksum problem on sparc64
Message-Id: <20060323223510.GA7683@sceen.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm using kernel 2.6.15.6 on my Ultra1 (vanilla kernel without modification=
).
My network setup is a bit weird since I'm using a PPPoE link with MTU 1400 =
(I
have packet losses if using a higher MTU because of the link quality). My N=
AT
router is a 2.6.15.6 kernel too running on i386. The problems I experience
were already present when I used 2.6.12.6 kernel. Now here is the problem :
I have a SSH server on my sparc64 box, and port 22 on the public interface
is redirected to that host. When downloading with sftp for example, everyth=
ing
runs fine until some point. Using tcpdump to discover what was going on,
I captured these packets (on public interface) :

13:14:30.359867 > 0800 1416: IP (tos 0x8, ttl  63, id 26858, offset 0, flags
[DF], length: 1400) 213.41.243.68.22 > 84.96.34.158.59002: . [tcp sum ok]
3703221:3704569(1348) ack 9968 win 6788 <nop,nop,timestamp 34000986 1795720>

13:14:30.397874 > 0800 1416: IP (tos 0x8, ttl  63, id 26859, offset 0, flags
[DF], length: 1400) 10.0.0.2.22 > 84.96.34.158.59002: . [bad tcp cksum 696d
(->696c)!] 3016044:3017392(1348) ack 7729 win 6788 <nop,nop,timestamp 34000=
990
1795720>

Packets were similar on the LAN interface with the exception of NAT for the
first packet :

13:14:30.359816 08:00:20:86:c9:98 > 00:90:27:71:ed:ae, ethertype IPv4 (0x08=
00),
length 1414: IP (tos 0x8, ttl  64, id 26858, offset 0, flags [DF], length:
1400) 10.0.0.2.22 > 84.96.34.158.59002: . [tcp sum ok] 3703221:3704569(1348)
ack 9872 win 6788 <nop,nop,timestamp 34000986 1795720>

13:14:30.397818 08:00:20:86:c9:98 > 00:90:27:71:ed:ae, ethertype IPv4 (0x08=
00),
length 1414: IP (tos 0x8, ttl  64, id 26859, offset 0, flags [DF], length:
1400) 10.0.0.2.22 > 84.96.34.158.59002: . [bad tcp cksum 696d (->696c)!]
3643729:3645077(1348) ack 9872 win 6788 <nop,nop,timestamp 34000990 1795720>

I'm not sure why the tcp checksum is bad. It could be a hardware problem or
a kernel bug. Therefore I decided to report this. I think I have similar
problems with IPv6, but I have not investigated yet. The problem looks quite
random for now, but I can easily reproduce it (I begin a download over sftp,
wait a few seconds/minutes, then the rate drops).

Hope it helps (and sorry for previous private queries btw).

--=20
Richard Braun

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEIyKeBlWsEPLYRi8RAizpAJ9Hfu9+s1lPQ14vd2Bpuoj7srivHwCff4Gr
KLmevCIn2ioSp2N/P+OV72E=
=pdyE
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
