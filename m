From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 21 Oct 2004 01:35:16 +0000
Subject: Re: Help Wanted: Floppy and CG3 Problems using Linux-2.6.8.1.
Message-Id: <Pine.LNX.4.10.10410210232160.865-100000@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.10.10410201927410.10087-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410201927410.10087-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi All,

I only cross compile it. Building gcc on SunOS 4.1 is a pain and with only
16MB of ram it would take forever.

Cross compiling on a pentium 233 (32Mb Ram) takes about 2 to 3 hours from 
scratch.

Regards
	Mark Fortescue. 

On Thu, 21 Oct 2004, C.Newport wrote:

> On Thursday 21 October 2004 1:47 am, William Lee Irwin III wrote:
> > On Wed, Oct 20, 2004 at 08:05:10PM +0100, Mark Fortescue wrote:
> > > I am having a lot of trouble getting things up and running on my sparc
> > > clone. I have applied a patch to get the PROM Console working and I would
> > > like some help getting the CGthree console up and running as the code has
> > > changed substantially from the V2.2 kernels and I can't find the areas of
> > > code to change.
> 
> > Okay, this is nasty. I don't have any ideas.
> 
> FWIW I have 2.4.27 working here on an SS1, the fb is cg6 but cg3 should be OK.
> Sun4c is horribly slow, expect 20+ hours to build the kernel.
> 

