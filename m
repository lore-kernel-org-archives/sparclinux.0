From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 01 Sep 2005 21:21:23 +0000
Subject: Re: [PATCH 1/2] Enable magic SysRq key on SunZilog serial console
Message-Id: <20050901.142123.67731859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050817205345.GA9337@palantir8>
In-Reply-To: <20050817205345.GA9337@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 17 Aug 2005 21:53:45 +0100

> It seems to me that all the BRK_ABRT handling in sunzilog_receive_chars()
> never gets executed, and could be cleaned up. Can anyone confirm/deny
> this?

We run receive processing first, and OR in the BRK_ABRT bit
to the "r1" variable from the control register.

Only later do we do status processing and actually clear
the interrupt status in the control register.

So the break handling code in sunzilog_receive_chars() very
much should be getting used.
