From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 27 Feb 2008 08:27:47 +0000
Subject: Re: [BUG] 2.6.25-rc3 hangs in early boot on Sun Ultra5
Message-Id: <18373.7939.475720.986369@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18371.10207.58819.188510@alkaid.it.uu.se>
	<18371.54294.748777.976300@harpo.it.uu.se>
	<20080226.164900.193701385.davem@davemloft.net>
In-Reply-To: <20080226.164900.193701385.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Tue, 26 Feb 2008 09:55:50 +0100
 > 
 > > Minor update: rc2-git7 has the slow initial console behaviour,
 > > but successfully switches to the framebuffer. rc2-git8 however
 > > hangs in the console handover. So I'll bisect git7->git8 next.
 > 
 > Between the VT layer registering it's console and the atyfb
 > driver initializing we get a crash, and it happens on all
 > sparc64 systems.  It is caused by this commit and I am working
 > on a fix:
 > 
 > commit a0c1e9073ef7428a14309cba010633a6cd6719ea
 > Author: Thomas Gleixner <tglx@linutronix.de>
 > Date:   Sat Feb 23 15:23:57 2008 -0800
 > 
 >     futex: runtime enable pi and robust functionality

My git7->git8 bisection yesterday independently also arrived
at that specific commit as being the culprit.

Bracketing the offending cmpxchg_futex_value_locked(NULL, 0, 0)
call with #if 0 .. #endif was enough to make my kernel boot.

I'll try your do_kernel_fault() patch later today.

/Mikael
