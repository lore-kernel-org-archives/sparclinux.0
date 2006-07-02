From: David Miller <davem@davemloft.net>
Date: Sun, 02 Jul 2006 16:32:31 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <20060702.093231.74721293.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rene Rebe <rene@exactcode.de>
Date: Sun, 2 Jul 2006 17:14:19 +0200

> Is there any chance the post 2.6.17 sparc64 and tg3 changes make a
> difference or should I rather really try hard to reprouce it with the
> 2.6.17.2 kernel to find the real culprit?

2.6.17.x should be extremely stable and there is nothing
in the current tree that ought to fix this.

Please retry with gcc-4.0.x, I really want to eliminate
gcc-4.1.x because that compiler has caused problems for
other folks.  In fact I'm almost hoping it's a gcc-4.1.x
problem so we can investigate it using this test case and
fix it :)

