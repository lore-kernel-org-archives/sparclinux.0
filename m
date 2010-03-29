From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Mon, 29 Mar 2010 22:21:34 +0000
Subject: Re: [BUG] fault while using perf callchains in sparc64
Message-Id: <20100329222132.GB12254@nowhere>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329211149.GK5101@nowhere> <20100329.141920.243015356.davem@davemloft.net> <20100329212839.GA12254@nowhere> <20100329.150253.11262563.davem@davemloft.net>
In-Reply-To: <20100329.150253.11262563.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, Mar 29, 2010 at 03:02:53PM -0700, David Miller wrote:
> From: Frederic Weisbecker <fweisbec@gmail.com>
> Date: Mon, 29 Mar 2010 23:28:42 +0200
> 
> > It's a Niagara 2 based one.
> 
> Strange, that's what I do all of my main sparc64 kernel
> work on too.  I've never seen these spurious 'as' crashes.
> 
> Hmmmm, what does "ldd /usr/bin/as" give you?
> 
> Thanks.


$ ldd /usr/bin/as
	libopcodes-2.18.0.20080103.so => /usr/lib/libopcodes-2.18.0.20080103.so (0xf7ec4000)
	libbfd-2.18.0.20080103.so => /usr/lib/libbfd-2.18.0.20080103.so (0xf7e14000)
	libc.so.6 => /lib/libc.so.6 (0xf7ca0000)
	/lib/ld-linux.so.2 (0xf7efc000)

The last kernel I know that don't have such problems is 2.6.31-rc6
May be I should bisect?

