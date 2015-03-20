From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 18:05:05 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <550C6151.8070803@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <550C37C9.2060200@oracle.com>	<CA+55aFxhNphSMrNvwqj0AQRzuqRdPG11J6DaazKWMb2U+H7wKg@mail.gmail.com>	<550C5078.8040402@oracle.com> <CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
In-Reply-To: <CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On 3/20/15 10:58 AM, Linus Torvalds wrote:
> That said, SLAB is probably also almost unheard of in high-CPU
> configurations, since slub has all the magical unlocked lists etc for
> scalability. So maybe it's a generic SLAB bug, and nobody with lots of
> CPU's is testing SLAB.
>

Evidently, it is a well known problem internally that goes back to at 
least 2.6.39.

To this point I have not paid attention to the allocators. At what point 
is SLUB considered stable for large systems? Is 2.6.39 stable?

As for SLAB it is not clear if this is a sparc only problem. Perhaps the 
config should have a warning? It looks like SLAB is still the default 
for most arch.

DaveM: do you mind if I submit a patch to change the default for sparc 
to SLUB?

Now that the monster is unleashed, off to other problems...

Thanks,
David
