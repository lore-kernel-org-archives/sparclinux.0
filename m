From: Ralph Mitchell <rmitchell@eds.com>
Date: Tue, 27 Jan 2004 10:40:20 +0000
Subject: Re: Ultra5 + Linux kernel 2.6.1 =  hangs while booting
Message-Id: <40164014.2070400@eds.com>
List-Id: <sparclinux.vger.kernel.org>
References: <002801c3e2fb$d22e3c60$6400010a@goldeneye>
In-Reply-To: <002801c3e2fb$d22e3c60$6400010a@goldeneye>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I think I have the same problem.  I get the same boot messages, followed by:

    PROMLI

and there it stops.  Nothing else happens, no keys work, can't break 
into the OK prompt, have to power down to get its attention.

However, 2.6.0 *does* work, built from gentoo-dev-sources (actually 
2.6.0-gentoo-r1).

I've built 2.6.1 from gentoo-dev-sources & sparc-dev-sources, and I 
downloaded vanilla 2.6.1 from kernel.org.  None of them boot.

I just applied patch.2.6.2-rc2 and that didn't boot either.

I have an E450, 4x400MHz cpus, 4Gb mem, bunch-o-disks, quad hme and no 
display.  I'm using serial console, which works just fine in 2.6.0. 

Ralph Mitchell

Alex Smith wrote:

>(Also submitted to debian sparc list)
>
>Hi Everyone,
> 
>I currently have version 2.4.18 #2 of the kernel, which came when I
>installed Debian woody for Sparc.  Everything is 'stable', except for gcc
>and related packages which were upgraded to 'testing' (gcc 3.3.2).  I have
>been trying to compile a version of 2.6.1 for over a week with lots of
>problems and I'm finally stuck, exhausting the web and forums, and need some
>help.  
> 
>I have tried endless .config permutations, the most promising being the 2.6
>Ultra10 example from:
> 
>http://dev.gentoo.org/~ciaranm/configs/kernel/
> 
>It seems like a lot of people like me have trouble with the size of the
>kernel, and I can't ever use vmlinux, even compressed, so I follow these
>steps:
> 
>make menuconfig
>make
>make image
>make modules
>make modules_install
> 
>The arch/sparc64/boot/image is then placed in /boot (along with the new
>/boot/System.map) and added to silo.conf.
> 
>Whenever I try to boot to this from silo, I get:
> 
>      boot: linux6
>      Loaded kernel version 2.6.1
> 
>      Remapping the kernel... done.
>      Booting Linux...
> 
>Where it flashes the keyboard LEDs once, then appears to freeze
>indefinitely. I have tried many of the graphics modules, but is there one I
>need specifically?  How will my Ultra5 config need to be different from the
>Ultra10?  Should I go back to a 2.6 instead of 2.6.1?
> 
>Any ideas would be truly appreciated; I'm just tired of compiling.
> 
>Thanks,
> 
>      Alex Smith
>      ans1024@rit.edu
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>

