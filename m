From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 01:55:44 +0000
Subject: Re: [PATCH] sparc: perf: Make counting mode actually work
Message-Id: <20150319.215544.2213881660348662455.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795577-135680-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795577-135680-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 16:06:17 -0400

> Currently perf-stat (aka, counting mode) does not work:
 ...
> The reason is that state is never reset (stays with PERF_HES_UPTODATE set).
> Add a call to sparc_pmu_enable_event during the added_event handling.
> Clean up the encoding since pmu_start calls sparc_pmu_enable_event which
> does the same. Passing PERF_EF_RELOAD to sparc_pmu_start means the call
> to sparc_perf_event_set_period can be removed as well.
> 
> With this patch:
 ...
> Signed-off-by: David Ahern <david.ahern@oracle.com>
> Acked-by: Bob Picco <bob.picco@oracle.com>

Looks great, applied.
