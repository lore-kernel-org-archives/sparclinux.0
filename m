From: Meelis Roos <mroos@linux.ee>
Date: Wed, 25 May 2016 05:11:20 +0000
Subject: Re: newest 4.6.0-08907-g7639dad on sparc64 - possible irq lock inversion dependency detected
Message-Id: <alpine.LRH.2.20.1605250810480.29672@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Oh, we can't do the context reload with interrupts disabled.
> 
> Here is a new version of the patch which should fix this problem as well.

Yes, seems to work - git clones overnight with nothing in dmesg. Thanks!

-- 
Meelis Roos (mroos@linux.ee)
