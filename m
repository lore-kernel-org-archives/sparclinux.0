From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 17:01:06 +0000
Subject: Re: Best userland for sparc32?
Message-Id: <20120520170106.GA13900@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1205201859120.3202@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1205201859120.3202@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 20, 2012 at 07:07:03PM +0300, Meelis Roos wrote:
> I have not tested any sparc32 configs since Debian dropped sparc32. 
> However, I do have some hardware that I'd like to put to good use for 
> testing the sparc32 changes (SS10 SP, SS10 MP, SS10 4x100 Ross, SS20 
> (maybe SMP too), SS5 70 MHz stock CPU, SS5 with 170 MHz Fujitsu(?) CPU), 
> SS4, probably some lunchboxes too if I find some big enough working 
> HDD-s (LX, CLassic), ADEE S10Station (SS10 clone).

Better test coverage on sparc32 is very welcome!
I am sure you will hit some interesting issues...

> That leads to the question, what is the best userland to compile and run 
> sparc32 kernels? This probably means recent gcc & binutils, and that 
> they are routinely updated. I can ocassionally compile a binutils or a 
> gcc if it has been automated by someone else (like in gentoo), or better 
> use binary packages and update these. And I want to compile the kernels 
> on these machines themselves (as all my tect machines do), to have 
> better testing.
> 
> So, what distros do people suggest?

My personal setup is simple...
I used crosstool-ng to build my toolchainbased on gcc 4.5.2

I tested several gcc versions back then and this was the version that worked for me.
My userland is very simple.
I have used buildroot to build a rootfs with a minimal set of tools.
Mostly busybox.

Then I use tftpboot.img to do "boot net" so the image is fetched via tftp.
This allowed me to keep the solaris image on the disk.

I have several times thought about using a more complete distro - or just to add
tools in my buildroot image.
I would never try to build my kernel on the sparc boxes.. That just too painfull
an execise. But for testning you are right that it would be good.

So I am also eager to hear what people do suggest as I will likely try 
to upgrade my ss5 to a distro one day.

	Sam
