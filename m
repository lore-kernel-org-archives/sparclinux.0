From: Meelis Roos <mroos@linux.ee>
Date: Thu, 22 Jul 2004 17:18:46 +0000
Subject: Re: Weird serial problems in 2.6.7
Message-Id: <Pine.GSO.4.44.0407222017200.27513-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20040721064705.GE23921@triplehelix.org>
In-Reply-To: <20040721064705.GE23921@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > JK> eh:HPYMA PICerO 010ae tent 8:0:0:d:3:7
> >
> > So the same symptoms that I saw were not PC serial problems afterall...
>
> It could be a PC problem: the machine on the other end was an i686. But
> my SS10's serial output doesn't seem to exhibit the same problems.

I recompiled my PC kernel with PREEMPT and 4Kstacks off and sparc64
serial output is still garbled. The PC has been used as the other end of
serial consoles (with minicom) a lot before so I thinks it's sparc64
serial at fault here.

-- 
Meelis Roos (mroos@linux.ee)

