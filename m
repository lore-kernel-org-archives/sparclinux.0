From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 May 2004 11:21:01 +0000
Subject: 2.6.6: pci_{alloc,free}_consistent missing?
Message-Id: <Pine.GSO.4.44.0405101420310.13504-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Compiling 2.6.6 on sparc64 with modular ALSA sound gives these
unresolved symbols:

*** Warning: "pci_free_consistent" [sound/core/snd-page-alloc.ko] undefined!
*** Warning: "pci_alloc_consistent" [sound/core/snd-page-alloc.ko] undefined!

Is this a sparc64 specific symbol export problem or something deeper?

-- 
Meelis Roos (mroos@linux.ee)

