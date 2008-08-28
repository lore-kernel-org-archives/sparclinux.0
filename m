From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 10:11:01 +0000
Subject: Re: LTP results on sparc32
Message-Id: <20080828.031101.33791018.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 29 Jun 2008 00:22:16 +0100

> getcontext01                   FAIL       Missing from glibc

I just wanted to mention that I wrote and added an
implementation of this to glibc a montho or two ago
so in the future this won't fail hopefully :)
