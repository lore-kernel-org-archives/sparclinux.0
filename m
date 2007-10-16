From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 16 Oct 2007 13:29:27 +0000
Subject: [Q] iSCSI on sparc64
Message-Id: <4714BCB7.5080607@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I'm testing target-iscsi on a debian/sparc. On target side, I can see a 
lot of messages like :

Kernel unaligned access at TPC[1016b334] 
set_offset_and_length+0xdc/0x1a0 [iscsi_trgt]

	and a BUG! on initiator side. I'm not sure that BUG! comes from "Kernel 
unaligned access". What is signification of these messages ? Can I use 
target-iscsi daemon without more trouble ? I post here because these 
messages are arch specific (no one on i386 nor ppc32).

	Thanks in advance,

	JKB
