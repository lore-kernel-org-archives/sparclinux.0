From: Meelis Roos <mroos@linux.ee>
Date: Wed, 07 Apr 2004 16:16:31 +0000
Subject: Re: serial console confusion
Message-Id: <Pine.GSO.4.44.0404031650380.29798-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0404021400470.23192-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On the Ultra-5 (or almost any other PCI Ultra), you should use
> CONFIG_SERIAL_SUNSAB. su is used for keyboard I/O on this plateform.

What about 2.4 kernels? I can switch on sunsab serial ports and they are
detected fine but I cannot use them as serial console. PROM console
seems to work. Is this a 2.4 defficiency or have I overlooked something
more?

-- 
Meelis Roos (mroos@linux.ee)


