From: David Miller <davem@davemloft.net>
Date: Thu, 04 Dec 2008 03:35:36 +0000
Subject: Re: [PATCH] Fix VIS emulation bugs
Message-Id: <20081203.193536.21650274.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Joseph S. Myers" <joseph@codesourcery.com>
Date: Thu, 4 Dec 2008 00:41:50 +0000 (UTC)

> This patch fixes some bugs in VIS emulation that cause the GCC test
> failure
> 
> FAIL: gcc.target/sparc/pdist-3.c execution test

Thanks a lot for this fix, I'd been noticing that failure
and had been meaning to look into it.

> for both 32-bit and 64-bit testing on hardware lacking these
> instructions.  The emulation code for the pdist instruction uses
> RS1(insn) for both source registers rs1 and rs2, which is obviously
> wrong and leads to the instruction doing nothing (the observed
> problem), and further inspection of the code shows that RS1 uses a
> shift of 24 and RD a shift of 25, which clearly cannot both be right;
> examining SPARC documentation indicates the correct shift for RS1 is
> 14.
> 
> This patch fixes the bug if single-stepping over the affected
> instruction in the debugger, but not if the testcase is run
> standalone.  For that, Wind River has another patch I hope they will
> send as a followup to this patch submission.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Patch applied, thanks!
