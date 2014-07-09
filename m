From: chase rayfield <cusbrar1@gmail.com>
Date: Wed, 09 Jul 2014 02:51:44 +0000
Subject: SILO on Qemu Sparc v8 unable to boot stripped kernel
Message-Id: <CACwypyMhN9fj34VmgiXEFNmH28up5if3wW_xajYOLy0kR2An5Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I emailed davem, last week and he told me the appropriate course of action
would be to message the list so here goes.

This is the error SILO in Qemu is printing out:
"ext2 superblock magic is wrong" ... then
"Cannot find a loadable segment in your ELF image."

 I stripped the kernel with  "strip -R .comment -R .note" also tried a myriad of
other options to the same effect. My build of Qemu can boot an older Gentoo
livecd that I have that is also 2.6.32 but I don't have a dot config
and it was built with
a different toolchain. Here are links to most of the relevant stuff if
you want my
catalyst spec files or for me to tar up my silo build etc... just ask.
I have real hardware I can test on but I'd rather not make coasters
especially since I know Qemu *can*
boot a sparc livecd no problem the same kernel version even.

Is is possible I have the kenrel arguments wrong or something of that nature?

The gentoo stage3 it is built from is here...
http://gh0stwriter.net/archive/20140708/stage3-sparc-20140628.tar.bz2
And portage snapshot:
http://gh0stwriter.net/archive/20140708/portage-20140628.tar.bz2
Known good iso:
http://www.gh0stwriter.net/archive/linux-sparc32-install-20111216.iso

You can grab a copy of the WIP iso here:
http://gh0stwriter.net/archive/20140708/install-sparc-minimal-20140620.iso
(includes the stripped kernel that fails to boot)

Unstripped kernel from the above iso
http://www.gh0stwriter.net/archive/20140708/gentoo.gz

My .config
http://gh0stwriter.net/archive/20140708/config-2.6.32-r41-20140708.config

Screenshot of silo failure:
http://gh0stwriter.net/archive/20140708/qemu-silo-fail.png
