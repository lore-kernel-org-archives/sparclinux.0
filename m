From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 20 Mar 2015 20:01:16 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <550C7C8C.2020309@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <550C37C9.2060200@oracle.com>	<CA+55aFxhNphSMrNvwqj0AQRzuqRdPG11J6DaazKWMb2U+H7wKg@mail.gmail.com>	<550C5078.8040402@oracle.com> <CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
In-Reply-To: <CA+55aFyQWa0PjT-3y-HB9P-UAzThrZme5gj1P6P6hMTTF9cMtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, David Ahern <david.ahern@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On 03/20/2015 09:58 AM, Linus Torvalds wrote:
> 128 cpu's is still "unusual", of course, but by no means unheard of,
> and I'f have expected others to report it too if it was wasy to
> trigger on x86-64.

FWIW, I configured a kernel with SLAB and kicked off a bunch of compiles
on a 160-thread x86_64 system.  It definitely doesn't die _quickly_.
It's been running for an hour or two.
