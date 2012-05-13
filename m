From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2012 22:15:17 +0000
Subject: Re: [PATCH] sparc32: Convert mmu_* interfaces from btfixup to method ops.
Message-Id: <20120513.181517.477722543658847052.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.170134.51396229221676970.davem@davemloft.net>
In-Reply-To: <20120513.170134.51396229221676970.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 23:41:19 +0200

> Are we going for _ops for everything?

As a first step that is my plan.

I think if we can erradicate btfixup entirely this way,
it's a good first step.
