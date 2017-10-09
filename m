From: David Miller <davem@davemloft.net>
Date: Mon, 09 Oct 2017 04:39:57 +0000
Subject: Re: [PATCH v3 3/5] sparc64: SPARC optimised fls function
Message-Id: <20171008.213957.296383983633615999.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1507308893-9218-1-git-send-email-vijay.ac.kumar@oracle.com>
        <1507308893-9218-4-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1507308893-9218-4-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vijay.ac.kumar@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com, sam@ravnborg.org

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Fri,  6 Oct 2017 10:54:51 -0600

> +#define LXCNT_O0_G2	\
> +	.word	0x85b002e8
> +
> +	.text
> +	.register	%g2, #scratch
> +	.register	%g3, #scratch
> +
> +ENTRY(NG4fls)
> +	LXCNT_O0_G2	!lzcnt	%o0, %g2

Agreed with others that you should name this LZCNT_* instead of
LXCNT_*.
