From: Meelis Roos <mroos@linux.ee>
Date: Fri, 02 Apr 2004 09:09:55 +0000
Subject: SILO 1.4.4 & Fast Data Access MMU Miss on tab completion
Message-Id: <Pine.GSO.4.44.0404021153540.23192-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have SILO 1.4.4-1 from Debian unstable installed on my U5. I use ext3
as the root filesystem. When I try to use tab completion for kernel
image files, SILO dies with Fast Data Access MMU Miss. Like, I type
1/boot/vm<TAB> and then it reports the error and drops to ok prompt.

-- 
Meelis Roos (mroos@linux.ee)


