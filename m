From: Meelis Roos <mroos@linux.ee>
Date: Thu, 27 May 2004 16:00:43 +0000
Subject: Re: unkillable process in R state, 2.6.6
Message-Id: <E1BTNJD-0002k7-FX@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <20040520064141.GA30223@net-ronin.org>
In-Reply-To: <20040520064141.GA30223@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> Try enabling some debug options, like spinlock debug and such.
cb> 
cb> Enabled the following:
cb> 
cb> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
cb> CONFIG_PREEMPT=y
cb> CONFIG_DEBUG_KERNEL=y
cb> CONFIG_DEBUG_SLAB=y
cb> CONFIG_MAGIC_SYSRQ=y
cb> CONFIG_DEBUG_SPINLOCK=y
cb> CONFIG_DEBUG_SPINLOCK_SLEEP=y
cb> CONFIG_STACK_DEBUG=y
cb> CONFIG_MCOUNT=y
cb> CONFIG_FRAME_POINTER=y
cb> 
cb> 
cb> And it doesn't boot.

Same here on an UE2. Turned on spinlock debugging, gained no info.
Turned on stack debug:
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_DCFLUSH=y
 # CONFIG_DEBUG_INFO is not set
-# CONFIG_STACK_DEBUG is not set
+CONFIG_STACK_DEBUG=y
 # CONFIG_DEBUG_BOOTMEM is not set
+CONFIG_MCOUNT=y
+CONFIG_FRAME_POINTER=y

This causes lots of warning about undefined module symbols _mcount but I
tried the kernel anyway. This kernel does not load at all - the last
thing I see is SILO telling that it's loading the kernel.

-- 
Meelis Roos
