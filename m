From: David Miller <davem@davemloft.net>
Date: Wed, 13 May 2020 22:26:43 +0000
Subject: Re: [PATCH] silo: Allow building tilo only
Message-Id: <20200513.152643.1516227645836020449.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200406202716.4008090-1-mattst88@gmail.com>
In-Reply-To: <20200406202716.4008090-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Matt Turner <mattst88@gmail.com>
Date: Mon,  6 Apr 2020 13:27:16 -0700

> The bootloader bits are built as 32-bit, which can be difficult to do on
> a system with a 64-bit userland since they include system headers.
> 
> Specifically, the inclusion of <gnu/stubs-32.h> is problematic since
> this header is not provided on a non-multilib build of glibc.
> 
> 	<gnu/stubs-32.h>, included by
> 	<gnu/stubs.h>, included by
> 	<features.h>, included by
> 	<elf.h> and <setjmp.h>
> 
> tilo is built for the host machine and doesn't have this problem.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Applied, thanks Matt.
