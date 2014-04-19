From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sat, 19 Apr 2014 16:55:24 +0000
Subject: Fwd: Time to let sun4m + sun4d RIP?
Message-Id: <CALMQjD96AqwOpiSifwBCG_S_kU_yANh1Ja2W2XAG2d6jW6dgBA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 19 April 2014 16:55, Alan Perry <alanp@snowmoose.com> wrote:
>
>
>
> > So the question to you guys...
> > Shall we keep support for sun4d and sun4m?
> > If yes then why?
>
> I collect Sun lunchbox systems and also have an Axil SS20 clone.  I start up the lunchbox systems once a year to make sure they haven't died and regularly run the Axil. One of the lunchbox systems is running some Linux distro that I don't recall (it could be something old on a sun4c).
>
> Number one problem keeping them running long term is the NVRAM battery (I have added external batteries to the chips in almost all of them). Replacement SCSI HDDs are now a problem to source locally; I couldn't get any from the computer recycler last year. I can still get them on eBay.
>
> alan
>

Hi,

I do not see why support for sun4m and sun4d should actively be
dropped. I have contributed to
the sparc32/sun4d port because I still have such a system that is in
working order.
(Along with several other sparc32/sparc64-variants)

I have struggled with running Linux on architectures that are not
supported by the mainline
Linux kernel any more. And backporting features/bugfixes from never
kernels becomes quite hard
after a while.

Is there currently some technical difficulties that prevents us for
keeping the status quo? Or
is this just a suggestion for the sake of suggestions ?

Regards,
Kjetil Oftedal
(Resend to the mailinglist: html was inserted into the email by the webmail)
