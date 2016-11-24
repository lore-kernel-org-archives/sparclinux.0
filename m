From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 10:00:29 +0000
Subject: Re: SILO Issues on an E4900
Message-Id: <fd94534f-2e8e-3aa8-a0e1-f197a5b5e3f7@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
In-Reply-To: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Louis!

On 11/24/2016 10:35 AM, Louis Liu wrote:
> I boot with the latest debian sparc64 install image (2006-11-22), and
> have the same problem.
> 
> It looks like _start is placed on 0x4020?
> 
> Hope the following messages is helpful

Thanks for the feedback!

So, the problem is that while several patches for SILO and even GRUB exist which
improve these bootloaders on sparc64, none of them have actually officially been
merged yet.

For SILO, Oracle has created several patches which port SILO to 64-bit (I extracted
that patch and applied it to the Debian package) and other packages which improve
SILO on modern sun4v machines. I tried applying these patches as well, but I didn't
really understand them nor was I able to get them apply. These patches are part
of the SILO SRPM package [1] in Linux for SPARC. If anyone can get the patches
apply to SILO git [2], I'd be happy to apply them to the Debian package and rebuild
the installation images.

As for GRUB, all the patches for adding sparc64 support [3] have still not been
merged into GRUB upstream [4] despite two of the GRUB upstream developers working
for Oracle. I don't really understand why it takes them to long, but it's one of
the things that frustrates me most with the work on the sparc64 port.

There are actually several really good improvements made by very talented developers,
but instead of merging those and making these changes available for every sparc64
users, these patches don't get the attention they deserve :(.

Adrian

> [1] http://yum.oracle.com/repo/linux_sparc64/latest/silo-1.4.14-4.0.18.el6.src.rpm
> [2] http://git.kernel.org/cgit/linux/kernel/git/davem/silo.git
> [3] https://github.com/esnowberg/grub2-sparc
> [4] http://git.savannah.gnu.org/cgit/grub.git

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
