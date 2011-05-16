From: David Miller <davem@davemloft.net>
Date: Mon, 16 May 2011 20:40:10 +0000
Subject: Re: [PATCH] sparc: convert old cpumask API into new one
Message-Id: <20110516.134010.39174667.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110429001547.3D6C.A69D9226@jp.fujitsu.com>
In-Reply-To: <20110429001547.3D6C.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kosaki.motohiro@jp.fujitsu.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Fri, 29 Apr 2011 00:14:08 +0900 (JST)

> Adapt new API. Almost change is trivial, most important change are to
> remove following like =operator.
> 
>  cpumask_t cpu_mask = *mm_cpumask(mm);
>  cpus_allowed = current->cpus_allowed;
> 
> Because cpumask_var_t is =operator unsafe. These usage might prevent
> kernel core improvement.
> 
> No functional change.
> 
> Signed-off-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

Applied, thanks.
