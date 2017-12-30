From: Anatoly Pugachev <matorola@gmail.com>
Date: Sat, 30 Dec 2017 12:05:46 +0000
Subject: Re: building debug version of klibc
Message-Id: <CADxRZqy1+ovSHdoUS+kr8=vMgLDmq+gmsz=uw2K=6JQzrxRYPQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqz24hXaLZzSgn=4ZC-Mj53ecbq7J=AcwxVyypU6eNQVqA@mail.gmail.com>
	<238034.1514635201@turing-police.cc.vt.edu>
In-Reply-To: <238034.1514635201@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernelnewbies@lists.kernelnewbies.org

On Sat, Dec 30, 2017 at 3:00 PM,  <valdis.kletnieks@vt.edu> wrote:
> On Sat, 30 Dec 2017 13:54:05 +0300, Anatoly Pugachev said:
>> Hello!
>>
>> Can someone please help me in building debug version of klibc ?
>>
>> I've cloned git://git.kernel.org/pub/scm/libs/klibc/klibc.git  , but
>> failed to build it with debug info
>>
>> added "-g" to HOSTCFLAGS in Makefile, but
>
> Hint:  HOSTCFLAGS is applied to code that needs to run on the machine that's
> doing the build, not the target code.  So for instance, if I'm cross-compiling on
> an x86_64       for an ARM target (which I do quite a bit, building Lede router images
> for my wireless), HOSTCFLAGS is applied to any x86_64 utility code that gets
> built.  I don't know what code is in klibc, but an example in the kernel source
> tree would be 'objtool' - that runs on the host system during the build, not at runtime.
>
>> I started to get segfault in fstype:
>
>> linux-2.6$ make install
> ...
>>  DEPMOD  4.15.0-rc5-00149-g5aa90a845892
>> sh ./arch/sparc/boot/install.sh 4.15.0-rc5-00149-g5aa90a845892 arch/sparc/boot/zImage \
>>        System.map "/boot"
>
> What directory did you do that in?  It looks like you're trying to install a whole
> new kernel image, not a new initramfs that has an updated klibc on it.

Valdis,

it's usual git kernel compile and install. And it's the first time I
started to get segfault from fstype.

git kernel from
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

local directory where do i build it is ~/linux-2.6 , my own config.
Worked fine for more than 100th times.
So, i'm doing "make modules_install && make install" in this directory
which doing right about to copy vmlinuz, System.map, kernel config
file to /boot and generate initrd there and updating boot loader
(grub2) config file.
