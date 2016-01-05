From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jan 2016 21:44:51 +0000
Subject: Re: [PATCH] sparc64: Fix numa node distance initialization
Message-Id: <20160105.164451.2216133983176590876.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1451986811-197131-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1451986811-197131-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Tue,  5 Jan 2016 01:40:11 -0800

> @@ -1374,6 +1367,14 @@ static int __init bootmem_init_numa(void)
>  	numadbg("bootmem_init_numa()\n");
>  
>  	if (numa_enabled) {
> +		int i, j;
> +		/* Some sane defaults for numa latency values */
> +		for (i = 0; i < MAX_NUMNODES; i++) {

There needs to be an empty line between local variable declarations
and other code.
