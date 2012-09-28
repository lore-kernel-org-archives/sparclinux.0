From: David Miller <davem@davemloft.net>
Date: Fri, 28 Sep 2012 17:40:21 +0000
Subject: Re: [PATCH 2/2] do_rt_sigreturn provide the target sp
Message-Id: <20120928.134021.566576861434453628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1348760205-26101-3-git-send-email-bpicco@meloft.net>
In-Reply-To: <1348760205-26101-3-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Fri, 28 Sep 2012 05:56:30 -0400

> Sorry about the deficient change log. Won't happen again! It was a
> couple months ago when I had full context and was perhaps wrong. It was a
> combination of glibc and kernel investigation/debug and very subtle. I'll
> review and have a thorough explanation in the change log soon.

I thought you actually knew offhand. :-/

It's because of the STACK_BIAS, that's what's unique in this case.
