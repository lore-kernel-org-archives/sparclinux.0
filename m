From: "Marcel van Nies" <morcles@gmail.com>
Date: Mon, 10 Dec 2007 22:06:09 +0000
Subject: [BUG] Kernel unaligned access - tcp_transmit_skb
Message-Id: <c75cfb180712101406q64d8d242n9eb13aaf7c373eb7@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi ,

On my SUN Ultra 60 I use OpenVPN in tcp-client mode.
I use TAP devices to setup the tunnel.

I noticed I receive these five messages whenever the tunnel is up.

Kernel unaligned access at TPC[632208] tcp_transmit_skb+0x170/0x8a0
Kernel unaligned access at TPC[632210] tcp_transmit_skb+0x178/0x8a0
Kernel unaligned access at TPC[63251c] tcp_transmit_skb+0x484/0x8a0
Kernel unaligned access at TPC[632524] tcp_transmit_skb+0x48c/0x8a0
Kernel unaligned access at TPC[63252c] tcp_transmit_skb+0x494/0x8a0

They repeat every N seconds (depends on keepalive setting on server-side).

After some rebooting I found out that the bug is introduced in 2.6.23.4.
Up to and including 2.6.23.3 everything is fine.

A 2.6.23.3 kernel with only this additional patch (from 2.6.23.4)
'TCP: Fix size calculation in sk_stream_alloc_pskb'
http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.23.y.git;a=3Dc=
ommit;h=9Fcba4716e6ebbb0d7e0ec84bff6dd2c36c847b3
has the bug too.

Regards,
Marcel
