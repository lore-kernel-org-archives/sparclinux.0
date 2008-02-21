From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Feb 2008 07:56:51 +0000
Subject: Re: sparc64 section mismatch warnings
Message-Id: <20080221075651.GA25975@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080220215020.GA22031@uranus.ravnborg.org>
In-Reply-To: <20080220215020.GA22031@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Feb 20, 2008 at 10:28:39PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 20 Feb 2008 22:50:20 +0100
> 
> > Full diff of the included changes below.
> > 
> > If you can use this in part or in toal they have my:
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Looks good, applied.  Yes, this stuff is all only user past
> __init time if we have cpuhotplug enabled.
> 
> > WARNING: vmlinux.o(.text+0x47094): Section mismatch in reference from the function dr_cpu_data() to the function .devinit.text:mdesc_fill_in_cpu_data()
> > The function dr_cpu_data() references
> > the function __devinit mdesc_fill_in_cpu_data().
> > This is often because dr_cpu_data lacks a __devinit
> > annotation or the annotation of mdesc_fill_in_cpu_data is wrong.
> > 
> > I could not see how to fix this in a clean way.
> > dr_cpu_data() references mdesc_fill_in_cpu_data() via dr_cpu_configure()
> > and that looks bogus.
> 
> This is how CPUs are hotplugged on LDOM systems.  We receive
> a message from the control node which is processed by this
> dr_cpu_configure() stuff.
> 
> The thing to do is likely mark mdesc_fill_in_cpu_data() and it's
> helper functions __cpuinit instead of __devinit.  But yes then
> there is the issue of how to annotate dr_cpu_data() and
> dr_cpu_configure().  Hmmm...
> 
> These two dr_*() functions are essentially "roots" of the
> __cpuinit scope call sites here.  We have to find some way
> for the mismatch checker to learn that this is OK because
> we only build this code if cpu hotplug is enabled.
> 
> Any ideas?
I will take a look at it tonight and come back.
Your explanations helps me to understand it.

It will most likely involve annotating some
functions with __ref to tell modpost to ignore the references.

	Sam
