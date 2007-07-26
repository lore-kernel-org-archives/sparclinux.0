From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Jul 2007 10:21:01 +0000
Subject: ALSA & missing dma_*_coherent on sparc32
Message-Id: <Pine.SOC.4.64.0707261317001.20971@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel list <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

Tried to compile current 2.6.23-rc1+git on sparc32, along with sparc 
ALSA drivers as usual. But now the compilation is broken because of 
missing dma_*_coherent on sparc32. ISTR this got chenged recently on 
sparc32...

ERROR: "dma_free_coherent" [sound/core/snd-page-alloc.ko] undefined!
ERROR: "dma_alloc_coherent" [sound/core/snd-page-alloc.ko] undefined!

-- 
Meelis Roos (mroos@linux.ee)
