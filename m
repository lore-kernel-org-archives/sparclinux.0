From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <mt1@systella.fr>
Date: Mon, 26 Jun 2006 12:01:21 +0000
Subject: Re: [PATCH] sparc32: fix iommu_flush_iotlb end address
Message-Id: <449FCC91.2020603@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <449774DB.6090201@mc.net>
In-Reply-To: <449774DB.6090201@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have build a 2.6.17-git7. It can boot with init=/bin/bash but if I 
try to boot with init=2 (debian system), kernel craches when it tries to 
mount local filesystem (watchdog reset or dead lock).

	Configuration : 448 MB, 2*SM71, CG14, raid1.

	I will try a -git10...

	Regards,

	JKB
