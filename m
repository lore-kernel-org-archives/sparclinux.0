From: Marc Zyngier <maz@misterjones.org>
Date: Thu, 03 Aug 2006 11:33:51 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <wrpy7u6yrxc.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:

Daniel> I test 2.6.18-rc2 over rsc console and I see nothing after
Daniel> Uncompresing Linux.... With 2.6.17.2 work well. E250 Debian Sid.
Daniel> I will test 18rc-3 and see.

As David wrote, there was some fixes to E250 serial console introduced
between rc2 and rc3.

Please note that I didn't test RSC console though (I don't trust RSC
enough to let it handle my console directly, and I only use it to
power-on/reset the machine remotely).

	M.
-- 
And if you don't know where you're going, any road will take you there...
