From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 16 Sep 2004 06:00:32 +0000
Subject: Re: [SPARC32] sunzilog problems with lots of output at once
Message-Id: <20040916060032.GO9106@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cib9qa$elu$1@sea.gmane.org>
In-Reply-To: <cib9qa$elu$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Sep 15, 2004 at 10:54:14PM -0700, Joshua Kwan wrote:
> I'm experiencing a problem with the sunzilog driver on 2.6.8.1 on 
> sparc32. Recently I did:
> fantaisie:~# dmesg
> and the serial console stopped receiving output. I had to ssh in and 
> kill the parent process (bash) for things to start working again.
> Alternatively, ptracing the process was enough to un-wedge it. (strace 
> -p). Here are the first few lines of the strace output:
> # strace -p 966
> Process 966 attached - interrupt to quit
> ioctl(0, TCSETAF or SNDCTL_TMR_SELECT, {B38400 opost isig -icanon -echo 
> ...}) = 0
> ioctl(0, TCXONC, {B38400 opost isig icanon echo ...}) = 0
> ioctl(0, TCSETAF or SNDCTL_TMR_SELECT, {B38400 opost isig icanon echo 
> ...}) = 0

Can you make this happen with the console elsewhere (e.g. netconsole)
and try to capture some sysrq t output?


-- wli
