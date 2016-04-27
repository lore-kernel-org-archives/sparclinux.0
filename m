From: Meelis Roos <mroos@linux.ee>
Date: Wed, 27 Apr 2016 19:55:19 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <alpine.LRH.2.20.1604272300160.28737@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > Therefore some other aspect of the change is causing problems and I
> > think that aspect is the size of the new code.
> 
> Actually, there is a way to prove that this is indeed the bug, Meelis
> what does the entry for "swapper_tsb" say in your System.map file for
> a failing kernel?
> 
> If it is not "0000000000408000", then that shows the bug.

It shows the bug in the newest kernel on my V240:

System.map-4.0.0:0000000000408000 T swapper_tsb
System.map-4.0.0-2-sparc64-smp:0000000000408000 T swapper_tsb
System.map-4.1.0:0000000000408000 T swapper_tsb
System.map-4.2.0:0000000000408000 T swapper_tsb
System.map-4.3.0-00063-gea2d67b:0000000000408000 T swapper_tsb
System.map-4.3.0-08824-g7c623ca:0000000000408000 T swapper_tsb
System.map-4.4.0-rc8-00005-gee9a7d2:0000000000408000 T swapper_tsb
System.map-4.5.0-rc3:0000000000408000 T swapper_tsb
System.map-4.5.0-rc4-00037-g65c23c6:0000000000408000 T swapper_tsb
System.map-4.6.0-rc4-00007-g95d0c42:0000000000408028 T swapper_tsb

-- 
Meelis Roos (mroos@linux.ee)
