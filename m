From: Mitch Bradley <wmb@firmworks.com>
Date: Wed, 07 Oct 2009 22:50:59 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <4ACD1B53.1010906@firmworks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The Sun4 generations were (from memory):

sun4 - first generation SPARC, implemented as an FPGA.  IIRC, speeds 
topped out at about 20 MHz.  PCI bus.
sun4c - 2nd generation, implemented in CMOS.  SS1 and SS2 families.  
Desktop machines only.  Expansion via SBus. 40 to 80 MHz
sun4m - "SuperSPARC" - multiprocessor support.   TLB MMU
sun4d - "Sun Dragon".  Big iron, intended for high reliability.  Based 
on a bus architecture from Xerox PARC.
sun4u - UltraSPARC - 64-bit

There was also an ECL SPARC that never made it out of the lab.

