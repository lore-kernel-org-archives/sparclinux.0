From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2012 23:54:17 +0000
Subject: Re: [PATCH] sparc32, copy_thread: Clear TIF_USEDFPU flag of created task instead of current
Message-Id: <20120726.165417.7078417760147458.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 29 Jun 2012 16:55:25 +0400

> FPU state is saved into task_struct of created task. Current task continues
> use of the state, so it needs TIF_USEDFPU flag is not cleared.
> 
> Created task receives fresh FPU and cleared TIF_USEFPU flag is required for it.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
