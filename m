From: Marc Zyngier <maz@misterjones.org>
Date: Fri, 04 Aug 2006 16:34:00 +0000
Subject: Re: serial console broken on Ultra 5
Message-Id: <wrpd5bgpiiv.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0607311538510.25364@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "Daniel" = Daniel Smolik <marvin@mydatex.cz> writes:

Daniel> TPC: <sunsab_convert_to_sab+0x184/0x220>

This looks weird to me.

Could you please print the 'baud' and 'quot' variables at the
beginning of sunsab_convert_to_sab? I suspect 'quot' being set to 0...

If possible, please try with gcc 4.0.x as well, it may help.

	M.
-- 
And if you don't know where you're going, any road will take you there...
