From: Marc Zyngier <maz@misterjones.org>
Date: Sat, 15 Jul 2006 07:39:47 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <wrp64hzgvuk.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060714.165308.83620688.davem@davemloft.net>
In-Reply-To: <20060714.165308.83620688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "David" = David Miller <davem@davemloft.net> writes:

David> Please reboot with of_debug=3 and send the logs here.  It's
David> almost certainly a bug in the psycho bus IRQ translater in
David> arch/sparc64/kernel/prom.c:psycho_irq_build()/psycho_irq_trans_init().
David> A good debugging log will give some clues.

I'm away from my machines for the week end (answering you mail through
my cell phone...) I'll be back tomorrow evening and will post the log
asap.

thanks again.

M.


-- 
And if you don't know where you're going, any road will take you there...
