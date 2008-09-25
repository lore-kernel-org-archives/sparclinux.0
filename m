From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2008 01:48:47 +0000
Subject: Re: sparc-next RTC BUG: sleeping function called from invalid
Message-Id: <20080924.184847.154699688.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48DAE90C.7010608@earthlink.net>
In-Reply-To: <48DAE90C.7010608@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 24 Sep 2008 21:27:40 -0400

> I'm getting this repeatable BUG from sparc-next with almost all
> kernel debugging options turned on shortly after booting:
 ...
> Let me know if you need more info.

It's a known issue, but thanks for reporting.

The RTC folks have a plan to merge a change that will eliminate
this problem, so for now simply ignore this warning.
