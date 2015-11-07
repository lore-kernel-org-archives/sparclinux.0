From: Julia Lawall <julia.lawall@lip6.fr>
Date: Sat, 07 Nov 2015 06:04:48 +0000
Subject: Re: [GIT] Sparc
Message-Id: <alpine.DEB.2.02.1511070704130.2083@localhost6.localdomain6>
List-Id: <sparclinux.vger.kernel.org>
References: <20151105.163959.1438115257720770769.davem@davemloft.net> <CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com> <CA+55aFz54eqrSy0TM3JNLXzyHO-DjsTHBLTWY1HTeZSyMLf73A@mail.gmail.com> <CAGRGNgUFUTBA1HfaPpE7kkC3zSZ02S7dsLqVBTrDYbQ69FD80Q@mail.gmail.com>
 <alpine.DEB.2.02.1511060743560.2054@localhost6.localdomain6> <CAGRGNgXodWW1Fj2BzKFA2rdA40WD1AUYdZfJJc7AJ41LjMOj+w@mail.gmail.com>
In-Reply-To: <CAGRGNgXodWW1Fj2BzKFA2rdA40WD1AUYdZfJJc7AJ41LjMOj+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, sparclinux <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org



On Sat, 7 Nov 2015, Julian Calaby wrote:

> Hi Julia,
> 
> On Fri, Nov 6, 2015 at 5:44 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> > On Fri, 6 Nov 2015, Julian Calaby wrote:
> >
> >> Hi Linus,
> >>
> >> On Fri, Nov 6, 2015 at 11:56 AM, Linus Torvalds
> >> <torvalds@linux-foundation.org> wrote:
> >> > On Thu, Nov 5, 2015 at 4:43 PM, Linus Torvalds
> >> > <torvalds@linux-foundation.org> wrote:
> >> >>
> >> >> Not that this *matters*, but it's a bit odd to have to cast constants
> >> >> to perfectly regular C types.
> >> >
> >> > Looking around with "git grep", there's a few more of these.
> >> >
> >> >  - btrfs seems to like "(unsigned long)-1"
> >> >
> >> >    There's a few other users of that too, including more sparc uses.
> >> >
> >> >  - scsi/qla seems to like "(unsigned long)<hexnumber>"
> >> >
> >> >  - fmdrv_common.h seems to like "((unsigned long)1<<x)" for bitmaps
> >> >
> >> > along with a smattering of random noise all over of "(unsigned long)
> >> > n" where 'n' is some integer.
> >> >
> >> > Apparently people aren't as aware of the normal "ul" postfix syntax as
> >> > I would have expected. That said, it's a hundred-odd cases in all of
> >> > the kernel, so it's still fairly rare.
> >>
> >> Maybe this is something the kernel-janitors team should look at? (CC'd)
> >
> > Do you have some concrete examples of the code that is undesirable?
> 
> Joe Perches produced a patch for checkpatch to check for this [1]
> 
> Linus was complaining [2] about people producing constants with casts
> to basic C types in them. For instance:
> 
> #define IOMMU_ERROR_CODE (~(unsigned long) 0)
> 
> This could be replaced with
> 
> #define IOMMU_ERROR_CODE (~0ul)
> 
> or potentially
> 
> #define IOMMU_ERROR_CODE (-1ul)
> 
> It's not overly common, but it looks wrong.

Thanks.  The checkpatch solution indeed looks fine in this case.

julia

> Thanks,
> 
> Julian Calaby
> 
> [1] https://lkml.org/lkml/2015/11/6/48
> [2] https://lkml.org/lkml/2015/11/5/785
> 
> -- 
> Julian Calaby
> 
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
