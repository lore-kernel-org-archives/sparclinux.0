From: Atish Patra <atish.patra@oracle.com>
Date: Mon, 27 Nov 2017 16:39:33 +0000
Subject: Re: [PATCH] sparc64: Set possible and present masks based on nr_cpu_ids
Message-Id: <37cc2825-491a-f86e-f3b8-f5f0f23979b3@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1506630439-192139-1-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 11/19/2017 12:54 AM, David Miller wrote:
> So, this is fixing a regression, right?
Yes.
> If so, you need to provide a proper "Fixes: " tag identifying
> the commit that introduced the bug.
Sure. I will add that in v2.
> I'm also finding it hard to believe that forcing cpu 0 as a possible
> cpu is required.  Have you considered contacting the timer subsystem
> maintainers and asked them to remove this assumption?
I will check with the timer maintainers.

Regards,
Atish
> Thank you.

