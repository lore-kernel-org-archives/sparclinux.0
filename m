From: Kent Tong <kent@cpttm.org.mo>
Date: Wed, 27 Jul 2005 10:31:35 +0000
Subject: eth0: TX MAC max packet size error
Message-Id: <42E76287.1010907@cpttm.org.mo>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm running Debian sarge (kernel 2.6.8-2-sparc64) on a
Sun Blade 100. I'm getting the following errors from
time to time:

Jul 27 14:22:37 cladms003 kernel: eth0: TX MAC max packet size error.
Jul 27 14:22:38 cladms003 kernel: eth0: TX MAC xmit underrun.
Jul 27 14:22:38 cladms003 kernel: eth0: TX MAC xmit underrun.

Once it happens, eth0 will be dead, eg, it won't respond
to ping or other connection attempts. It will work again
if I issue "/etc/init.d/network restart".

Any help would be much appreciated!

-- 
Kent Tong, Msc, MCSE, SCJP, CCSA, Delphi Certified
Manager of IT Dept, CPTTM
Authorized training for Borland, Cisco, Microsoft, Oracle, RedFlag & RedHat
