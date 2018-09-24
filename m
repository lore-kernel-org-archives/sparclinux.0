From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 24 Sep 2018 21:06:25 +0000
Subject: Re: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
Message-Id: <CAK8P3a0_omFwid2NZzs_T=A_TY9ddfGOsVKV2vtiaVodWswbmQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
 <CALxhOngCL4DEcMD7NaxbUiksByzoxaaozzZGPmB0JFziFEWojw@mail.gmail.com>
In-Reply-To: <CALxhOngCL4DEcMD7NaxbUiksByzoxaaozzZGPmB0JFziFEWojw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Firoz Khan <firoz.khan@linaro.org>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On Tue, Sep 18, 2018 at 1:53 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> On 6 September 2018 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> >> +++ b/arch/sparc/include/uapi/asm/unistd.h
> >> @@ -15,12 +15,6 @@
> >>  #ifndef _UAPI_SPARC_UNISTD_H
> >>  #define _UAPI_SPARC_UNISTD_H
> >>
> >> -#ifndef __32bit_syscall_numbers__
> >> -#ifndef __arch64__
> >> -#define __32bit_syscall_numbers__
> >> -#endif
> >> -#endif
> >
> > This is certainly required in the uapi header as of this patch,
> > without it all the numbers are wrong when you include the
> > file from user space.
> >
> > I suppose it can be removed later once the header is replaced
> > with the two generated versions,
>
> The script will generate 2 versions, ie, unistd_32.h and unistd_64.h.
> Please give few more pointer here.

You still need to check at least for __arch64__ in asm/unistd.h in order
to pick which header to include, right? Since the
__32bit_syscall_numbers__ check was already in the public header
file, it may also be possible that there is some user space application
that sets this in order to get the 32-bit definitions. This might e.g.
be needed for strace.

     Arnd
