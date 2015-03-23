From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Mar 2015 17:12:30 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFzXDxicQRZNEDaLruxackq-6NkkYk5gM1L6Ak38ggJKrQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150323.125537.767987027704780801.davem@davemloft.net>
	<CA+55aFx0Sw4xWGNdVhcOqH2XN=Q=CNgCLS7Ru3m2Lf_T88nKHA@mail.gmail.com>
In-Reply-To: <CA+55aFx0Sw4xWGNdVhcOqH2XN=Q=CNgCLS7Ru3m2Lf_T88nKHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 23, 2015 at 10:05 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 23, 2015 at 9:55 AM, David Miller <davem@davemloft.net> wrote:
>>
>> Some perf bug fixes from David Ahern, and the fix for that nasty
>> memmove() bug.
>
> That doesn't seem to be marked for stable? Or do you do the same thing
> as for networking, and just collect stable patches manually?

Side note: the memmove commit message is a bit misleading. The old
code handled zero-length calls fine, even if it wasn't explicit: it
always called memmove() for that case.

The condition "dst <= src || src + len <= dst" ends up being always
true when len is zero (because it obviously ends up being "dst <= src
|| src <= dst").

So there was just one bug - the 64-byte overlap with the cacheline
establish for the destination. Even that cacheline establish would
have been ok if all the loads for the 64-byte block had been done
up-front.

Oh well. I'm actually somewhat surprised this didn't hit anything
else. Doesn't networking also end up doing overlapping memmove() on
the skb data occasionally?

                       Linus
