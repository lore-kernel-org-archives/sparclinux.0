From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 06 Jan 2011 07:47:43 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110106074743.GA14681@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> The patch did not fix my hang during boot.
> I have added a few prinks and I can see that the boot
> hangs here:
>                 printk(KERN_INFO "console [%s%d] enabled, bootconsole disabled\n",
>                         newcon->name, newcon->index);
>                 for_each_console(bcon) {
>                         if (bcon->flags & CON_BOOT)
>                                 unregister_console(bcon);  <<<<<<<
>                 }
> 
> We succeed to unregister "tty" but when we unregister "earlyprom" I see a hang.
> 
> So what I see is a different bug.
> 
> I did not try to persuade it further as it is getting late here.

I tried to drop "CON_BOOT" from earlyprom and then the box
continued booting until it failed to mount my root filesystem.

I could see that atyfb_init() was called but
atyfb_setup_sparc() was never called - so I did not test your patch.

	Sam
