From: David Miller <davem@davemloft.net>
Date: Wed, 26 Mar 2008 11:16:26 +0000
Subject: Re: sparc64 BUG: using smp_processor_id() in preemptible
Message-Id: <20080326.041626.224135350.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.00.0803251856450.2775@woody.linux-foundation.org>
	<200803261142.07422.m.kozlowski@tuxland.pl>
In-Reply-To: <200803261142.07422.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: m.kozlowski@tuxland.pl
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Wed, 26 Mar 2008 11:42:07 +0100

> I see lots of these messages on my ultra 60 box.

This is a sparc64 bug.

To be honest I don't run with preemption enabled very often, but
I'll try to clear this up somehow.
