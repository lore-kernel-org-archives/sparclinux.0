From: David Miller <davem@davemloft.net>
Date: Thu, 07 Jul 2016 01:49:29 +0000
Subject: Re: [PATCH v3 3/7] sparc: support static_key usage in non-module __exit sections
Message-Id: <20160706.184929.373589229424928717.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1467837322.git.jbaron@akamai.com>
	<cover.1467837322.git.jbaron@akamai.com>
	<d822da427ab07a02a394602eca687104ff682f83.1467837322.git.jbaron@akamai.com>
In-Reply-To: <d822da427ab07a02a394602eca687104ff682f83.1467837322.git.jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jbaron@akamai.com
Cc: akpm@linux-foundation.org, joe@perches.com, peterz@infradead.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>
Date: Wed,  6 Jul 2016 17:42:32 -0400

> The jump table can reference text found in an __exit section. Thus,
> instead of discarding it at build/link time, include EXIT_TEXT as part
> of __init and release it at system boot time.
> 
> Without this patch the link fails with:
> 
>     `.exit.text' referenced in section `__jump_table' of xxx.o:
>     defined in discarded section `.exit.text' of xxx.o
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Acked-by: David S. Miller <davem@davemloft.net>
