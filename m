From: David Miller <davem@davemloft.net>
Date: Thu, 24 Jan 2008 21:32:38 +0000
Subject: Re: compile failure in Solaris emulation
Message-Id: <20080124.133238.260486001.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0801241625190.21771@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0801241625190.21771@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 24 Jan 2008 16:26:32 +0200 (EET)

> Tried to ompile todays 2.6.24-rc8+git on sparc64 and got this:
> 
>   CC [M]  arch/sparc64/solaris/socksys.o
> arch/sparc64/solaris/socksys.c: In function 'init_socksys':
> arch/sparc64/solaris/socksys.c:192: error: assignment of read-only variable 'socksys_file_ops'
> arch/sparc64/solaris/socksys.c:195: error: assignment of read-only variable 'socksys_file_ops'
> arch/sparc64/solaris/socksys.c:196: error: assignment of read-only variable 'socksys_file_ops'

Already fixed in Linus's tree.
