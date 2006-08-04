From: Marc Zyngier <maz@misterjones.org>
Date: Fri, 04 Aug 2006 18:08:20 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <wrpu04snzl7.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:

Daniel> Console: switching to mono PROM 80x34
Daniel> /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
Daniel> /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
Daniel> se@14,400000: ttyS0 at MMIO 0x1fff1400000 (irq = 7) is a SAB82532 V3.2
Daniel> Console: ttyS2 (SAB82532)
Daniel> SUNSAB baud:115200 quot:0
Daniel> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^this is added by me  as you want.

Ok, that's indeed what I suspected... Looks like the RSC setting have
some adverse effect on the uart_get_divisor() logic.

I'll try to give it a look.

Thanks for the report,

	M.
-- 
And if you don't know where you're going, any road will take you there...
