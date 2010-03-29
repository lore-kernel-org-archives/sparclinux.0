From: David Miller <davem@davemloft.net>
Date: Mon, 29 Mar 2010 22:32:08 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329.153208.190256896.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329212839.GA12254@nowhere>
	<20100329.150253.11262563.davem@davemloft.net>
	<20100329222132.GB12254@nowhere>
In-Reply-To: <20100329222132.GB12254@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Tue, 30 Mar 2010 00:21:34 +0200

> $ ldd /usr/bin/as
> 	libopcodes-2.18.0.20080103.so => /usr/lib/libopcodes-2.18.0.20080103.so (0xf7ec4000)
> 	libbfd-2.18.0.20080103.so => /usr/lib/libbfd-2.18.0.20080103.so (0xf7e14000)
> 	libc.so.6 => /lib/libc.so.6 (0xf7ca0000)
> 	/lib/ld-linux.so.2 (0xf7efc000)

Ok, same here.

> The last kernel I know that don't have such problems is 2.6.31-rc6
> May be I should bisect?

Hmmm, since you know a good and bad point, yes a bisect
might be the best way to proceed here.

It might be quicker if you first test 2.6.32 and 2.6.33
and then use the results of that to guide your bisect.

Anyways, if you narrow it down to a commit I should be
able to fix this quickly.

Thanks!
