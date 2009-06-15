From: David Miller <davem@davemloft.net>
Date: Mon, 15 Jun 2009 08:48:39 +0000
Subject: Re: [PATCH] silo: move second to make room for larger kernel
Message-Id: <20090615.014839.44289818.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A325654.3050201@earthlink.net>
In-Reply-To: <4A325654.3050201@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Newport <crn@netunix.com>
Date: Mon, 15 Jun 2009 02:38:51 +0100 (BST)

> How does the BSD bootloader work ?

BSD uses an fcode bootblock.

Because only MIT/BSD licensed forth tokenizers exist, and also we only
have one 512 byte boot block available, such an implementation really
isn't an option for Linux.
