From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Wed, 05 Sep 2012 15:46:09 +0000
Subject: Sun Fire 480 cassini crashs, Hardware Problem ?
Message-Id: <20120905154609.GA2493@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During revisiting the cassini crashes on the SunFire 480
I noticed two things while comparing with a machine which is
reportetly running with the build in cassini adapters 
(see http://bugs.debian.org/cgi-bin/bugreport.cgi?bugQ6785)

1) the cassini chips in my machines are rev 11, the others are rev 20
2) in the crash dump there are PERRs showing up.

Could this mean the rev 11 chips have a hardware quirk which
was fixed in later revisions ?

(The cassinis did run fine while the machines were used under solaris,
but former Sun would have probaly known how to programm around)

Receiving packets works fine for some time, transmitting did not work
and ends after a while with a Hardware fatal reset.

lspci output and a part of the crash is appended, more is available
if needed. Last test was with debian wheezy, before tried a 3.6rc kernel.
Test was done with 14M as on the working machine.

Thanks for any comments,
  Hermann

--------------------------
# lspci
0000:00:06.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 07)
0001:00:01.0 Ethernet controller: Intel Corporation 82545GM Gigabit Ethernet Controller (rev 04)
0002:00:01.0 Bridge: Oracle/SUN RIO EBUS (rev 01)
0002:00:01.3 USB controller: Oracle/SUN RIO USB (rev 01)
0002:00:02.0 Ethernet controller: Oracle/SUN Cassini 10/100/1000 (rev 11)
0003:00:01.0 Ethernet controller: Oracle/SUN Cassini 10/100/1000 (rev 11)
0003:00:02.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
--------------------------

ERROR: System Hardware FATAL RESET from  CPU2


System State (CPU3 reporting)
...
CPU2 Config/Control/Status registers: 

  CPUVersion:  003e.0015.2300.0507
  SafConfig:   1534.01bc.0005.0002
  SafBaseAdr:  0000.0400.0100.0000
  DCacheCtl:   0000.0000.0000.0000
  ECacheCtl:   0000.0000.0329.4400
  ECErrEnable: 0000.0000.0000.000b

  AFAR:        0000.07fc.0020.0000
  AFSR:        0008.0000.0000.0000 PERR
  AFAR 2:      0000.07fc.0020.0000
  AFSR 2:      0008.0000.0000.0000 PERR

  DMMU SFAR:   0000.0000.0009.b984
  DMMU SFSR:   0000.0000.0080.8004 TM W
  IMMU SFSR:   0000.0000.0080.8000 TM

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
