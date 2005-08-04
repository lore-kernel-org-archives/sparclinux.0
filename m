From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Date: Thu, 04 Aug 2005 14:24:46 +0000
Subject: Re: [PATCH] Remove errno declaration in drivers/sbus/char/envctrl.c
Message-Id: <20050804142445.GA32472@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20050804134803.GA32109@localhost>
In-Reply-To: <20050804134803.GA32109@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 04, 2005 at 07:12:26AM -0700, David S. Miller wrote:
> Where?  It _is_ defined in linux/unistd.h and the fact that
> we're indirectly getting that header file somehow is the
> source of the problem.

Yeah, I guess I shouldn't send emails early in the morning... :-)

> [snip]
> So you patch is not correct.
> 
> Probably the best version of the fix would be to include
> linux/unistd.h instead of asm/unistd.h, so you might want
> to code that up and test it out.

Ok, trying this out...

-- 
Mathieu Chouquet-Stringer
