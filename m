From: "Richard Mortimer" <richm@oldelvet.org.uk>
Date: Tue, 23 Jan 2007 14:18:07 +0000
Subject: RE: IRQ routing(?) problem on Enterprise 450 with Areca SATA RAID controller
Message-Id: <004001c73ef9$548bb7d0$c505a8c0@Jive>
List-Id: <sparclinux.vger.kernel.org>
References: <20070102140325.GB11095@wopr.homeunix.org>
In-Reply-To: <20070102140325.GB11095@wopr.homeunix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi, 

> -----Original Message-----
> From: sparclinux-owner@vger.kernel.org 
> [mailto:sparclinux-owner@vger.kernel.org] On Behalf Of David Johnson
> Sent: 23 January 2007 13:54
> To: sparclinux@vger.kernel.org
> Subject: Re: IRQ routing(?) problem on Enterprise 450 with 
> Areca SATA RAID controller
> 
> On Thursday 18 January 2007 20:40, you wrote:
> I suspect the breakage is in 2.6.18-rc1, but there seems to 
> be a critical bug 
> in this kernel which prevents it from even booting on E450 
> (it gets as far 
> as 'Booting the kernel' and just sits there, giving no errors 
> or other 
> output) so I can't test this. As a result, I am unable to 
> bisect the tree to 
> find the patch that introduced the bug...
> 
Is there any chance that you could boot with the -p flag. That
directs early kernel startup output via Openboot and will likely
give an indication as to what the problem is.

Note I did find some issues with 2.6.18 relating to the changes to
reading information from OBP. You may be seeing something similar.

Richard

