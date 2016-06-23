From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jun 2016 08:30:14 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <ab240eda-0f8d-9ff0-47b4-c6e1de28476a@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/23/2016 07:54 AM, Alex McWhirter wrote:
> I spend most of my time working on pure 64 bit sparc linux. simply because that's where all the work is currently being done. That being said there are
> noticeable speed improvements with some applications being 32 bit.

Where did I say that it is impossible to run 32-bit applications? I never claimed that!

> As far as I know Debian doesn't really have a way of managing something like that.Sure you can compile everything both 64 and 32 bit and install whichever you
> want, but there's no way to really say one package should always be 32 bit while another should always be 64 bit. Even if that did exist sparc is the only
> architecture I'm aware of that would really benefit from it.

Except that Debian has the best mechanism to resolve that which is called Multi-Arch. You can install libraries
and binaries of *any* architecture onto *any* machine. In fact, I am doing that to cross-compile things like
GHC, see:

> https://wiki.debian.org/DebianPorts/BootstrappingGHC

> Gentoo also suffers from the same issue although its not as bad onsidering you can switch ABI's on the fly.

Debian isn't suffering from that. Your information is simply wrong.

> My unofficial Gentoo ports support multilib for people wanting the best of both worlds. But making it a seemless experience providing the best performance based
> on each applications needs is something that would take a ton of work. It may not even be possible with the current packaging system.

Multilib alone is an outdated and insufficient concept and the reason why we long had ugly solutions like ia32-libs
in Debian which carried 32-bit versions of important libraries repackaged as 64-bit packages. These days, this has
become completely redundant since you can just directly install i386 packages on an amd64 system if you need 32-bit
support on x86_64, for example.

However, it doesn't end there. You can even go further and install i386 packages on a ppc64el machine and run them
seemlessly there through qemu-user. Although we are currently missing up-to-date 32-bit sparc packages which you
could install on sparc64 via MultiArch (unless you want to use the old ones), there is nothing that stops you from
setting up a small mini-dinstall server, set up an sbuild schroot for sparc and build custom packages for sparc
instead of sparc64.

Thanks to the Debian rebootstrap project [1], we are constantly making sure that bootstrapping sparc on Debian will
still be possible if required. The project is still under development, but it's already possible to just cross-
bootstrap sparc with current packages on any host architecture.

Thus, I don't think any of the objections brought up against the sparc64 port are valid. Neither is sparc64 64-bit
only nor does anyone anyhow prevent you in Debian to mix packages from different architectures. In fact, Debian
has by far the most flexible approach to resolve the 32-bit/64-bit problem by providing a generic approach for
mixing libraries of different architectures.

Adrian

> [1] https://jenkins.debian.net/view/rebootstrap/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
