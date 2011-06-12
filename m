From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 Jun 2011 01:01:06 +0000
Subject: Re: [PATCH] sparc, exec: remove redundant addr_limit assignment
Message-Id: <BANLkTikU44wjhzSLxP9XPcpsfkhQaGhayw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1307711453-17412-1-git-send-email-minipli@googlemail.com>
 <20110611.160842.2135350880385482648.davem@davemloft.net> <20110611234415.GE11521@ZenIV.linux.org.uk>
 <20110611.175834.1802167158365693401.davem@davemloft.net>
In-Reply-To: <20110611.175834.1802167158365693401.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: viro@zeniv.linux.org.uk, minipli@googlemail.com, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 11, 2011 at 5:58 PM, David Miller <davem@davemloft.net> wrote:
>
> The reason the test is only in this specific spot, is that's the only
> place where the optimization makes any sense.

Well, considering that it didn't make any sense there *either*, that's
kind of pointless.

We always had the unconditional "set_fs()" in the exec path. It only
got moved, and as part of that conscious effort, the pointless
architecture churn is getting cleaned up.

                         Linus
