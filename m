From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 Apr 2014 18:46:11 +0000
Subject: Re: Time to let sun4m + sun4d RIP?
Message-Id: <20140429184611.GA31545@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20140419114802.GA13716@ravnborg.org>
In-Reply-To: <20140419114802.GA13716@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Apr 19, 2014 at 01:48:02PM +0200, Sam Ravnborg wrote:
> Hi all sparc lovers/users.
> 
> We all know that is is a long time ago that a sun4m or sun4d machine was produced,
> and I wonder if there are anyone using these today.
> The questions pops up as there are still stuff to do before the sparc32 port
> is in good shape.
> 
> So the question to you guys...
> Shall we keep support for sun4d and sun4m?
> If yes then why?
> 
> LEON is in active use in several applications - so the sparc32 port is
> as relevant as ever.

Just a fololow-up to my original question.

We still have a few brave souls running the kernels on sparc32 based boxes.
On top of this there are templig.org that looks like a one-man show to implment
sparc32 in VHDL. But very impressive!
Then there are qemu that today supports sun4m - if we drop sun4m we also drop
qemu support for sparc.

So in total there are still reasons to keep sun4m and sun4d around.

Thanks everyone for your responses!

	Sam
