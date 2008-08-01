From: David Miller <davem@davemloft.net>
Date: Fri, 01 Aug 2008 03:27:51 +0000
Subject: Re: sparc asm/ptrace.h use of bool
Message-Id: <20080731.202751.193688925.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080801012135.5B76515427E@magilla.localdomain>
In-Reply-To: <20080801012135.5B76515427E@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Thu, 31 Jul 2008 18:21:35 -0700 (PDT)

> You could either move those new functions inside #ifdef __KERNEL__, or if
> you want them exported for userland, just make them use int instead of bool.

I think I'll add __KERNEL__ ifdef protection, thanks for the report!
