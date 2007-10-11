From: Rob Landley <rob@landley.net>
Date: Thu, 11 Oct 2007 10:52:48 +0000
Subject: Scsi on sparc build break in 2.6.23.
Message-Id: <200710110552.49129.rob@landley.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-scsi@vger.kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

CONFIG_SCSI_SUNESP=y breaks the build in 2.6.23:

  LD      vmlinux
`scsi_esp_unregister' referenced in section `__ksymtab' of drivers/built-in.o: 
defined in discarded section `.exit.text' of drivers/built-in.o
make: *** [vmlinux] Error 1

Do you need my full .config to reproduce this?

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
