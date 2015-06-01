From: David Miller <davem@davemloft.net>
Date: Mon, 01 Jun 2015 05:46:09 +0000
Subject: Re: [PATCH v3] sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
Message-Id: <20150531.224609.1847633713592981166.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1432742446-18731-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1432742446-18731-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: bob.picco@oracle.com, kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, sam@ravnborg.org, rickard_strandqvist@spectrumdigital.se, allen.pais@oracle.com, iamjoonsoo.kim@lge.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 27 May 2015 10:00:46 -0600

> sparc: Resolve conflict between sparc v9 and M7 on usage of bit 9 of TTE
> 
> Bit 9 of TTE is CV (Cacheable in V-cache) on sparc v9 processor while
> the same bit 9 is MCDE (Memory Corruption Detection Enable) on M7
> processor. This creates a conflicting usage of the same bit. Kernel
> sets TTE.cv bit on all pages for sun4v architecture which works well
> for sparc v9 but enables memory corruption detection on M7 processor
> which is not the intent. This patch adds code to determine if kernel
> is running on M7 processor and takes steps to not enable memory
> corruption detection in TTE erroneously.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>

Applied.
