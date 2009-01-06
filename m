From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 02:12:48 +0000
Subject: Re: [PATCH] sparc: Fix minor SPARC32 compile error
Message-Id: <20090105.181248.110302394.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4962098A.4070508@gmail.com>
In-Reply-To: <4962098A.4070508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 06 Jan 2009 00:22:18 +1100

> sparc: Fix minor SPARC32 compile error
> 
> When CONFIG_PROC_FS is unset, include/linux/interrupt.h defines
> init_irq_proc() as an empty function.
> 
> arch/sparc/kernel/irq_32.c defines this function unconditionally.
> 
> Fix the latter so that it only defines this function when CONFIG_PROC_FS
> is set.
> 
> This fixes the following error:
> arch/sparc/kernel/irq_32.c:672: error: redefinition of 'init_irq_proc'
> include/linux/interrupt.h:461: error: previous definition of
> 'init_irq_proc' was here
> 
> This was found using randconfig builds.
> 
> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

Applied, thanks a lot Julian.
