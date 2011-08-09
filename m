From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 09 Aug 2011 14:43:47 +0000
Subject: Re: [sparc] SunFire480R cassini network driver kernel panic
Message-Id: <20110809144347.GA2054@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Aug 09, 2011 at 06:16:25AM +0200, Jonathan Nieder wrote:
> It seems that the pata_cmd64x bug has been fixed.  cassini has received
> some fixes since 2.6.26, too, so if you get a chance to test 3.0.0-1,
> that would be interesting.

compiled and tested cassini in vanilla 3.0: Still crashing after ~10 pings 
with an 
  ERROR: System Hardware FATAL RESET from  CPU0

The kernel messages while inserting the cassini driver are appendend.
Please ask if you like to see the complete register dump after the
crash (or any other things).

Compiling vanilla 3.0.1 with 3.0.0 and will test for completeness. 
Is 3.0.0-1 already in the sid sparc repo ?

Thanks for the information and any help,
 Hermann

Aug  9 16:26:56 tantalus kernel: cassini: cassini.c:v1.6 (21 May 2008)
Aug  9 16:26:56 tantalus kernel: PCI: Enabling device: (0002:00:02.0), cmd 146
Aug  9 16:26:56 tantalus kernel: cassini 0002:00:02.0: eth0: Sun Cassini+ (64bit/33MHz PCI/Cu) Ethernet[24] 00:03:ba:29:7c:a0
Aug  9 16:26:56 tantalus kernel: PCI: Enabling device: (0003:00:01.0), cmd 146
Aug  9 16:26:57 tantalus kernel: cassini 0003:00:01.0: eth1: Sun Cassini+ (64bit/66MHz PCI/Cu) Ethernet[30] 00:03:ba:29:7c:9f
Aug  9 16:26:57 tantalus kernel: udev[917]: renamed network interface eth0 to eth19
Aug  9 16:26:58 tantalus kernel: udev[918]: renamed network interface eth1 to eth20

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
