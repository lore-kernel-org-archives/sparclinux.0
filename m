From: "David S. Miller" <davem@redhat.com>
Date: Fri, 09 Jan 2004 09:38:38 +0000
Subject: Re: [SPARC32] Fix irqaction sleep-in-lock
Message-Id: <20040109013838.2a8f3b18.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040109070822.GB22008@foobazco.org>
In-Reply-To: <20040109070822.GB22008@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 8 Jan 2004 23:08:22 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> This removes cli/sti from the irqaction allocation, and also prevents
> the allocation from sleeping while holding the lock.  This will only
> matter once we have modules working.  Dave, please apply if this looks
> ok.

Applied, thanks Keith.
