From: Xose Vazquez Perez <xose.vazquez@gmail.com>
Date: Tue, 21 Jun 2016 17:03:25 +0000
Subject: Re: [PATCH] sparc64: Swap registers for fault code and address in mna trap
Message-Id: <d2dceeba-439d-8325-9f77-e53ba13d1c1a@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <TYXPR01MB058946C0AC6B6523F82004FC99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
In-Reply-To: <TYXPR01MB058946C0AC6B6523F82004FC99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hisashi Kanda <hikanda@zlab.co.jp>, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hisashi Kanda wrote:

> In fact, BUG() in do_sparc64_fault occurred in modified version
> of linux-2.6.25.8 on SPARC64VIIIfx. I'm misunderstanding that
> the same problem remains in the latest.

Fujitsu K computer, with SPARC64 VIIIfx, runs a heavily modified
2.6.25.8 kernel. And maybe also binutils, glibc, gcc, gdb, ...
Even UTS_MACHINE was changed from sparc64 to s64fx.
