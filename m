From: David Miller <davem@davemloft.net>
Date: Wed, 17 May 2017 19:09:10 +0000
Subject: Re: [PATCH] sparc/ftrace: Fix ftrace graph time measurement
Message-Id: <20170517.150910.488098081591695326.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495036020-30551-1-git-send-email-Liam.Howlett@Oracle.com>
In-Reply-To: <1495036020-30551-1-git-send-email-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 17 May 2017 11:47:00 -0400

> The ftrace function_graph time measurements of a given function is not
> accurate according to those recorded by ftrace using the function
> filters.  This change pulls the x86_64 fix from 'commit 722b3c746953
> ("ftrace/graph: Trace function entry before updating index")' into the
> sparc specific prepare_ftrace_return which stops ftrace from
> counting interrupted tasks in the time measurement.
> 
> Example measurements for select_task_rq_fair running "hackbench 100
> process 1000":
> 
>               |  tracing/trace_stat/function0  |  function_graph
>  Before patch |  2.802 us                      |  4.255 us
>  After patch  |  2.749 us                      |  3.094 us
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Applied, thanks.
