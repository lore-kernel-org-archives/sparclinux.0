From: "David S. Miller" <davem@redhat.com>
Date: Thu, 19 Aug 2004 00:06:00 +0000
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040818170600.035e2345.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040818235528.GA8070@triplehelix.org>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joshua Kwan <joshk@triplehelix.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 16:55:28 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> I'm inclined to believe that the two bugs are related; these both happen
> with busybox-cvs and the exact same programs work with 2.4. Bastian
> Blank suggests that it is the compat wrapper for sys_mount that is not
> clean.

I think this analysis is faulty, all of the userspace accesses done
by the compat layer for sys_mount() are done exactly using the same
code the normal sys_mount() uses, namely copy_mount_options().
