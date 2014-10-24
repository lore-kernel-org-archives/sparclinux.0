From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Oct 2014 19:47:48 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFyqtuh53PmwO65NtM_PrPd51=EMWiv8dU8bNTrXL59=Jg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141024.133249.71272218161411159.davem@davemloft.net>
In-Reply-To: <20141024.133249.71272218161411159.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Oct 24, 2014 at 10:32 AM, David Miller <davem@davemloft.net> wrote:
>
>    It's really idiotic to have a weak symbolled fallback that just
>    returns zero, and causes this kind of bug.  There should be no
>    backup implementation and the link should fail if the architecture
>    fails to provide __get_user_pages_fast() and supports transparent
>    hugepages.

Agreed. I think the weak fallback is for the "no hugepages support"
case, but that does sound very annoying and fragile.

                   Linus
