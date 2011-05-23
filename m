From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 23 May 2011 16:10:58 +0000
Subject: Re: [PATCH 1/2 v2] sparc32,leon: added LEON-common low-level PCI
Message-Id: <4DDA8712.6000309@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1305964529-8577-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1305964529-8577-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Julian Calaby wrote:

>On Sat, May 21, 2011 at 21:33, Sam Ravnborg <sam@ravnborg.org> wrote:
>  
>
>>On Sat, May 21, 2011 at 09:55:28AM +0200, Daniel Hellstrom wrote:
>>    
>>
>>>The LEON architecture does not have a BIOS or bootloader that
>>>initializes PCI for us, instead Linux generic PCI layer is used
>>>to set up resources and IRQ.
>>>
>>>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>>      
>>>
>>Hi Daniel.
>>
>>Reading through this patch it looks like LEOON pci support is bolted on top
>>of what we have rather than trying to integrate it a bit more.
>>
>>I would like to see something like:
>>
>>* include/asm/pcic.h intregated in pci_32.h
>>    
>>
Do we really want that? I mean drivers that include pci.h does not need 
to know about pcic.h internals. I think is is quite clear the way it is, 
pcic.h is one PCI Host controller implementation, the host 
implementation shouldn't go to the header right? This is similar to 
LEON_PCI, is a common file for LEON PCI host controllers on the LEON 
platform. PCIC is common to machines which have PCI on the SUN platform.

>>* leon specifics added to pci_32.h - with minimal ifdefs
>>    
>>
Ok, could do that. Then I propose that I remove pci_leon.h, add some of 
that stuff into pci_32.h (will still be as many ifdefs as before) and I 
will create a leon_pci.h similar to pcic.h or add LEON-PCI specific 
stuff that nowone really wants to know about 
(leon_pci_info,leon_pci_init), or I add it to leon.h instead.

>>Dunno abot the rest...
>>
>>If i find time I will try to come up with a proposal later tonight.
>>
>>       Sam
>>    
>>
>
>When I looked at this earlier, I was thinking that we might want to
>introduce a new KConfig variable, maybe CONFIG_LEON_PCI, to hide all
>this stuff behind so we don't have to do any complicated ifdefery or
>change any existing ifdefs.
>  
>
Ok, I will try to add a PCIC and a LEON_PCI config option. Then most 
ifdefs still will be there but only dependent on one thing: PCIC, 
LEON_PCI or PCI.

Does all this sound reasonable?

Daniel
