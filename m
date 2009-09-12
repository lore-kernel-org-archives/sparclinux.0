From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 12 Sep 2009 09:49:54 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090912094953.GA30077@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 11, 2009 at 05:18:18PM -0700, David Miller wrote:
> > Could this consistency be of any significance, maybe the printk
> > functions are somehow problematic... so I fiddled with them some more, but
> > it looks more like they just waste time until something kicks in and somehow
> > kills the kernel without a trace. That doesn't sound like perfctr_irq() and
> > die_nmi(), but then I don't really any idea how exactly all that works :)
> 
> You can't put debugging print statements in the NMI irq handlers like
> perfctr_irq(), that will almost always cause a lockup or crash.

Nah, didn't even try that - I saw that the existing printk() in there
doesn't even show up, despite obvious tries to make it so.

In case it matters, this is a tlb_type=cheetah_plus machine.

I see this %pcr handling has been in debugging code (oprofile, performance
counters) for some time before it moved into the NMI handler, so I'm
guessing it didn't get enough testing because fewer people have the
debugging features enabled. I would recommend disabling it for now in
the stable releases until this grave regression is resolved.

-- 
     2. That which causes joy or happiness.
