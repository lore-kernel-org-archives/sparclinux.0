From: David Miller <davem@davemloft.net>
Date: Sun, 12 Jun 2011 01:04:36 +0000
Subject: Re: [PATCH] sparc, exec: remove redundant addr_limit assignment
Message-Id: <20110611.180436.2125878475128439464.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110611234415.GE11521@ZenIV.linux.org.uk>
	<20110611.175834.1802167158365693401.davem@davemloft.net>
	<BANLkTikU44wjhzSLxP9XPcpsfkhQaGhayw@mail.gmail.com>
In-Reply-To: <BANLkTikU44wjhzSLxP9XPcpsfkhQaGhayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, minipli@googlemail.com, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Jun 2011 18:01:06 -0700

> We always had the unconditional "set_fs()" in the exec path. It only
> got moved, and as part of that conscious effort, the pointless
> architecture churn is getting cleaned up.

Sure.
