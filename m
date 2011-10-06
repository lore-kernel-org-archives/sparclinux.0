From: David Miller <davem@davemloft.net>
Date: Thu, 06 Oct 2011 05:48:54 +0000
Subject: Re: [PATCH 3/4] sparc32,leon: Add support for KGDB when SMP and
Message-Id: <20111006.014854.1022164572126386055.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381744-24862-3-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381744-24862-3-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 30 Sep 2011 15:47:29 +0200

> This patch enables KGDB support when SMP is enabled. The smp
> kgdb_roundup_cpus function is currently only implemented for SPARC_LEON,
> however if !SPARC_LEON && SMP is enabled then KGDB will be disabled.
> 
> Signed-off-by: Konrad Eisele <konrad@gaisler.com>

It shouldn't be all that hard to add support for the other sparc32
cases too, especially since we did all of that recent work to clean up
the cross-call interrupt handling.

Could you please at least throw something together so we can throw
away that ugly KGDB conditional?

Once you rewrite this patch in that way, I'll apply this whole series.

Thanks.
