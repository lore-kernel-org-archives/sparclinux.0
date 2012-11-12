From: Michel Lespinasse <walken@google.com>
Date: Mon, 12 Nov 2012 11:55:16 +0000
Subject: Re: [PATCH 03/16] mm: check rb_subtree_gap correctness
Message-Id: <CANN689E4jXT-VA3j54h_MBgCCc9YK0o_E7PY326NnvdiHmAgFQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-4-git-send-email-walken@google.com>
 <509D0F86.30607@gmail.com>
In-Reply-To: <509D0F86.30607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 9, 2012 at 6:13 AM, Sasha Levin <levinsasha928@gmail.com> wrote:
> While fuzzing with trinity inside a KVM tools (lkvm) guest, using today's -next
> kernel, I'm getting these:
>
> [  117.007714] free gap 7fba0dd1c000, correct 7fba0dcfb000
> [  117.019773] map_count 750 rb -1
> [  117.028362] ------------[ cut here ]------------
> [  117.029813] kernel BUG at mm/mmap.c:439!
>
> Note that they are very easy to reproduce.

Thanks for the report. I had trouble reproducing this on Friday, but
after Hugh came up with an easy test case I think I have it figured
out. I sent out a proposed fix as "[PATCH 0/3] fix missing
rb_subtree_gap updates on vma insert/erase". Let's follow up the
discussion there if necessary.

Cheers,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
