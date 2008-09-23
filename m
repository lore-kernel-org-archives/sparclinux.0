From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 23 Sep 2008 13:31:52 +0000
Subject: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dear list members,

while trying to run vanilla linux-2.6.26.5 or the debian etchnhalf kernel
(2.6.24.x) I noticed the cassini network driver for the builtin gigabit
network is unstable and brings the kernel down on a dualprocessor sparc
SunFire 480R with a Hardware FATAL RESET.

Serial output (until the System JTAG SCAN Dump from OBP starts) and 
the output of dmesg is attached. 
Please tell me what else would be useful for
debugging.

Thanks for any help,
 greetings
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
