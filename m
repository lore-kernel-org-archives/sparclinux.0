From: ludo@chbouib.org (Ludovic =?iso-8859-1?Q?Court=E8s?=)
Date: Tue, 17 Apr 2007 18:45:26 +0000
Subject: Re: QuadEthernet driver broken
Message-Id: <87zm564z7d.fsf@chbouib.org>
List-Id: <sparclinux.vger.kernel.org>
References: <87lkgxgxvj.fsf@chbouib.org>
In-Reply-To: <87lkgxgxvj.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

ludo@chbouib.org (Ludovic Court=E8s) writes:

> The `sunqe' driver appears to be currently broken:
>
>   http://lists.debian.org/debian-sparc/2007/04/msg00036.html

To sum up, `sunqe' displays erroneous addresses at initialization time:

  sunqe.c:v4.0 June 23, 2006 David S. Miller (davem@davemloft.net)
  eth0: qe channel[0] 00:00:00:00:00:00=20
  eth1: qe channel[1] 00:00:00:00:00:00=20
  eth2: qe channel[2] 00:00:00:00:00:00=20
  eth3: qe channel[3] 00:00:00:00:00:00

Since these are displayed at module initialization time (in
`qec_ether_init ()'), couldn't it be due to incorrect accesses to the
PROM device tree, somehow related to the recent PROM API change [0]?

Likewise, the oops yielded by `rmmod sunqe' apparently stems from the
`of_unregister_driver ()' call:

  kernel BUG at net/core/dev.c:3236!
                \|/ ____ \|/
                "@'/ ,. \`@"
                /_| \__/ |_\
                   \__U_/
  rmmod(3507): Kernel bad trap [#1]
  PSR: 414000c5 PC: f01390c8 NPC: f01390cc Y: 00000000    Not tainted
  PC: <free_netdev+0x48/0x54>
  %%G: fc000000 414000e4  f01d15f8 f1bb1e60  0000000c f022b740  f12e8000 00=
000000
  %%O: 00000026 f01b7038  00000ca4 00000004  fc000000 00000003  f12e9b58 f0=
1390c0
  RPC: <free_netdev+0x40/0x54>
  %%L: 419000e6 00000010  f0233044 00000010  00000004 00000000  00000000 50=
02a000
  %%I: f1ce1800 00000004  0000e000 f002f000  f0230c60 f0230c00  f12e9bc0 fe=
64f0a4
  Caller[fe64f0a4]: qec_sbus_remove+0x64/0x70 [sunqe]
  Caller[f001b3b0]: of_device_remove+0x2c/0x34
  Caller[f0116f70]: __device_release_driver+0x78/0x8c
  Caller[f0117308]: driver_detach+0x90/0x274
  Caller[f01164c0]: bus_remove_driver+0x7c/0xa0
  Caller[f0117524]: driver_unregister+0x10/0x1c
  Caller[fe650504]: qec_exit+0x10/0x5c [sunqe]
  Caller[f004cd44]: sys_delete_module+0x1cc/0x1f4
  Caller[f0011634]: syscall_is_too_hard+0x3c/0x40
  Caller[00011220]: 0x11228
  Instruction DUMP: 92102ca4  7ffb658c  90122038 <91d02005> c220a174  7fff7=
a57  91ee21d0  01000000  9de3bf98=20

Any idea?

Thanks,
Ludovic.

[0] http://article.gmane.org/gmane.linux.ports.sparc/6322

