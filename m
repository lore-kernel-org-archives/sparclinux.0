From: bertrand <joel.bertrand@systella.fr>
Date: Tue, 20 Mar 2007 09:03:23 +0000
Subject: Ultra2 SMP freezes with heavy disk I/O
Message-Id: <45FFA35B.1040203@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	A U2 (2 GB, 2 UltraSPARC-II, 2 73 GB SCSI disks [raid1]) is running 
Debian/testing with 2.6.20.3 kernel. This station is used as mail server 
and I have seen some freezes. When it freezes, sysrq or stop+A do not 
work (not panic nor Oops, only freeze).

	I have tested 2.6.18 (from debian), 2.6.20.x without any success. When 
I boot with root=/dev/sda4 instead root=/dev/md1, system is more stable 
(but not enough to be a mail server :-( ).

	With 2.4 kernel and without raid1 (I don't understand  why I cannot use 
my raid1 volumes with 2.4 kernel...), system is stable and does not 
freeze. I have tested hardware with SUNvts (from Solaris 9) and it 
sounds good.

	With the _same_ kernel, an U60-SMP is stable. The difference between 
both kernel are only Sbus versus PCI support _and_ ESP-SCSI version 
Symbios support. I suspect a bug in the ESP-SCSI support but I don't 
know how investigate. I cannot boot any 2.6.20 with debug option du to a 
"address not aligned" message when it boots.

	Any suggestion ?

	Regards,

	JKB
