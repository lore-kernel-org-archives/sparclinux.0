From: daniel@gaisler.com
Date: Sat, 12 Mar 2011 18:03:57 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <20110312130357.4cktvwfmnks08cs8@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

 
  On Fri, 11 Mar 2011 23:40:32  0100, Sam Ravnborg  wrote:
Hi Marcel. 
  >
  > On Fri, Mar 11, 2011 at 10:26:36PM  0100, Marcel van Nies wrote:
  > > Hi,
  > >
  > > > Regarding the segfault - the easiest way forward would be to split the
  > > > patch up in smaller chunks so we know which part causes the 
segfault to happen. 
  > > >
  > > > I assume you had to hand-apply the revert. If you could post 
the exact patch
  > > > you used for revert I will try to split it up in smaller logical parts. 
  > >
  > > I attached the patch which I used to revert commit
  > > 4d14a459857bd151ecbd14bcd37b4628da00792b
  > >
  > > I did a split of this patch, and build kernels with only the memcpy or
  > > only the memset part reverted. 
  >
  > Thanks for all your effort!
  > I will during the weekend try to think how we can nail this,
  > but I'm a bit lost here as we are looking into areas I know little about. 
  >
   
  Hi,
   
  I have begun too look at the patches, one thing that strikes me is 
why handle_level_irq is used and why the ack functions irq_ack and 
irq_mask_ack are not defined. On the LEON architecture IRQs are 
normally edge triggered, the exception beeing PCI interrupts that is 
level triggered. Implementing the ack functions in the current 
implementation would result in acking edge triggered IRQs which means 
IRQs may be lost (on the LEON at least)? I thought SUN SPARCs also have 
edge triggered interrupts and that the CPU acks the IRQ automatically 
when the trap is taken?
   
  What is the difference between having handle_level_irq without ACKs 
implemented and having handle_edge_irq doing the interrupt flow 
handling?
   
  Daniel

