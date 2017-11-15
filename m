From: David Miller <davem@davemloft.net>
Date: Wed, 15 Nov 2017 05:27:02 +0000
Subject: Re: [PATCH v4 0/5] sparc64: Optimize fls and __fls
Message-Id: <20171115.142702.1110571070818989446.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1507747806-10251-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507747806-10251-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org, anthony.yznaga@oracle.com

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 11 Oct 2017 12:50:01 -0600

> SPARC provides lzcnt instruction (with VIS3) which can be used to
> optimize fls, __fls and fls64 functions. For the systems that supports
> lzcnt instruction, we now do boot time patching to use sparc
> optimized fls, __fls and fls64 functions.
> 
> v3->v4:
>  -  Fixed a typo.
> v2->v3:
>  -  Using ENTRY(), ENDPROC() for assembler functions.
>  -  Removed BITS_PER_LONG from __fls.
>  -  Using generic fls64().
>  -  Replaced lzcnt instruction with .word directive.
> v1->v2:
>  - Fixed delay slot issue.

Series applied, thank you.
