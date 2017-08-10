From: David Miller <davem@davemloft.net>
Date: Thu, 10 Aug 2017 22:04:58 +0000
Subject: Re: [PATCH] mm: add pmd_t initializer __pmd() to work around a GCC bug.
Message-Id: <20170810.150458.937727046893542981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170803131721.74011-1-zi.yan@sent.com>
In-Reply-To: <20170803131721.74011-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zi.yan@sent.com
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, zi.yan@cs.rutgers.edu

From: Zi Yan <zi.yan@sent.com>
Date: Thu,  3 Aug 2017 09:17:21 -0400

> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> THP migration is added but only supports x86_64 at the moment. For all
> other architectures, swp_entry_to_pmd() only returns a zero pmd_t.
> 
> Due to a GCC zero initializer bug #53119, the standard (pmd_t){0}
> initializer is not accepted by all GCC versions. __pmd() is a feasible
> workaround. In addition, sparc32's pmd_t is an array instead of a single
> value, so we need (pmd_t){ {0}, } instead of (pmd_t){0}. Thus,
> a different __pmd() definition is needed in sparc32.
> 
> Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>

Applied.
