From: David Miller <davem@davemloft.net>
Date: Thu, 01 Apr 2010 08:09:03 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100401.010903.05627158.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329222132.GB12254@nowhere>
	<20100329.153208.190256896.davem@davemloft.net>
	<20100401090608.GD5207@nowhere>
In-Reply-To: <20100401090608.GD5207@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Thu, 1 Apr 2010 11:06:11 +0200

> I actually can't. It works well on a backup 2.6.31-rc6 kernel
> but when I build a new one of this same version, the problem
> happens again. And I don't have the config of the one that works
> (and no /proc/config.gz as well).
> 
> So I suspect this is something that happens with some specific
> configs only.
> 
> Anyway, once I get more clues about this, I'll tell you.

I was going to ask you if any of your compiler tools changed
recently...

Check the gcc version printed by the working kernel at the top of the
dmesg logs and compare to what you end up using now.
