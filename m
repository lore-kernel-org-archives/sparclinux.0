From: "C.Newport" <crn@netunix.com>
Date: Sun, 15 Aug 2004 10:39:37 +0000
Subject: Re: Sun4d SMP wierdness
Message-Id: <200408151139.37374.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408150157.12181.crn@netunix.com>
In-Reply-To: <200408150157.12181.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 15 August 2004 9:26 am, William Lee Irwin III wrote:
> On Sun, Aug 15, 2004 at 01:57:12AM +0100, C.Newport wrote:
> >> I am trying to track down why 2.4.27 (or any 2.4 series) does a watchdog
> >> timeout very early in the boot sequence om Sun4d SMP.
>
> On Sun, Aug 15, 2004 at 10:09:39AM +0200, Thomas Bogendoerfer wrote:
> > SuperSparc I or II Cpu ?
> > IMHO SuperSparc II never worked for Sun4d. I've posted a patch against
> > 2.4.something last year, which fixed that problem and I'm waiting
> > for spare time to bring it forward to 2.6 ...
>
> Could you send whatever you have now? If it's not merged for 2.4 I'll
> send it to marcelo.

Found it in the archives - 
http://marc.theaimsgroup.com/?l=linux-sparc&m6467967231116&w=2

The patches are against 2.4.22 so I will test them here in 2.4.27 to see
what happens, and possibly merge with Pasi's patches.



