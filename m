From: "Konrad Eisele" <eiselekd@web.de>
Date: Wed, 13 Apr 2005 09:26:33 +0000
Subject: Re: SMP on virtually indexed/tagged cache
Message-Id: <737597609@web.de>
List-Id: <sparclinux.vger.kernel.org>
References: <737167738@web.de>
In-Reply-To: <737167738@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@davemloft.net> schrieb am 12.04.05 21:28:47:
> 
> On Tue, 12 Apr 2005 14:50:54 +0200
> "Konrad Eisele" <eiselekd@web.de> wrote:
> 
> > I trying to get sparc32-smp run on a Leon3 sparc,
> > it uses a  virtually indexed/tagged cache. Is it possible
> > to run smp on such a processor?
> 
> Yes, it's just painful.  Model your cache flushing on the
> sun4c code.
> -

It's difficult to understand how smp works when cache coherency isn't
done by hardware. 
Have all the the kernel structures to be in nocache memory? Or does
the kernel issue a flush to all processors when modifying them. On a 
Leon I can use a special asi to force a dcache miss, so spinlocks I can
make work, but how are all the other data structures synchronized? By
issuing a flush on every unlock? I'm not so familiar with sun4c and what 
kind of architecture that was. Does it run with SMP and which are the
smp sources for sun4c?, I only find ones for 4d and 4m. There are so
many machine variants and for none I can find out what kind of cache it 
runs with.

-- Konrad

> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



