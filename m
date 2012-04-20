From: David Miller <davem@davemloft.net>
Date: Fri, 20 Apr 2012 07:06:07 +0000
Subject: Re: [PATCH 1/1] sparc32,leon: add notify_cpu_starting()
Message-Id: <20120420.030607.1891260321280604674.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120420033634.GA13068@zhy>
	<1334903312-18526-1-git-send-email-konrad@gaisler.com>
	<4F910312.3010900@gaisler.com>
In-Reply-To: <4F910312.3010900@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: konrad@gaisler.com
Cc: yong.zhang0@gmail.com, sam@ravnborg.org, a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, daniel@gaisler.com, yong.zhang@windriver.com

From: Konrad Eisele <konrad@gaisler.com>
Date: Fri, 20 Apr 2012 08:32:50 +0200

> Hello Yong,
> Thank you for the patch, it works. The SMP is fully
> functional again for sparc-leon. I just added a
> "#include<linux/cpu.h>"
> to avoid compiler warning.
> Please someone in the cc-list, apply.

I'll take care of it.
