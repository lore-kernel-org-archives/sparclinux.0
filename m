From: David Miller <davem@davemloft.net>
Date: Tue, 15 Aug 2017 05:35:53 +0000
Subject: Re: [PATCH V3] vDSO for SPARC
Message-Id: <20170814.223553.2043404627456712062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1502400887-281290-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nick Alcock <nick.alcock@oracle.com>
Date: Fri, 11 Aug 2017 13:23:26 +0100

> unless you have a really serious linker bug,

Open your mind a little bit.

Maybe due to a bug in the Makefile the linker script doesn't get
used, or the wrong one is used.

Maybe parallel builds are not handled correctly.

Narrowly focusing on the linker file directly could compromise your
ability to diagnose this :-)

I'll try to look at this myself soon, I've been too busy to do so
lately.
