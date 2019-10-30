From: Kees Cook <keescook@chromium.org>
Date: Wed, 30 Oct 2019 19:49:48 +0000
Subject: Re: [PATCH] tty: n_hdlc: fix build on SPARC
Message-Id: <201910301249.9070A9889E@keescook>
List-Id: <sparclinux.vger.kernel.org>
References: <675e7bd9-955b-3ff3-1101-a973b58b5b75@infradead.org>
 <201910301131.2739AA83@keescook>
 <9ef8c2a5-8510-c509-4c31-b8684b6e1c67@physik.fu-berlin.de>
In-Reply-To: <9ef8c2a5-8510-c509-4c31-b8684b6e1c67@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Miller <davem@davemloft.net>, kbuild test robot <lkp@intel.com>

On Wed, Oct 30, 2019 at 08:29:40PM +0100, John Paul Adrian Glaubitz wrote:
> On 10/30/19 7:34 PM, Kees Cook wrote:
> > On Mon, Sep 30, 2019 at 07:15:12PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix tty driver build on SPARC by not using __exitdata.
> >> It appears that SPARC does not support section .exit.data.
> >>
> >> Fixes these build errors:
> >>
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >> `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
> >>
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> Fixes: 063246641d4a ("format-security: move static strings to const")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Wow. That commit is from 2.5 years ago. Is the SPARC port still alive?
> Yes, it is. No idea why we didn't run into this. I assume it affects certain
> configurations only. On Debian, we are always compiling and running the
> latest kernel versions on sparc64.

Yeah, that's what I thought. I also didn't hit it 2.5 years ago when I
did multi-architecture build validation of these changes. :P

Randy you've found a nice corner case! :)

-- 
Kees Cook
