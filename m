From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jun 2017 18:15:28 +0000
Subject: Re: [PATCH 0/3] Suppressing version generation failed warnings in sparc
Message-Id: <20170619.141528.720964026338728733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497892130-875525-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1497892130-875525-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Mon, 19 Jun 2017 13:08:47 -0400

> Compiling the sparc build of upstream kernel generates lots of warnings
> regarding version generation failure for functions defined in assembly files.
> This can be easily suppressed by adding those function prototypes to
> asm/asm-prototypes.h as in powerpc architecture. The following series of patches
> aims to clean the following warnings.
 ...
> With the fix, all these warnings will be removed during compilation.

Thanks for fixing this, series applied and queued up for -stable.
