From: David Miller <davem@davemloft.net>
Date: Thu, 31 Mar 2011 07:52:51 +0000
Subject: Re: [PATCH] SPARC32: wrong scheduling of freshly created processes
Message-Id: <20110331.005251.193699845.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1301557791.5962.19.camel@hp>
In-Reply-To: <1301557791.5962.19.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 31 Mar 2011 11:49:51 +0400

> SPARC32: Pass task_struct to schedule_tail() in ret_from_fork
> 
> Hello, Dave.
> 
> We have to pass task_struct of previous process to function
> schedule_tail(). Currently in ret_from_fork previous thread_info
> is passed:
> 
> switch_to: mov %g6, %g3 /* previous thread_info in g6 */
> 
> ret_from_fork: call    schedule_tail
>                 mov    %g3, %o0 /* previous thread_info is passed */
> 
> void schedule_tail(struct task_struct *prev);
> 
> Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>

Applied, thanks a lot.
