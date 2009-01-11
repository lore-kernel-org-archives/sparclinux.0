From: David Miller <davem@davemloft.net>
Date: Sun, 11 Jan 2009 21:50:29 +0000
Subject: Re: cpumask change causes sparc build bustage
Message-Id: <20090111.135029.199678338.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090111205008.db0a410e.sfr@canb.auug.org.au>
	<20090111.040640.188129980.davem@davemloft.net>
	<496A232A.5070801@sgi.com>
In-Reply-To: <496A232A.5070801@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: travis@sgi.com
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, mingo@elte.hu, rusty@rustcorp.com.au

From: Mike Travis <travis@sgi.com>
Date: Sun, 11 Jan 2009 08:49:46 -0800

> Thanks for fixing it.  In actuality though, it should return cpu_mask_all
> instead of CPU_MASK_ALL_PTR but that's a small nit.

CPU_MASK_ALL_PTR is defined to &cpu_mask_all, that's why I used it, to
be consistent with the other macro using CPU_MASK_ALL right above it.
