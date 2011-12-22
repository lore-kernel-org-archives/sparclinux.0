From: David Miller <davem@davemloft.net>
Date: Thu, 22 Dec 2011 19:22:04 +0000
Subject: Re: [RFC][PATCH] sparc64: remove __ARCH_WANT_UNLOCKED_CTXSW usage
Message-Id: <20111222.142204.1686212571308551442.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111221.164426.1859065550459950375.davem@davemloft.net>
	<20111221.180549.2295489434558987482.davem@davemloft.net>
	<1324581399.24803.38.camel@twins>
In-Reply-To: <1324581399.24803.38.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, catalin.marinas@arm.com

From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 22 Dec 2011 20:16:39 +0100

> ARM being the last user of that feature, and with only SPARC64 and IA64
> (needlessly) using __ARCH_WANT_UNLOCKED_CTXSW we could finally remove
> some of that hairy code from the core scheduler.

W00t! :-)
