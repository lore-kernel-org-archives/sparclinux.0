From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 02 Jun 2004 06:25:15 +0000
Subject: SOC & Pluto on 2.6
Message-Id: <200406020125.15813.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Has anyone tried to use SOC And Pluto to run a Sun Storage Array off of
an SOC (FC25/S) card?  I'm currently running 2.6.7-rc1 (but have had
the same thing happen with 2.4.26).  I get the following messages when
doing a modprobe soc (uncommented debug #defines in fc.c and pluto.c):
----------------------------------------------------------------
soc.c:v1.3 9/Feb/99 Jakub Jelinek (jj@ultra.linux.cz), Jirka Hanika
(geo@ff.cuni.cz)
FC: fcp_inititialize 02081860
FC: fc_channels 00000000
FC:  SID 1 DID 2
FC: FCP Init for 4 channels
FC: Initializing REPORT_MAP packets
FC: Sending REPORT_MAP/FLOGI/PLOGI packets
soc1 port A: SID 1 DID 2
soc1 port B: SID 17 DID 18
soc0 port A: SID 1 DID 2
soc0 port B: SID 17 DID 18
FC: Sending REPORT_MAP/FLOGI/PLOGI packets
FC: Cannot enque FLOGI/REPORT_MAP packet on soc1 port A
FC: Cannot enque FLOGI/REPORT_MAP packet on soc1 port B
soc0 port A: receive_solicited 0 0 0
soc0 port A: receive_solicited 0 0 0
FC: Login timeout
----------------------------------------------------------------
The lines after "soc0 port B: SID..." repeat several times.

I've got a card with a single GBIC in an SBUS slot, along with the
built-in SOC on the I/O board (this is an E3000).  When modprobing the
pluto driver, I get:

PLUTO: 0 channels online

Also, I noticed that soc.c doesn't compile when I uncomment its debug
#define.

The relevant .config part:

#
# Fibre Channel support
#
CONFIG_FC4=m

#
# FC4 drivers
#
CONFIG_FC4_SOC=m
CONFIG_FC4_SOCAL=m

#
# FC4 targets
#
CONFIG_SCSI_PLUTO=m
CONFIG_SCSI_FCAL=m

Any ideas?  Does anyone actually use this stuff on recent kernels, or at
all?  I tried to look for an FCode update for the soc card on Sun's
website, but am unable to find anything for the FC25/S.

Pat
--
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
