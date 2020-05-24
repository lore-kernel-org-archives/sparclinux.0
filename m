From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 May 2020 17:28:22 +0000
Subject: Re: [PATCH 2/2] sparc32: srmmu: improve type safety of __nocache_fix()
Message-Id: <CAHk-=wiHEt=c2A+xhjKbW_N7DrxH=EV70B1diY8nYHGio0Bf2w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200524162151.3493-1-rppt@kernel.org> <20200524162151.3493-3-rppt@kernel.org>
In-Reply-To: <20200524162151.3493-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>

On Sun, May 24, 2020 at 9:22 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The addition of the casting to __nocache_fix() also allows to remove
> explicit casts at its call sites.

Ahh, bonus cleanup.

Looks obviously fine to me, but it's not like I build- or boot-test
sparc32, so this had probably better go through somebody who does.

               Linus
