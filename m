From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 22 Dec 2010 20:23:56 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <1293049436.12085.3.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2010-12-22 at 11:53 -0800, David Miller wrote:
> > Rather than specialising it for LEON, why not just test for CASA
> > availability and use it if it available?
> 
> Run time detection of this is going to really be terrible.
> 
> Lots of cmpxchg() uses are inline, and we'll have to implement
> it out-of-line and patch the call instructions dynamically.
> 
> LEON is the only chip that can do the instruction and we already
> do a special LEON specific build. 

Inlines do save a lot of time, so I guess you're right there's no point.
But I think changing the way IRQ15/IRQ14 interrupt works could be an
extra bonus. 
-- 
Tactical Nuclear Kittens
