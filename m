From: David Miller <davem@davemloft.net>
Date: Mon, 26 Nov 2018 18:00:46 +0000
Subject: Re: [PATCH v2 16/20] sparc: perf/core: advertise PMU exclusion capability
Message-Id: <20181126.100046.860156356512347227.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
In-Reply-To: <1543230756-15319-17-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Andrew Murray <andrew.murray@arm.com>
Date: Mon, 26 Nov 2018 11:12:32 +0000

> The SPARC PMU has the capability to exclude events based on context
>  - let's advertise that we support the PERF_PMU_CAP_EXCLUDE
> capability to ensure that perf doesn't prevent us from handling
> events where any exclusion flags are set.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
