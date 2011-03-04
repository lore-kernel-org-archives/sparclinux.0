From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 04 Mar 2011 23:43:12 +0000
Subject: Re: Status update on sparc32 genirq support [Was: sparc32: genirq
Message-Id: <Pine.LNX.4.64.1103050025150.24023@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110304214850.GA12197@merkur.ravnborg.org>
In-Reply-To: <20110304214850.GA12197@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 4 Mar 2011, Sam Ravnborg wrote:

> On Fri, Feb 25, 2011 at 11:06:13PM -0800, David Miller wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Tue, 22 Feb 2011 19:22:19 +0100
> > 
> > > I will prepare a v4 soon.
> > 
> > The first 4 patches are in the tree, so you only need to resubmit
> > this patch rather than the whole bunch.
> > 
> > I really look forward to applying v4, thanks Sam!
> 
> Short update...
> 
> I will not post v4 until I can do a bit more testing.
> 
> Next week I get a SS1000E box (thanks to Chris <crn@netunix.com>) which
> allows me to test the sun4d changes.
> 
> Huge thanks to Chris which has put a lot of effort in getting the
> box operational again and for all the effort concerning the shipping!
> I owe him more than one beer for this...
> 
> Kjetil mentioned he would try the genirq patches on his SS1000.
> And I hope to get feedback from Gaisler too.
> 
> The patchset will likely not see testing on:
> - Javastation (the pcic changes)
> - sun4m with multiple CPUs
> - sun4c
> 
> I have checked the nearby ebay's for relevant boxes - no luck.
> On the other hand there is also a limit for the size of
> my SUN museum :-)
> 
> 	Sam

Hi,

With regards to testing on sun4d, I have run into problems with the 
existing kernel, during the process of getting a test system up and 
running. The system is unable to mount partitions correctly, 
(both ext2 on a hdd, and iso8859 on a cdrom), however dd, running from an 
initrd filesystem is able to read the ext2 blocks correctly. So I have 
started investigating this instead. 

Is there anyone aware of any alignment requirements in the sun4d on DMA 
transfers and such ? Or have the datasheet for the FAS2x6 (236) scsi 
controllers ? 

Sorry for highjacking the thread a bit.

Regards,
Kjetil Oftedal


