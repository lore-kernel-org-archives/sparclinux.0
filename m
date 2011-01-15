From: Alex Buell <alex.buell@munted.org.uk>
Date: Sat, 15 Jan 2011 12:57:09 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined
Message-Id: <1295096229.15315.2.camel@lithium>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On Sat, 2011-01-15 at 13:07 +0100, Raúl Porcel wrote:
> On 01/10/2011 08:29 PM, David Miller wrote:
> > From: Raúl Porcel <armin76@gentoo.org>
> > Date: Mon, 10 Jan 2011 20:10:36 +0100
> > 
> >> Hi,
> >>
> >> SILO fails to build here with e2fsprogs-1.41.14 installed, i'm attaching
> >> the build log.
> > 
> > I really appreciate how they make libext2 harder and harder to link into
> > embedded self-contained things like bootloaders over time.
> > 
> > I just pushed the following fix for this:
> > <snip>
> 
> 
> Hi,
> 
> Thanks, it builds, but silo fails to work:
> 
> Boot device: disk1  File and args:
> SILO Version 1.4.14_git2010228_p1
> 
> Unknown ext2 error: 4294967295
> 
> Fatal error: Unable to open filesystem
> 
> Couldn't load /etc/silo.conf
> No config file loaded, you can boot just from this command line
> Type [prompath;]part/path_to_image [parameters] on the prompt
> E.g. /iommu/sbus/espdma/esp/sd@3,0;4/vmlinux root=/dev/sda4
> or 2/vmlinux.live (to load vmlinux.live from 2nd partition of boot disk)
> boot:

This problem exists with all versions of silo linked against
e2fsprogs-1.41.14. 

I think there is a bug in e2fsprogs as it doesn't seem to properly
handle error codes returned by the posix_memalign() function. It's
either that or a proper implementation of posix_memalign() function
needs to be detected through the configure scripts.
-- 
Tactical Nuclear Kittens
