From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 27 Oct 2014 21:09:38 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20141027140938.142f83a4c3bc6512dd73b54c@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20141024.133249.71272218161411159.davem@davemloft.net>
	<CA+55aFyqtuh53PmwO65NtM_PrPd51=EMWiv8dU8bNTrXL59=Jg@mail.gmail.com>
In-Reply-To: <CA+55aFyqtuh53PmwO65NtM_PrPd51=EMWiv8dU8bNTrXL59=Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Capper <steve.capper@linaro.org>

On Fri, 24 Oct 2014 12:47:48 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Oct 24, 2014 at 10:32 AM, David Miller <davem@davemloft.net> wrote:
> >
> >    It's really idiotic to have a weak symbolled fallback that just
> >    returns zero, and causes this kind of bug.  There should be no
> >    backup implementation and the link should fail if the architecture
> >    fails to provide __get_user_pages_fast() and supports transparent
> >    hugepages.
> 
> Agreed. I think the weak fallback is for the "no hugepages support"
> case, but that does sound very annoying and fragile.
> 

Yup.  I'm thinking the get_user_pages_fast() and
__get_user_pages_fast() in mm/util.c should be made non-weak and moved
to mm/nommu.c.

With that change, MMU architctures will need to either define
CONFIG_HAVE_GENERIC_RCU_GUP or implement their own versions.

Perhaps sparc should be defining CONFIG_HAVE_GENERIC_RCU_GUP.

We really should switch x86 to the generic version - from a quick read
it looks like it will work without needing any changes.

Steve, thoughts?
