From: "David S. Miller" <davem@redhat.com>
Date: Tue, 25 May 2004 17:55:55 +0000
Subject: Re: 2.6.6: compile error with spinlock debugging
Message-Id: <20040525105555.1b23b890.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0405121404550.3243-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 24 May 2004 14:41:13 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> Oops, I was wrong before and I _can_ reproduce it.

Thanks, I'm working on a fix.  There simply just isn't a debugging
version of that rwlock routing implemented.
