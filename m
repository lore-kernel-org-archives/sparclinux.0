From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Thu, 10 May 2007 06:27:42 +0000
Subject: iptables throws unknown error - suspecting 32/64 compat issue
Message-Id: <Pine.LNX.4.61.0705100812440.32349@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Netfilter Developer Mailing List <netfilter-devel@lists.netfilter.org>
Cc: sparclinux@vger.kernel.org

Hi,


the following command gives an error:

	iptables -t mangle -I FORWARD -m conntrack --ctstate NEW

output is:

	iptables: Unknown error 4294967295

As mentioned in the topic, I suspect it is due to 32-bit iptables not 
coping correctly with the 64-bit kernel (sometimes, patches to fix these 
are posted, so I thought it could be related). OS is Aurora Linux 2.98, 
with their latest(?) kernel 2.6.20-1.2986.al3.3smp.


	Jan
-- 
