From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 20 Aug 2007 23:42:39 +0000
Subject: Re: [patch 21/23] Add cmpxchg_local to sparc64
Message-Id: <646765f40708201642qf7d035bn2bcdadf3631fdf44@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820201519.512791382@polymtl.ca>
	 <20070820201831.178200926@polymtl.ca>
	 <646765f40708201634u5437f307l8259456c92af5cf5@mail.gmail.com>
	 <Pine.LNX.4.64.0708201636260.32662@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0708201636260.32662@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Lameter <clameter@sgi.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, wli@holomorphy.com

On 8/21/07, Christoph Lameter <clameter@sgi.com> wrote:
> On Tue, 21 Aug 2007, Julian Calaby wrote:
>
> > >    })
> > >
> > > +#include <asm-generic/cmpxchg-local.h>
> >
> > Shouldn't #includes go at the start of the file?
>
> Most of the timee but there are exceptions.

As with most things =)

However, in the context of this patch, is having the #include here
correct or not?

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
