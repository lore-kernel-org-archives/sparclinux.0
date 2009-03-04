From: Meelis Roos <mroos@linux.ee>
Date: Wed, 04 Mar 2009 11:22:21 +0000
Subject: esp scsi problem on shutdown - sunhme related?
Message-Id: <Pine.SOC.4.64.0903041320480.12608@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I successfully installed Debian Lenny with 2.6.26 kernel, later compiled 
> yesterdays 2.6.29-rc6+git. Both kernels have the same problem - on 
> shutdown, scsi disk goes offline like in console log below. This is 
> repeatable and happens every shutdown so far.

Testing by hand shows that 'ifconfig eth0 down' on eth0 (SBus hme) is 
the command that kills esp.

-- 
Meelis Roos (mroos@linux.ee)
