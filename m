From: "David S. Miller" <davem@redhat.com>
Date: Wed, 30 Jun 2004 20:54:19 +0000
Subject: Re: A question about PROT_NONE on Sparc and Sparc64
Message-Id: <20040630135419.25b843b8.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040630030503.GA25149@mail.shareable.org>
	<20040630082804.GS21264@devserv.devel.redhat.com>
In-Reply-To: <20040630082804.GS21264@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Jelinek <jakub@redhat.com>
Cc: jamie@shareable.org, wesolows@foobazco.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 04:28:05 -0400
Jakub Jelinek <jakub@redhat.com> wrote:

> I believe R!X and X!R pages ought to be possible on sparc64 too, just use a
> different bit as "read" in the fast ITLB miss handler from the one fast DTLB
> miss uses.

That's correct.  But I have no plans to implement this
any time soon :-)
