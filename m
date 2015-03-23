From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 17:05:10 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFx0Sw4xWGNdVhcOqH2XN=Q=CNgCLS7Ru3m2Lf_T88nKHA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150323.125537.767987027704780801.davem@davemloft.net>
In-Reply-To: <20150323.125537.767987027704780801.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 23, 2015 at 9:55 AM, David Miller <davem@davemloft.net> wrote:
>
> Some perf bug fixes from David Ahern, and the fix for that nasty
> memmove() bug.

That doesn't seem to be marked for stable? Or do you do the same thing
as for networking, and just collect stable patches manually?

Pulled,

                   Linus
