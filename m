From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Fri, 02 Apr 2004 12:07:51 +0000
Subject: Re: serial console confusion
Message-Id: <wrplllevazs.fsf@panther.wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>>>> "Meelis" = Meelis Roos <mroos@linux.ee> writes:

Meelis> With no PROM console, sun su & sun su console, I get the dmesg
Meelis> that is below. Where should I dig? Is serial console on su
Meelis> serial ports working for others?

On the Ultra-5 (or almost any other PCI Ultra), you should use
CONFIG_SERIAL_SUNSAB. su is used for keyboard I/O on this plateform.

Regards,

	M.
-- 
Places change, faces change. Life is so very strange.
