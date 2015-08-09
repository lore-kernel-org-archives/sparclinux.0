From: David Miller <davem@davemloft.net>
Date: Sun, 09 Aug 2015 22:19:18 +0000
Subject: Re: sparc64 function alignmnet (4 or 32)?
Message-Id: <20150809.151918.882252362196731958.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150809194524.GA23425@ravnborg.org>
In-Reply-To: <20150809194524.GA23425@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 9 Aug 2015 21:45:24 +0200

> When browsing sparc64 assembler I can see most
> handwritten assembler routines are aligned with ".align 32".

The required alignment is 4 bytes.

Some routines are aligned to 32 bytes in order to have them begin at
exactly an I-cache line boundary to increase I-cache utilization.
This is done especially for "hot" routines like memcpy, memset, etc.
