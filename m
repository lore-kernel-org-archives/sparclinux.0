From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Mon, 03 Aug 2009 20:05:00 +0000
Subject: Re: sparc-leon patches round 5 (to follow) (right numbering)
Message-Id: <20090803200500.GA13525@alpha.franken.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20090802.195140.26174602.davem@davemloft.net>
In-Reply-To: <20090802.195140.26174602.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Aug 03, 2009 at 03:05:32PM -0400, konrad@gaisler.com wrote:
> big. So  I thought that first get the Leon part of arch/sparc in
> and then figure out how to proceed with drivers/ambapp. amba_init will 
> scan the AMBA bus and detect the connected

how about using one of various XXX_initcall() things from include/linux/init.h
subsys_initcall sounds about right... That way you don't have to mess in the
 sparc code, but could put it into your driver subdir...

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
