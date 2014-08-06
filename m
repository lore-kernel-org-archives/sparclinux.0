From: Andev <debiandev@gmail.com>
Date: Wed, 06 Aug 2014 21:25:02 +0000
Subject: Re: [3.13.y.z extended stable] Patch "locking/mutex: Disable optimistic spinning on some architectur
Message-Id: <CAJUuVQ5OpNye8HAEw6x=owBB32pq-aLF7_Gqo493jDDHDahhRA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1407358496-23094-1-git-send-email-kamal@canonical.com>
In-Reply-To: <1407358496-23094-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 6, 2014 at 4:54 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> This is a note to let you know that I have just added a patch titled
>
>     locking/mutex: Disable optimistic spinning on some architectures
>
> to the linux-3.13.y-queue branch of the 3.13.y.z extended stable tree
> which can be found at:
>
>  http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.13.y-queue
>
> This patch is scheduled to be released in version 3.13.11.6.
>

This patch is specifically for parisc, sparc32, tile32, metag-lock1,
arc-!llsc and hexagon none of which Ubuntu supports.

Why are you backporting this patch?

--
Andev
