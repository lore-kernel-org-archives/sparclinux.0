From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 21 Jan 2011 00:40:03 +0000
Subject: physical_package_id on sun4v
Message-Id: <alpine.LNX.2.01.1101210131480.6015@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I notice that on the T1, the physical_package_id is the same as the core 
id:

01:36 ares:../system/cpu > grep '' cpu*/topology/physical_package_id
cpu0/topology/physical_package_id:0
cpu1/topology/physical_package_id:0
cpu10/topology/physical_package_id:2
cpu11/topology/physical_package_id:2
...

But as far as I can spot on the Eerie motherboard, there is just one 
copper heatsink block, and thus one CPU. (Besides that the T1 does not 
do SMP, so there can only be just one package.)

Did I get something wrong? Is perhaps the Machine Description not 
expressive enough to figure out how many packages (CPU sockets) there 
are?


thanks,
Jan
