From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 06 Nov 2015 00:56:19 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFz54eqrSy0TM3JNLXzyHO-DjsTHBLTWY1HTeZSyMLf73A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151105.163959.1438115257720770769.davem@davemloft.net>
	<CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com>
In-Reply-To: <CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Nov 5, 2015 at 4:43 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Not that this *matters*, but it's a bit odd to have to cast constants
> to perfectly regular C types.

Looking around with "git grep", there's a few more of these.

 - btrfs seems to like "(unsigned long)-1"

   There's a few other users of that too, including more sparc uses.

 - scsi/qla seems to like "(unsigned long)<hexnumber>"

 - fmdrv_common.h seems to like "((unsigned long)1<<x)" for bitmaps

along with a smattering of random noise all over of "(unsigned long)
n" where 'n' is some integer.

Apparently people aren't as aware of the normal "ul" postfix syntax as
I would have expected. That said, it's a hundred-odd cases in all of
the kernel, so it's still fairly rare.

                 Linus
