From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 17:26:01 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080620.102601.06998427.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806171954060.2560@engineering.redhat.com>
	<20080617.210159.141238856.davem@davemloft.net>
	<Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 11:47:12 -0400 (EDT)

> I took another few traces (to track the whole stack content) and there is 
> another problem: nested interrupts. Does Sparc64 limit them somehow?

Two levels should be the deepest you will ever see, and this is
equivalent to what you get on other platforms.

That path occurs when softirq processing re-enabled HW interrupts when
returning from the top-level interrupt.
