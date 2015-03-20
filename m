From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 01:55:28 +0000
Subject: Re: [PATCH] sparc: perf: Remove redundant perf_pmu_{en|dis}able calls
Message-Id: <20150319.215528.1545324728135817458.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795557-135648-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795557-135648-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 16:05:57 -0400

> perf_pmu_disable is called by core perf code before pmu->del and the
> enable function is called by core perf code afterwards. No need to
> call again within sparc_pmu_del.
> 
> Ditto for pmu->add and sparc_pmu_add.
> 
> Signed-off-by: David Ahern <david.ahern@oracle.com>
> Acked-by: Bob Picco <bob.picco@oracle.com>

Applied, thanks David.

I wonder why I coded it this way, maybe long ago in the past
the caller didn't do this.
