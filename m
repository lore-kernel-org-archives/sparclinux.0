From: Meelis Roos <mroos@linux.ee>
Date: Mon, 15 May 2006 08:12:22 +0000
Subject: 2.6.17-rc3+git seems to corrupt dpkg databases
Message-Id: <Pine.SOC.4.61.0605151108040.27015@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have Debian unstable on an Ultra 5. Generally it's running just fine.

Last week I had several cases of corruption in dpkg database (status and 
available files). These happened with different 2.6.17-rc3 + git 
kernels, the last tested kernel was 2.6.17-rc3-ge515f048 from May 9. 
Then I booted up Debian default kernels (2.6.16-1-sparc64) and it seems 
to work just fine, no corruption so far.

I suspected both dpkg and kernel but this seems to point finger to the 
side of kernel.

Maybe I can do some test (like finding where it stated) today evening 
GMT but I will be away at least tomorrow. Maybe I can test something on 
Wednesday evening again.

-- 
Meelis Roos (mroos@linux.ee)
