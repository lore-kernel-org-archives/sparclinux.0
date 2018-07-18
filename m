From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 18 Jul 2018 21:06:42 +0000
Subject: Re: FreePascal testsuite still triggers sparc64 kernel issues
Message-Id: <56de22c0-f333-dcfe-f1b2-44da59efd175@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <2fc3b653-d564-1013-6108-fe64fdd8122a@physik.fu-berlin.de>
In-Reply-To: <2fc3b653-d564-1013-6108-fe64fdd8122a@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Pierre!

On 07/18/2018 10:25 PM, Pierre Muller wrote:
> Maybe I was finally successful:
> 
>   stadler seems to have come into troubles after runing a single (faulty) executable
> 
> the executable is in
> /home/pierre/pas/test directory
> 
> its name is
> ./tweaklib2
> 
> it uses a (probably faulty) library called
> ./libtweaklib1.so
> 
> both are 64-bit executable generated with the current Free Pascal compiler
> on my account, located in directory
> /home/pierre/pas/fpc-3.1.1/bin/ppcsparc64 (cross compiler from 32 to 64 bit)
> 
> Last things I did was
> recompiling those two sources, using
> 
> pierre@stadler:~/pas/test$ ppcsparc64 -gl  tweaklib1.pp -k-rpath -k. -Cg -n -Fu../trunk/fpcsrc/rtl/units/sparc64-linux
> pierre@stadler:~/pas/test$ ppcsparc64 -gl  tweaklib2.pp -k-rpath -k. -Cg -n -Fu../trunk/fpcsrc/rtl/units/sparc64-linux
> 
> Running simply ./tweaklib2
> generated a SIGILL which stopped the program without any core generation...
> 
>   Running it inside gdb did not help,
> SIGILL was not caught by GDB :-(
> 
> Running it with strace generated this message:
> rt_sigaction(SIGBUS, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, NULL, 0xffff800100134ca8, 8) = 0
> rt_sigaction(SIGILL, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, NULL, 0xffff800100134ca8, 8) = 0
> 
> Message from syslogd@stadler at Jul 18 20:04:02 ...
>  kernel:[206085.986213] usercopy: Kernel memory exposure attempt detected from process stack (offset 0, size 128)!

Great. Looks like we have a reproducer for the kernel developers now :).

>   I tried to access via a second ssh session to the machine,
> but the session froze also, and I finally got completely kicked out,
> probably due to a system shutdown...
> 
>   This kernel crash might be easier to reproduce than any of what I got before ...
> 
>   I am still unable to reconnect to the machine,
> so maybe someone can resart the machine,
> and test if running the tweaklib2 in /home/pierre/pas/test directory
> several times or with strace is sufficient to get a 'reproducible' crash.
> 
>   In the hope that this will help,
Just did a hardware reset, should be back shortly.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
