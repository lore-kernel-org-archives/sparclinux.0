From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 31 Jan 2004 03:17:21 +0000
Subject: Re: 2.6.x SMP RED_state in prom_startcpu()
Message-Id: <20040131031721.GE624@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040131025909.GD624@holomorphy.com>
In-Reply-To: <20040131025909.GD624@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 30, 2004 at 06:59:09PM -0800, William Lee Irwin III wrote:
>> Well, the bootlogs are rather uninteresting, but I've got a 2x u2 that
>> seems to drop into RED_state after calling prom_startcpu() on 2.6 (I
>> narrowed it down with prom_printf()'s). UP seems comes up fine. I sort
>> of flopped in an attempt to write a RED_state trap handler to get a
>> backtrace or determine the cause, so I'm punting for the moment.

On Fri, Jan 30, 2004 at 10:07:59PM -0500, Ben Collins wrote:
> Which 2.6? I have latest 2.6 from bk booting on my 2xU2 just fine.

bk from a couple of days ago. Sorry, I needed to put the compiler in.
I tried with gcc-3.3.2 and gcc-3.2.3 releases as i386-linux-gnu to
sparc64-unknown-elf cross-compilers.


-- wli
