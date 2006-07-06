From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 06 Jul 2006 01:46:02 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <200607060146.k661k27j010379@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 5 Jul 2006 23:07:31 +0200, <ludo@chbouib.org> wrote:
>2 days, 9 hours, 28 minutes, 40 seconds ago, Mikael Pettersson wrote:
>> In 2.6.17 sparc64 kernels, X11 runs _extremely_ slowly with
>> frequent lock-up like behaviour on my Ultra5 (ATI Mach64).
>> 
>> I finally managed to trace the cause to this change in 2.6.16-git6:
>
>Can you be more specific as to which version of Xorg you are using?
>
>Several people including me have reported being unable to run Xorg 7.0
>on ATI-based sparc64 machines such as U5s [0].  Symptoms include kernel
>hangs as well as transient [1,2] or permanent [3] filesystem corruptions.
>
>I just recompiled a kernel with your patch and it doesn't make any
>difference in that respect (besides, re-adding the
>`prot = __pgprot(...)' line looks questionable since the input value of
>PROT becomes unused as a result).
>
>Xorg 6.9, OTOH, was apparently working fine for most people.

Sorry, I can't help you with your Xorg 7.0 problems.
The user-space on my Ultra5 is Aurora Linux 2.0, which
has xorg-6.8.1-13sparc.

Concerning the kernel change, reverting the patch simply
makes the kernel do that it did prior to 2.6.16-git6,
including ignoring the prot parameter. So it should be safe,
although perhaps not optimal.
