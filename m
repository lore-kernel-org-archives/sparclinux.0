From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 08 Jun 2005 03:24:45 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <20050608032445.GC2264@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 6 Jun 2005, William Lee Irwin III wrote:
>> I got a bit heavy-handed as suggested and just blew away the whole lot
>> of macro wrappers etc. I did leave around some of the asm called from
>> there but am plotting to nuke them as well after making sure we aren't
>> trying to BTFIXUP code that doesn't exist.
>> Anyhow, if anyone's up for trying this (I patched vs. 2.6.12-rc5-mm2
>> but can rediff against 2.6.12-rc6 in the unlikely event it rejects)
>> I suspect it may help 32B alignment problems, though in principle
>> we could just perform the alignment checks.

On Tue, Jun 07, 2005 at 11:18:56PM -0400, Jurij Smakov wrote:
> I have tried the patch on 2.6.12-rc6 (it applies cleanly). The initrd is 
> mounted successfully then, however it oopses immediately after that. 
> Here's the log:
[...]

It seems like we get further. I've seen similar oopsen in tty_wakeup on
shutdown but am not terribly surprised if it could strike us earlier.
Anyhow, a regression test would be enlightening, as you say. I'll drop
it in favor of trying "safer" things in the event this is breaking it.


-- wli
