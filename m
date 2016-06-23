From: alexmcwhirter@triadic.us
Date: Thu, 23 Jun 2016 20:12:35 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <ccf9c110777aa1dd097cd232eea01245@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2016-06-23 04:30, John Paul Adrian Glaubitz wrote:
> On 06/23/2016 07:54 AM, Alex McWhirter wrote:
>> I spend most of my time working on pure 64 bit sparc linux. simply 
>> because that's where all the work is currently being done. That being 
>> said there are
>> noticeable speed improvements with some applications being 32 bit.
> 
> Where did I say that it is impossible to run 32-bit applications? I
> never claimed that!

I never claimed that either. The point was that i work on 64 bit because 
it's what being actively developed / need implemented if linux for sparc 
want to have a future.

> 
>> As far as I know Debian doesn't really have a way of managing 
>> something like that.Sure you can compile everything both 64 and 32 bit 
>> and install whichever you
>> want, but there's no way to really say one package should always be 32 
>> bit while another should always be 64 bit. Even if that did exist 
>> sparc is the only
>> architecture I'm aware of that would really benefit from it.
> 
> Except that Debian has the best mechanism to resolve that which is
> called Multi-Arch. You can install libraries
> and binaries of *any* architecture onto *any* machine. In fact, I am
> doing that to cross-compile things like
> GHC, see:
> 
>> https://wiki.debian.org/DebianPorts/BootstrappingGHC
> 

Again, you're missing the point i was trying to make. A default install 
of Solaris includes a mix of 32 bit / 64 bit binaries depending on what 
the applications needs are. I can't think of any Linux distro that does 
that. Using Debian amd64 as an example, you get a full 64 bit system 
until you add i386 as an arch and install what you need as i386 
binaries.

There is no way that i know of (short of doing it all by hand) to build 
a single repository that has 32 bit applications / libs for some things 
and 64 bit applications for others. Short of building such to tool, the 
only option is to have a full 64 bit or full 32 bit userland and allow 
the end user to use a different ABI per application if they wish.

If you build two repositories (one 32 bit and one 64 bit), there is no 
easy way to prefer 32 bit packages for some things and 64 bit packages 
for others. You can easily prefer entire repositories, but not each 
package within those repositories.

The point isn't whether you can install packages for both ABI's. The 
point is that there is no current way to have a mixed 32 bit / 64 bit 
userland by default that is optimized based on a applications needs. Not 
without doing a ton of work by hand.

>> My unofficial Gentoo ports support multilib for people wanting the 
>> best of both worlds. But making it a seemless experience providing the 
>> best performance based
>> on each applications needs is something that would take a ton of work. 
>> It may not even be possible with the current packaging system.
> 
> Multilib alone is an outdated and insufficient concept and the reason
> why we long had ugly solutions like ia32-libs
> in Debian which carried 32-bit versions of important libraries
> repackaged as 64-bit packages. These days, this has
> become completely redundant since you can just directly install i386
> packages on an amd64 system if you need 32-bit
> support on x86_64, for example.
> 

Debian's idea of multilib != Gentoo's idea of multilib. This is mostly 
because Gentoo doesn't distribute binaries (except in very rare cases).

Gentoo may have similar issues, but because all package are built from 
source i can just add "ABI=sparc32" to each package that doesn't need 64 
bit support.

> However, it doesn't end there. You can even go further and install
> i386 packages on a ppc64el machine and run them
> seemlessly there through qemu-user. Although we are currently missing
> up-to-date 32-bit sparc packages which you
> could install on sparc64 via MultiArch (unless you want to use the old
> ones), there is nothing that stops you from
> setting up a small mini-dinstall server, set up an sbuild schroot for
> sparc and build custom packages for sparc
> instead of sparc64.
> 

Gentoo offers the same, but again the solutions they offer aren't as 
robust because they don't have to deal with the whole binary package 
aspect. One repo is good for all archs.

> Thanks to the Debian rebootstrap project [1], we are constantly making
> sure that bootstrapping sparc on Debian will
> still be possible if required. The project is still under development,
> but it's already possible to just cross-
> bootstrap sparc with current packages on any host architecture.
> 
> Thus, I don't think any of the objections brought up against the
> sparc64 port are valid. Neither is sparc64 64-bit
> only nor does anyone anyhow prevent you in Debian to mix packages from
> different architectures. In fact, Debian
> has by far the most flexible approach to resolve the 32-bit/64-bit
> problem by providing a generic approach for
> mixing libraries of different architectures.
> 
> Adrian
> 
>> [1] https://jenkins.debian.net/view/rebootstrap/

This wasn't supposed to be a "64 bit vs 32 bit vs debian vs gentoo" 
post... I really don't care what other people run, you should just run 
what you want.

I was just trying to make a few simple points...

1. Oracle knows sparc32 is faster than sparc64, that's why nearly half 
of Solaris is 32 bit.

2. No Linux distribution has a solution in place for a default mixed 
userland based on application optimization.

3. While sparc32 maybe more efficient, it would be a ton of work to go 
through the entire repository to figure out which applications should be 
compiled as sparc64 by default. vice versa, going through a sparc64 
repository to figure out which applications should be compiled as 
sparc32 by default would probably be even more work.

4. A sparc64 userland is safer than a sparc32 userland as you can 
guarantee that all applications that need more than 4GB of memory will 
get it, even if applications that don't need it receive a small 
performance penalty. A sparc32 userland would deny additional memory to 
those applications unless someone has curated the ABI assignment for the 
entire repository or the user installs the sparc64 ABI version. When it 
comes to "just working", the former is likely preferred.

As a side note, I've had this discussion many times before and the idea 
of GCC optimizing sparc code to ilp32 when possible is probably the best 
idea i've seen brought up. Maybe one day...
