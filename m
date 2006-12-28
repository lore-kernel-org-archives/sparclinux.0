From: "Chini, Georg" <georg.chini@hp.com>
Date: Thu, 28 Dec 2006 23:21:12 +0000
Subject: Re: IRQ-problem with cs4231 alsa driver on SBUS
Message-Id: <45945168.6080909@hp.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4593BC00.4010902@triaton-webhosting.com>
In-Reply-To: <4593BC00.4010902@triaton-webhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Georg Chini wrote:

> Hello,
>
> I am using an ultra 2 with two 300 MHz CPU's, kernel 2.6.18.5.
> I tried to make a VOIP appliction (twinkle) work on my machine.
> I have to use the OSS emulation layer, if I configure ALSA in
> the application it will not work.
> With OSS it works fine for a while, but after exactly 99999 IRQ's
> from the cs4231 card I get the following kernel message:
>
>
Problem solved,  the IRQ-handler returned 0, not IRQ_HANDLED.
I'll post a patch later on, still fighting with some initialisation 
problems.

Regards
              Georg Chini
