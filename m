From: David Miller <davem@davemloft.net>
Date: Mon, 20 Oct 2014 18:57:46 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141020.145746.428441452740929005.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410170012130.19924@adalberg.ut.ee>
	<20141019.003209.2286339581794609198.davem@davemloft.net>
	<alpine.LRH.2.11.1410191006430.32417@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410191006430.32417@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Oct 2014 10:07:03 +0300 (EEST)

>> From: Meelis Roos <mroos@linux.ee>
>> Date: Fri, 17 Oct 2014 00:38:20 +0300 (EEST)
>> 
>> > arch/sparc/kernel/setup_64.c is the only culprit.
>> > 
>> > Attached are 2 versions of the object file as of v3.17-rc1-22-g480cadc 
>> > that I tested.
>> 
>> Just to confirm, a gcc-4.9 compiled kernel works if just setup_64.c
>> is built with gcc-4.6, is that correct?
> 
> Yes, exactly.

Just an update, I have an environment where I can perfectly reproduce
this.  I have a gcc-4.9 SVN built that compiles kernels which crash
the same way it does for you.

I'll let you know when I make more progress.
