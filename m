From: Meelis Roos <mroos@ut.ee>
Date: Wed, 17 Sep 2008 09:25:02 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809171222400.22333@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Thank you! It cures the known-bad config with stack overflow detection 
> turned on. Instead of the hang, it now displays
[...] 
> Will try it against todays git next - expecting no surprises :)

And it works. Running todays 2.6.27-rc6+git + notrace patch + pci-psycho 
oops patch + hme debug patch from previous tries, with 
CONFIG-STACK_DEBUG=y and SMP.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
