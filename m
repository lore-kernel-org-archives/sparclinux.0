From: carbonated beverage <ramune@net-ronin.org>
Date: Sun, 23 May 2004 22:15:25 +0000
Subject: Re: unkillable process in R state, 2.6.6
Message-Id: <20040523221525.GA11324@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040520064141.GA30223@net-ronin.org>
In-Reply-To: <20040520064141.GA30223@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 21, 2004 at 11:08:05AM -0400, Ben Collins wrote:
> Try enabling some debug options, like spinlock debug and such.

Enabled the following:

CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_PREEMPT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_STACK_DEBUG=y
CONFIG_MCOUNT=y
CONFIG_FRAME_POINTER=y


And it doesn't boot.

After the Loading... at... message, it just sits there once the spinner goes
away.  The disk is pretty loud when accessed, so I know it's not even hitting
the disk.

I can't even break out into the OpenPROM prompt.

Ideas?

-- DN
Daniel
