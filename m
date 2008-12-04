From: David Miller <davem@davemloft.net>
Date: Thu, 04 Dec 2008 17:12:42 +0000
Subject: Re: [PATCH] Fix VIS emulation bugs
Message-Id: <20081204.091242.99434859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Thu, 04 Dec 2008 09:51:28 -0500

> Hi,
> 
> >> This patch fixes the bug if single-stepping over the affected
> >> instruction in the debugger, but not if the testcase is run
> >> standalone.  For that, Wind River has another patch I hope they will
> >> send as a followup to this patch submission.
> >>
> >> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> > Patch applied, thanks!
> 
> Here's the follow up patch to Joseph's VIS emulation fix.  The pdist
> testcase runs successfully as a standalone with this patch.
 ...
> Copy the FPU state to the task's thread_info->fpregs for the VIS emulation
> functions to access.
> 
> Signed-off-by: Hong H. Pham <hong.pham@windriver.com>

Also applied, thanks a lot!
