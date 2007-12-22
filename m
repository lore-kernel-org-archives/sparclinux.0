From: Andrew Morton <akpm@linux-foundation.org>
Date: Sat, 22 Dec 2007 05:00:58 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071221210058.b30fef27.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20071220.045359.107684960.davem@davemloft.net>
	<20071220.161726.68534356.davem@davemloft.net>
	<20071221010653.GA19691@waste.org>
	<200712212251.46397.m.kozlowski@tuxland.pl>
In-Reply-To: <200712212251.46397.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Matt Mackall <mpm@selenic.com>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, 21 Dec 2007 22:51:45 +0100 Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> > Here's a test patch:
> 
> Tested on 2.6.23 and 2.6.24-rc5-mm1. The patch fixes the bug.
> 
> Thanks a lot to both of you.

Thank you for testing -mm (especially on sparc64) and for reporting
the bug and for testing the fix.
