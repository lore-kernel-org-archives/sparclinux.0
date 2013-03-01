From: David Miller <davem@davemloft.net>
Date: Fri, 01 Mar 2013 21:37:59 +0000
Subject: Re: [PATCH 1/2] sparc32,leon: add support for PCI busn resource for LEON
Message-Id: <20130301.163759.716071823193330554.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1362061821-31584-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1362061821-31584-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 28 Feb 2013 15:30:20 +0100

> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

This and the next patch should be combined into one.  You're now registering
&info->busn but callers aren't setting it up properly.
