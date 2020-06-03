From: David Miller <davem@redhat.com>
Date: Wed, 03 Jun 2020 01:38:16 +0000
Subject: Re: [PATCH 2/5] silo: Build with -U_FORTIFY_SOURCE
Message-Id: <20200602.183816.25711110268130552.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 13:22:30 -0700

> Otherwise the build will fail:
> 
> | ld: decompnet.o: in function `error':
> | decomp.c:(.text+0x4dc): undefined reference to `__longjmp_chk'
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Applied.
