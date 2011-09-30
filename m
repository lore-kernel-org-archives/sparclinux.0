From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 30 Sep 2011 13:47:26 +0000
Subject: [PATCH 0/4] sparc32,leon: Uart polling support, KGDB with SPARC32 SMP.
Message-Id: <1317390450-5982-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317381862-24939-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317381862-24939-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Here are the patches again with fixes suggested by Julian Calaby:

0001-apbuart-add-polling-callbacks-to-apbuart-driver.patch adds polling functions
 to apbuart.c
0002-apbuart-add-support-for-virtual-KGDB-GRMON-channel.patch is a bit special: when
 the user doesnt have a hardware serial device he can use the debug monitor GRMON
 as a tunnel. GRMON will poll a memory region to put/get characters.
 => remove Lindent formating diffs
0003-sparc32-leon-Add-support-for-KGDB-when-SMP-and-SPARC.patch this adds KGDB when
 SMP is enabled. Inplemented only for SPARC_LEON, on other SPARC32 platforms KGDB
 wont still be enabled.
 => split into 2
0004-kernel-debug-SPARC-KGDB-stub-strcpy-fix.patch
 strcpy return value error fix
 
Greetings Konrad

