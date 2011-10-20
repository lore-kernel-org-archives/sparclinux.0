From: David Miller <davem@davemloft.net>
Date: Thu, 20 Oct 2011 08:47:20 +0000
Subject: Re: [PATCH 3/4] sparc32: return destination pointer on return from
Message-Id: <20111020.044720.1856580926397349482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1318489205-315-4-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318489205-315-4-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 20 Oct 2011 08:59:15 +0200

> Sorry to make you angry but, yes, I looked weather all registers are taken,
> and yes, memcpy is very compact programmed.

It took me 10 minutes to code up a fix.
