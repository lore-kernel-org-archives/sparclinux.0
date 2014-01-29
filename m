From: David Miller <davem@davemloft.net>
Date: Wed, 29 Jan 2014 07:38:56 +0000
Subject: Re: [PATCH] sparc: delete non-required instances of include <linux/init.h>
Message-Id: <20140128.233856.8207808883976477.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1389039939-18314-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389039939-18314-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 6 Jan 2014 15:25:39 -0500

> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.
