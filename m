From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2015 18:53:35 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <CA+55aFyE-zA3be7=FWZE_m2hVHwZueGvciSrghhQB3gT-UHrPA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <550C37C9.2060200@oracle.com>
	<CA+55aFxhNphSMrNvwqj0AQRzuqRdPG11J6DaazKWMb2U+H7wKg@mail.gmail.com>
	<550C5078.8040402@oracle.com>
	<CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
	<550C6151.8070803@oracle.com>
In-Reply-To: <550C6151.8070803@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>
Cc: linux-mm <linux-mm@kvack.org>, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Fri, Mar 20, 2015 at 11:05 AM, David Ahern <david.ahern@oracle.com> wrote:
>
> Evidently, it is a well known problem internally that goes back to at least
> 2.6.39.
>
> To this point I have not paid attention to the allocators. At what point is
> SLUB considered stable for large systems? Is 2.6.39 stable?

SLUB should definitely be considered a stable allocator.  It's the
default allocator for at least Fedora, and that presumably means all
of Redhat.

SuSE seems to use SLAB still, though, so it must be getting lots of
testing on x86 too.

Did you test with SLUB? Does it work there?

> As for SLAB it is not clear if this is a sparc only problem. Perhaps the
> config should have a warning? It looks like SLAB is still the default for
> most arch.

I definitely think SLAB should work (although I *would* like to get
rid of the duplicate allocators), and I still do think it's likely a
sparc issue. Especially as it apparently goes way back. x86 gets a
*lot* more testing, and I don't really recall anything like this.

I'm not comfy enough reading sparc asm code to really pinpoint exactly
what looks to go wrong, so I have very little input on what the
problem could be.

                         Linus
