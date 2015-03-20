From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Mar 2015 16:58:25 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <550C37C9.2060200@oracle.com>
	<CA+55aFxhNphSMrNvwqj0AQRzuqRdPG11J6DaazKWMb2U+H7wKg@mail.gmail.com>
	<550C5078.8040402@oracle.com>
In-Reply-To: <550C5078.8040402@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Fri, Mar 20, 2015 at 9:53 AM, David Ahern <david.ahern@oracle.com> wrote:
>
> I haven't tried 3.19 yet. Just backed up to 3.18 and it shows the same
> problem. And I can reproduce the 4.0 crash in a 128 cpu ldom (VM).

Ok, so if 3.18 also has it, then trying 3.19 is pointless, this is
obviously an old problem. Which makes it even more likely that it's
sparc-related.

128 cpu's is still "unusual", of course, but by no means unheard of,
and I'f have expected others to report it too if it was wasy to
trigger on x86-64.

That said, SLAB is probably also almost unheard of in high-CPU
configurations, since slub has all the magical unlocked lists etc for
scalability. So maybe it's a generic SLAB bug, and nobody with lots of
CPU's is testing SLAB.

                      Linus
