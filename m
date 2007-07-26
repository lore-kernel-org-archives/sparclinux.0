From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jul 2007 09:13:03 +0000
Subject: Re: section mismatch with serial console
Message-Id: <20070726.021303.69020157.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707261128020.17385@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707261128020.17385@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Jul 2007 11:29:10 +0300 (EEST)

> Got this on sparc64:
> 
> WARNING: vmlinux.o(.text+0x180b68): Section mismatch: reference to .init.text:add_preferred_console (between 'sunserial_console_match' and 'read_zsreg')

I know, it does this for all the sparc serial drivers with
enabled console and I haven't figured out a good way to fix
this yet :)
