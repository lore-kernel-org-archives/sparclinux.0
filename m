From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Jul 2007 08:29:10 +0000
Subject: section mismatch with serial console
Message-Id: <Pine.SOC.4.64.0707261128020.17385@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Got this on sparc64:

WARNING: vmlinux.o(.text+0x180b68): Section mismatch: reference to .init.text:add_preferred_console (between 'sunserial_console_match' and 'read_zsreg')

-- 
Meelis Roos (mroos@linux.ee)
