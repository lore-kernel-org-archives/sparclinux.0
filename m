From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2020 01:26:17 +0000
Subject: Re: [PATCH v2 0/2] sparc32: srmmu: improve type safety of __nocache_fix()
Message-Id: <20200721.182617.1769882891819370159.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200627081653.25311-1-rppt@kernel.org>
In-Reply-To: <20200627081653.25311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rppt@kernel.org
Cc: sparclinux@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com

From: Mike Rapoport <rppt@kernel.org>
Date: Sat, 27 Jun 2020 11:16:51 +0300

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> As discussed at [1] the __nocache_fix() macro in sparc's SRMMU can be made
> type safe and so the compiler will yell anout misuse of pXd pointers for
> which the __nocache_fix() is primarily used.
> 
> The first patch is an fix of such misuse that I've discovered after adding
> type cast to __nocache_fix(), but to avoid breaking bisection I've made it
> the first commit.
> 
> v2: rebased on v5.8-rc2+

Series applied, thanks Mike.
