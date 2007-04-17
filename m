From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 17 Apr 2007 15:28:24 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <4624E798.7000705@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	Some news about this new driver on sparc32.
Test configuration : SS20 with dual SM71, 448 MB, VSIMM, internal raid1, 
  ESP100A and HME-ESP (UW). All esp patches are applied against 
2.6.21-rc7 (thus with new IOMMU Sbus support).

	The obtained kernel can boot with init=/bin/bash, but is unable to boot 
with init=2. All ESP interfaces are shown and initialized, all disks 
(two internal ID1 and 3 and CDROM ID6). When kernel starts init, I can 
see on console :

	esp: esp0: reconnect, tag type changed 22 --> 00

followed by a lot of insaned messages :-(

	Aborting command, queued command...
	...
	sd 0:0:3:0 rejecting I/O to offline device
	...

	Regards,

	JKB

