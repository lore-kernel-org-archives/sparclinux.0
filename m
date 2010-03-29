From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 22:02:53 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329.150253.11262563.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329211149.GK5101@nowhere>
	<20100329.141920.243015356.davem@davemloft.net>
	<20100329212839.GA12254@nowhere>
In-Reply-To: <20100329212839.GA12254@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 29 Mar 2010 23:28:42 +0200

> It's a Niagara 2 based one.

Strange, that's what I do all of my main sparc64 kernel
work on too.  I've never seen these spurious 'as' crashes.

Hmmmm, what does "ldd /usr/bin/as" give you?

Thanks.
