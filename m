From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jul 2006 18:20:26 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <20060703.112026.71116636.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ben Collins <bcollins@ubuntu.com>
Date: Mon, 03 Jul 2006 12:16:15 -0400

> Was this an SMP machine/kernel? If so, it sounds like the scheduler
> tuning bug, fixed in the latest kernel (maybe dave knows git sha).

It is on a T1000, SMP is a given :)
