From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 01 Feb 2011 21:52:51 +0000
Subject: Re: [PATCH 1/2] SPARC32: implement SMP IPIs using the generic functions
Message-Id: <AANLkTikSxjD5D_wBxhc3hejrd5gOcFVyUgP7cu0KD62m@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059911-22861-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Feb 2, 2011 at 07:34, David Miller <davem@davemloft.net> wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
> Date: Tue, 01 Feb 2011 08:41:51 +0100
>> This is already true, it can be located on any 256 Mbyte boundary. The
>> Kconfig options are only used to create the u-boot image, they do not
>> change the arch/sparc/boot/image in any way, just a matter of
>> convenience when creating the uImage similar to other architectures
>> which support u-boot.
>
> Ok, this is the part I didn't understand.

U-boot (I know because I'm grappling with it on an embedded ARM system
at the moment) is a boot loader that's essentially OF + GRUB in one
package. Modern versions of it peek into the disk and load Linux into
memory from some pre-determined file(s) then boot it in the normal
way. To do this it needs some more info than just the file names, e.g.
how big it is, where to load it and where to jump to, so it only loads
files that have a particular format, which is essentially the kernel /
initrd with an extra header.

The uImage target (if it's anything like the ARM one) sticks that
header on, nothing else, so the numbers that are being set in KConfig
are only changing variables in that header, not how the kernel is
compiled.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
