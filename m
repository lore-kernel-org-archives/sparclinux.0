From: David Miller <davem@davemloft.net>
Date: Sun, 08 Nov 2009 08:28:15 +0000
Subject: Re: [PATCH] sparc,sparc64: replace parentheses in pmul()
Message-Id: <20091108.002815.06996631.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AF3000C.8080607@gmail.com>
In-Reply-To: <4AF3000C.8080607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: roel.kluin@gmail.com
Cc: sparclinux@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 05 Nov 2009 17:40:44 +0100

> `>>' has a higher precedence than `?' so src2 evaluated to
> either 16 or 0 dependent on the bits set in rs2.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/sparc/kernel/visemul.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> I am not 100% sure that the code was incorrect, however, if it
> was intended I think it is a very strange way to write it.

Your fix is correct, thanks Roel!

I really need to write a testsuite for this VIS emulation code.
