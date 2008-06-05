From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jun 2008 18:34:09 +0000
Subject: Re: RFC: remove CONFIG_SUN4 support?
Message-Id: <20080605.113409.161225512.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080605182755.GM1469@cs181133002.pp.htv.fi>
In-Reply-To: <20080605182755.GM1469@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 5 Jun 2008 21:28:25 +0300

> Are there reports of the code code being anywhere near at being working 
> or could I remove it?

At one point it worked to some extent, but it's rotted
quite extensively as you have noticed.

I'd be happy to remove the CONFIG_SUN4 stuff for 2.6.27,
anyone interested can resurrect the code.
