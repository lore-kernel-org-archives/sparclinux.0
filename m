From: Joerg Friedrich <Joerg.Friedrich@friedrich-kn.de>
Date: Fri, 30 Mar 2007 21:48:57 +0000
Subject: unaligned access in ipt_ULOG
Message-Id: <20070330214857.GB24923@stardust.friedrich-kn.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

I wanted to use the iptables ULOG target, but I ran into these error
messages. can anyone explain howto read this messge.

Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e36c] ipt_ulog_packet+0x224/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e374] ipt_ulog_packet+0x22c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e384] ipt_ulog_packet+0x23c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e36c] ipt_ulog_packet+0x224/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e374] ipt_ulog_packet+0x22c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e384] ipt_ulog_packet+0x23c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e36c] ipt_ulog_packet+0x224/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e374] ipt_ulog_packet+0x22c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e384] ipt_ulog_packet+0x23c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e36c] ipt_ulog_packet+0x224/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e374] ipt_ulog_packet+0x22c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e384] ipt_ulog_packet+0x23c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e36c] ipt_ulog_packet+0x224/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e374] ipt_ulog_packet+0x22c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e384] ipt_ulog_packet+0x23c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e35c] ipt_ulog_packet+0x214/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e36c] ipt_ulog_packet+0x224/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e374] ipt_ulog_packet+0x22c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[1029e384] ipt_ulog_packet+0x23c/0x3fc [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286360] ipt_ulog_packet+0x1c8/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286368] ipt_ulog_packet+0x1d0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[10286378] ipt_ulog_packet+0x1e0/0x4c0 [ipt_U=
LOG]
Kernel unaligned access at TPC[102865b4] ipt_ulog_packet+0x41c/0x4c0 [ipt_U=
LOG]

--=20
J=C3=B6rg Friedrich

There are only 10 types of people:
Those who understand binary and those who don't.
