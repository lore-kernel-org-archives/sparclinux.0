From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2018 00:11:28 +0000
Subject: Re: Vs: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation combines symbols in differen
Message-Id: <20181024.171128.2126741000316378103.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <AM5PR0201MB23718E35D48CFE84CC40EE90E1F60@AM5PR0201MB2371.eurprd02.prod.outlook.com>
In-Reply-To: <AM5PR0201MB23718E35D48CFE84CC40EE90E1F60@AM5PR0201MB2371.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <meelis.roos@ut.ee>
Date: Wed, 24 Oct 2018 15:47:24 +0000

> 2.25 (Debian 2.25-10 as of  removal from unstable).

I can reproduce.

What is needed is:

#define DIFF_EXPR_OK

in gas/config/tc-sparc.h, and current upstream binutils has it.

I'll have to implement this another way so that it works with all
versions of binutils.

Thanks for the report.
