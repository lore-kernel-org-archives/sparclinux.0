From: David Ahern <david.ahern@oracle.com>
Date: Fri, 20 Mar 2015 19:04:51 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <550C6F53.5090707@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <550C37C9.2060200@oracle.com>	<CA+55aFxhNphSMrNvwqj0AQRzuqRdPG11J6DaazKWMb2U+H7wKg@mail.gmail.com>	<550C5078.8040402@oracle.com>	<CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>	<550C6151.8070803@oracle.com> <CA+55aFyE-zA3be7=FWZE_m2hVHwZueGvciSrghhQB3gT-UHrPA@mail.gmail.com>
In-Reply-To: <CA+55aFyE-zA3be7=FWZE_m2hVHwZueGvciSrghhQB3gT-UHrPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, "David S. Miller" <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On 3/20/15 12:53 PM, Linus Torvalds wrote:
> SLUB should definitely be considered a stable allocator.  It's the
> default allocator for at least Fedora, and that presumably means all
> of Redhat.
>
> SuSE seems to use SLAB still, though, so it must be getting lots of
> testing on x86 too.
>
> Did you test with SLUB? Does it work there?

sorry, forgot to add that detail in the last response: it works fine. No 
panics at all with SLUB.

David
