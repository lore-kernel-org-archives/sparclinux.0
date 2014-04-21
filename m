From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:56:10 +0000
Subject: Re: [PATCH 24/24] sparc32: fix sparse warnings in leon_smp.c
Message-Id: <20140421175610.GA22788@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1398100356-19794-24-git-send-email-sam@ravnborg.org>
In-Reply-To: <1398100356-19794-24-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Apr 21, 2014 at 01:32:06PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 21 Apr 2014 19:12:36 +0200
> 
> > -void leon_cpu_pre_starting(void *arg);
> > -void leon_cpu_pre_online(void *arg);
> > +extern void leon_cpu_pre_starting(void *arg);
> > +extern void leon_cpu_pre_online(void *arg);
> > +extern void leonsmp_ipi_interrupt(void);
> > +extern void leon_cross_call_irq(void);
> 
> For header files, we are moving away from specifying extern for external
> function declarations.
> 
> In the networking, we've made this transformation in all of our headers
> already, for example.
I have missed that.

> 
> So if anything, you should be changing things to other way around.
I prefer to send follow-up patches that fixes this for all of sparc,
but I can also redo the serie if you prefer.
You will still have follow-up patches to fix the existing
extern-for-prototypes users.

	Sam

