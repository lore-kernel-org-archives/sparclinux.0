From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 06 Nov 2015 00:43:52 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151105.163959.1438115257720770769.davem@davemloft.net>
In-Reply-To: <20151105.163959.1438115257720770769.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Nov 5, 2015 at 1:39 PM, David Miller <davem@davemloft.net> wrote:
>
> 5) Fix iommu-common code so it doesn't emit rediculous warnings
>    on some architectures, particularly ARM.

Heh. So looking at that patch, I can't but help to react that this:

  #define IOMMU_ERROR_CODE       (~(unsigned long) 0)

is still pretty ridiculous.  Maybe just (-1ul), or for those people
who don't understand C unsigned long arithmetic and think that a
negative unsigned long looks odd, (~0ul)?

Not that this *matters*, but it's a bit odd to have to cast constants
to perfectly regular C types.

                    Linus
