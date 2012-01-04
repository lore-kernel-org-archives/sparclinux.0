From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Jan 2012 21:59:59 +0000
Subject: Re: [WIP] sparc32: replace bootmem with memblock
Message-Id: <20120104215958.GB7968@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120103204516.GA4271@merkur.ravnborg.org>
In-Reply-To: <20120103204516.GA4271@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 04, 2012 at 04:31:52PM -0500, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 3 Jan 2012 21:45:16 +0100
> 
> > sparc32 uses a combination of a local memory handling and bootmem
> > to handle memory in the early stage of the boot.
> > 
> > Some time ago I started to look at what was required to replace
> > the local memory handling (sp_banks) with memblock - which I understood
> > was the generic way to handle memory in the early phases of
> > the boot.
> > 
> > Tejun have posted a nice series of patches that clean up
> > memblock so it should be possible to replace bootmem too.
> 
> You are extremely brave to be messing around with this area of
> the sparc32 port, I must say :-)  Getting sparc64 sane took a
s/brave/stupid/g
> lot of concentrated effort and it lacks much of the baggage that
> sparc32 still has lying around.

But then sparc32 looks much simpler than sparc64 - especially
after I start to get the bigger picture.

> 
> Thanks for doing this work and I'll continue looking over the
> patch and try to help with the unresolved areas as well.

Thanks!
I plan to post a more readable serie of patches soon after the
merge window has closed.

	Sam
