From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 30 Aug 2017 07:22:59 +0000
Subject: Re: RFC: Driver for Oracle Data Analytics Accelerator
Message-Id: <6064c0e0-fa3e-3aa6-e18b-41426511dd5a@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504049763-51918-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Rob!

On 08/30/2017 01:36 AM, Rob Gardner wrote:
> To answer the most obvious question "who will use this?", there is a
> companion userspace library which will be published under UPL
> shortly. This is a comprehensive collection of higher level functions
> along with tests and documentation. We'll include a link to this before
> the code is submitted as a patch.

Out of curiosity. Do you know what the current progress with the publication
of the patches for LDOM control support on Linux are? I have seen that Oracle
Linux now ships the LDOM utilities, so I assume that it is possible to run
Oracle Linux in the control domain. But since the sources are missing for
the LDOM packages in OL, it's not yet possible to package it for Debian.

It would be really nice to have Debian running in the control domain,
currently we're still running Solaris there on the SPARC T5 we have.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
