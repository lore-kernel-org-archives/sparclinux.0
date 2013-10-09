From: David Miller <davem@davemloft.net>
Date: Wed, 09 Oct 2013 20:03:09 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131009.160309.793422921861188128.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Fri, 4 Oct 2013 11:45:55 -0400

> The issue appears to be corruption.

I think I know what the problem is.

In set_pmd_at() we need to flush two 4MB pages.

I'll play around with your test case and a potential fix, thanks.
