From: Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 27 Apr 2017 14:31:18 +0000
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-Id: <20170427103118.56351d30@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
In-Reply-To: <20170427133819.GW3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 27 Apr 2017 15:38:19 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > by the way,
> > does this `nmi_print_seq' bypass even fix anything for Steven?  
> 
> I think that this is the most important question.
> 
> Steven, does the patch from
> https://lkml.kernel.org/r/20170420131154.GL3452@pathway.suse.cz
> help you to see the debug messages, please?

You'll have to wait for a bit. The box that I was debugging takes 45
minutes to reboot. And I don't have much more time to play on it before
I have to give it back. I already found the bug I was looking for and
I'm trying not to crash it again (due to the huge bring up time).

When I get a chance, I'll see if I can insert a trigger to crash the
kernel from NMI on another box and see if this patch helps.

Thanks,

-- Steve
