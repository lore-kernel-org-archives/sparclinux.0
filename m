From: David Miller <davem@davemloft.net>
Date: Fri, 26 May 2017 16:27:52 +0000
Subject: Re: [PATCH v3 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <20170526.122752.2059220237557272436.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1495721691.git.jag.raman@oracle.com>
In-Reply-To: <cover.1495721691.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 26 May 2017 11:51:38 -0400

> Would it be alright if these APIs could be defined but not exported
> until consumed?

Yes, but only if you put the drivers up somewhere (even if they currently
won't compile) so we can _see_ how these new APIs are used.
