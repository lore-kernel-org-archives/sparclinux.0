From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2012 19:46:34 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFwYWRv6+ix+UjT52UAn1rQeDpUKmbWq5SdHjZ0qHR2Cbg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120413.152455.900761231064979707.davem@davemloft.net>
In-Reply-To: <20120413.152455.900761231064979707.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 13, 2012 at 12:24 PM, David Miller <davem@davemloft.net> wrote:
>
> With special guest sparc64 assembler hacker, Paul E. McKenney.

Oh christ.  You're teaching *more* people about sparc64?

Where will it end?

That said, Looking at the patch, it looks a bit dubious. Why does the

 		cmp			%l1, 0

instruction remain, even if the conditional branch was deleted? I'm
not seeing any subsequent uses of %icc, but hey, I'm no sparc expert
(nor do I want to be).

                      Linus
