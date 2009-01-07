From: David Miller <davem@davemloft.net>
Date: Wed, 07 Jan 2009 23:07:12 +0000
Subject: Re: hardirq.h removal broke sparc64 build...
Message-Id: <20090107.150712.27763774.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090107.144310.79937111.davem@davemloft.net>
	<20090107145822.625960f2.akpm@linux-foundation.org>
In-Reply-To: <20090107145822.625960f2.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: rmk+kernel@arm.linux.org.uk, adobriyan@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 7 Jan 2009 14:58:22 -0800

> On Wed, 07 Jan 2009 14:43:10 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:
> 
> > for the drivers/base/topology.o build failure case above.
> 
> yes, there were some nasty problems liek that.  In several cases we wimped
> out and added the necessary includes to the .c file.  Will that (sad hack)
> work here?

I'll try that but if other gremlins pop up I'll simply
add a linux/hardirq.h include to arch/sparc/include/asm/local.h
