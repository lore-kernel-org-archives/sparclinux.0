From: Christian Kujau <lists@nerdbynature.de>
Date: Wed, 04 Feb 2009 09:07:52 +0000
Subject: Kernel unaligned access at TPC
Message-Id: <alpine.DEB.2.00.0902041001550.4084@bogon.housecafe.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: sparclinux@vger.kernel.org

Hi lkml,

while trying to track -git kernels on this Ultra5, I've seen the following 
messages during bootup since 2.6.29-rc3:

[   94.099721] Kernel unaligned access at TPC[54c818] nsm_get_handle+0x158/0x400
[   94.336558] Kernel unaligned access at TPC[54c81c] nsm_get_handle+0x15c/0x400
[   94.678623] Kernel unaligned access at TPC[54c818] nsm_get_handle+0x158/0x400
[   94.915452] Kernel unaligned access at TPC[54c81c] nsm_get_handle+0x15c/0x400
[   95.252917] Kernel unaligned access at TPC[54c818] nsm_get_handle+0x158/0x400

Searching the net only brought up a post[0] from kernel-testers, but this 
box here is running fine - no filesystem errors or anything. Are these 
messages something to worry about or can they be ignored?

Full dmesg & .config: http://nerdbynature.de/bits/2.6.29-rc3/

Thanks,
Christian.

[0] http://www.mail-archive.com/kernel-testers@vger.kernel.org/msg02959.html
-- 
BOFH excuse #129:

The ring needs another token
